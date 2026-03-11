# blackhole-ultra
Aggressive Windows disk cleanup script for enterprise environments

Because sometimes **"my hard drive is full"** happens one too many times.

---

## Overview

BLACKHOLE is an aggressive PowerShell cleanup script designed for Windows 10 and Windows 11 environments where disk space issues are frequently caused by:

* massive Downloads folders
* abandoned ISO files
* Teams / browser caches
* temporary files
* PST archives
* users storing movies on work machines

The script relocates user files into **Documents**, removes large files outside protected directories, and performs system cleanup to reclaim disk space.

---

## Philosophy

In many environments, IT repeatedly receives tickets that say:

> "My hard drive is full again."

BLACKHOLE solves this problem automatically.

And if that doesn't work:

> **"If I have to come back here there will be nothing left."**

---

## Operational Modes

BLACKHOLE supports three operational tiers.

| Mode     | Description                                |
| -------- | ------------------------------------------ |
| LITE     | Basic cleanup (temporary files and caches) |
| STANDARD | Moves files to Documents and removes junk  |
| ULTRA    | Aggressive enterprise cleanup              |

Currently implemented:

```
ULTRA
```

The other modes exist for documentation purposes.

---

## BLACKHOLE ULTRA

BLACKHOLE_ULTRA performs aggressive cleanup including:

* Moving files from Desktop, Downloads, Pictures, Videos, Music → Documents
* Removing files larger than **500MB outside Documents**
* Clearing browser caches
* Clearing Microsoft Teams cache
* Clearing Outlook cache
* Cleaning Windows temporary files
* Cleaning Windows Update download cache
* Running Windows component cleanup (DISM)
* Emptying the recycle bin
* Generating a cleanup log and report

Typical disk recovery:

```
20GB – 80GB per machine
```

---

## Example Output

```
BLACKHOLE ULTRA started
Scanning for large files...
Removed: C:\Users\Bob\Downloads\ubuntu.iso
Removed: C:\Users\Bob\Videos\movie.mp4
Cleaning Teams cache...
Cleaning Windows temp...
Running Windows component cleanup...

Recovered 37.2 GB
```

---

## User Warning Message

Users will see:

```
ATTENTION

Your computer drive is full.

The IT department is performing automatic cleanup.

Files not in 'My Documents' may be relocated or removed.

If I have to come back here there will be nothing left.

You have 30 seconds.

Respectfully,
IT
```

---

## Files

```
blackhole_ultra.ps1
```

---

## Usage

Run from PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File blackhole_ultra.ps1
```

Recommended deployment methods:

* Microsoft Intune
* Group Policy scheduled task
* Endpoint management tools
* Manual execution by administrators

---

## Logs

The script generates logs here:

```
C:\Windows\Temp\blackhole_ultra_log.txt
C:\Windows\Temp\blackhole_ultra_report.txt
```

---

## Warning

BLACKHOLE_ULTRA performs aggressive cleanup.

Actions include:

* deleting files larger than 500MB outside Documents
* clearing caches
* removing temporary files
* running system cleanup tools

Always test before enterprise deployment.

The author is not responsible for:

* missing ISO collections
* deleted movie libraries
* angry users

---

## Roadmap

Future modes may include:

```
BLACKHOLE LITE
BLACKHOLE STANDARD
BLACKHOLE EXTREME
BLACKHOLE HR EDITION
BLACKHOLE EXECUTIVE MODE (disabled by default)
```

---

## License

MIT License
