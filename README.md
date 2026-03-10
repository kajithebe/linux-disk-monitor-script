# Disk Space Monitoring & Cleanup Script

A Bash shell script that monitors disk usage on a Linux system and automatically cleans up temporary files when usage exceeds a defined threshold.

> **Course:** RH124 & RH134 | Red Hat Academy | Metropolia University of Applied Sciences  
> **Author:** Kaji Thebe, Miraj Shrestha

---

## What It Does

- Checks the current disk usage of the root filesystem (`/`)
- Compares it against a configurable threshold (default: **80%**)
- If usage exceeds the threshold, it automatically deletes temporary files in `/tmp`
- Logs all activity with timestamps to a unique log file per run at `/var/log/disk_monitor_<timestamp>.log`

---

## Script Structure

| Function             | Purpose                                                                                  |
| -------------------- | ---------------------------------------------------------------------------------------- |
| `log_message()`      | Prints a timestamped message to the screen and appends it to the log file using `tee -a` |
| `check_root()`       | Ensures the script is run as root — exits with an error if not                           |
| `check_disk_usage()` | Gets current disk usage via `df` and `awk`, triggers cleanup if above threshold          |
| `cleanup_disk()`     | Deletes all files inside `/tmp` to free up space                                         |

---

## Requirements

- Linux system (tested on Red Hat / Ubuntu)
- Bash shell
- Root (`sudo`) privileges

---

## How to Run

**1. Clone the repository**

```bash
git clone https://github.com/kajithebe/linux-disk-monitor-script.git
cd linux-disk-monitor-script
```

**2. Make the script executable**

```bash
chmod +x disk_monitor.sh
```

**3. Run the script as root**

```bash
sudo ./disk_monitor.sh
```

---

## Example Output

When disk usage is within the safe limit:

```
[2026-03-10 09:55:36] Current disk usage: 22%
[2026-03-10 09:55:36] Disk usage is within the safe limit.
```

When disk usage exceeds the threshold:

```
[2026-03-10 09:55:36] Current disk usage: 85%
[2026-03-10 09:55:36] Warning: Disk usage exceeded the threshold of 80%.
[2026-03-10 09:55:36] Starting cleanup of /tmp...
[2026-03-10 09:55:36] Cleanup complete: temporary files removed from /tmp.
```

---

## Log Files

Each run creates a separate log file named with the timestamp of that run:

```
/var/log/disk_monitor_2026-03-10_09-55-36.log
```

This means every run is recorded independently — old logs are never overwritten.

---

## Configuration

You can adjust the threshold at the top of the script:

```bash
THRESHOLD=80   # Alert and cleanup if disk usage exceeds this percentage
```
