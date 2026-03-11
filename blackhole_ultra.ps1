# =========================
# BLACKHOLE_ULTRA.ps1
# enterprise storage destroyer, you have been warned 1000 times.
# written by "That IT Guy"
# ========

$log="C:\Windows\Temp\blackhole_ultra_log.txt"
$report="C:\Windows\Temp\blackhole_ultra_report.txt"
$user=$env:USERNAME
$pc=$env:COMPUTERNAME
$profile=$env:USERPROFILE
$docs="$profile\Documents"

function logthis($t){
$date=Get-Date
"$date --- $t" | Out-File $log -Append
}

Add-Type -AssemblyName PresentationFramework

[System.Windows.MessageBox]::Show(
"ATTENTION

Your computer drive is full.....again.

The IT department is performing automatic cleanup.

Files not in 'My Documents' may be relocated or purged.

If I have to come back here again there will be nothing left.

You have 30 seconds.

Respectfully,
IT",
"IT STORAGE ENFORCEMENT",
"OK",
"Warning"
)

Start-Sleep 30

logthis "BLACKHOLE ULTRA started on $pc user $user"

# move stuff to documents (hopefully)
$folders=@("Desktop","Downloads","Pictures","Videos","Music")

foreach($f in $folders){

$p="$profile\$f"

if(Test-Path $p){

logthis "looking in $p"

Get-ChildItem $p -Force -ErrorAction SilentlyContinue | ForEach-Object {

$dest="$docs\" + $_.Name

try{
Move-Item $_.FullName $dest -Force -ErrorAction Stop
logthis "moved $($_.FullName)"
}
catch{
logthis "couldnt move so deleting $($_.FullName)"
Remove-Item $_.FullName -Force -Recurse -ErrorAction SilentlyContinue
}

}

}

}

# kill giant files outside documents
logthis "looking for giant files"

$giant = Get-ChildItem C:\Users\$user -Recurse -ErrorAction SilentlyContinue |
Where-Object { $_.Length -gt 500MB }

foreach($g in $giant){

if($g.FullName -notlike "*Documents*"){

try{
Remove-Item $g.FullName -Force -ErrorAction SilentlyContinue
logthis "deleted giant file $($g.FullName)"
}
catch{
logthis "could not delete $($g.FullName)"
}

}

}

# clean temp junk
logthis "cleaning temp"
Remove-Item "$profile\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# browsers
logthis "cleaning chrome edge caches maybe"

Remove-Item "$profile\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$profile\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue

# teams cache
logthis "cleaning teams junk"
Remove-Item "$profile\AppData\Roaming\Microsoft\Teams\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue

# outlook cache
logthis "cleaning outlook junk"
Remove-Item "$profile\AppData\Local\Microsoft\Outlook\*.ost" -Force -ErrorAction SilentlyContinue

# recycle bin
logthis "emptying recycle bin"
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

# windows temp
logthis "cleaning windows temp"
Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# windows update
logthis "cleaning windows update downloads"

Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service wuauserv

# DISM cleanup
logthis "running dism cleanup"

Start-Process dism.exe -ArgumentList "/online /cleanup-image /startcomponentcleanup /quiet" -Wait

# check documents size
$size=(Get-ChildItem $docs -Recurse -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum
$gb="{0:N2}" -f ($size / 1GB)

"$user on $pc has $gb GB inside Documents after BLACKHOLE" | Out-File $report -Append

logthis "BLACKHOLE ULTRA finished"

[System.Windows.MessageBox]::Show(
"Cleanup finished.

Please store files in:

$docs

Other folders may be automatically cleaned again.

Have a nice day.

- IT",
"BLACKHOLE COMPLETE",
"OK",
"Information"
)