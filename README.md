# 🚀 Automated Linux RAM Monitor & Email Alerter

## 📌 Project Objective
When managing Linux environments, memory spikes can silently crash services before an administrator even notices. I built this lightweight, automated Bash script to monitor server health 24/7. If the available RAM drops below a critical threshold, the system proactively triggers an email alert to the admin, allowing for intervention *before* a server crash occurs.

## 🛠️ Environment & Workflow
* **Environment:** AWS EC2 Instance (Linux)
* **Email Client:** `ssmtp` and `mailutils`
* **Automation:** `cron` jobs
* **Scripting:** Bash

**How it works:**
1. **Extraction:** The `ram_status.sh` script extracts real-time memory data using the `free -m` command.
2. **Automation:** Configured via `crontab` to execute seamlessly in the background every 5 minutes.
3. **Alerting:** Validates the memory threshold and securely routes an alert via Google's SMTP server if limits are breached.

## 🧠 Challenges & Technical Solutions

During development, I encountered and resolved several real-world infrastructure challenges:

* **Challenge 1: SMTP Security Blocks**
  * *Issue:* Modern email providers block standard login attempts from Linux terminals for security reasons.
  * *Solution:* Bypassed standard authentication by enabling 2-Step Verification and generating a dedicated 16-digit "App Password". Integrated this securely into the `/etc/ssmtp/ssmtp.conf` file.
* **Challenge 2: Inaccurate Memory Monitoring**
  * *Issue:* Initially, the script monitored "Free" RAM, which is notoriously misleading in Linux due to caching. 
  * *Solution:* Rewrote the data extraction logic to specifically target "Available" RAM (Column 7) using `awk 'NR==2{print $7}'`. This ensures highly accurate monitoring.
* **Challenge 3: "Non-Zero Status" Mail Errors**
  * *Issue:* The terminal threw routing errors when executing the mail command.
  * *Solution:* Debugged the `ssmtp` configuration file, removed trailing spaces in the `AuthPass` variable, and enforced TLS encryption by adding `UseSTARTTLS=YES`.

## 📈 Impact & Results
* **Proactive Management:** Transforms server monitoring from reactive to proactive.
* **Zero Manual Checks:** Eliminates the need for admins to manually run `free -m` daily.
* **High Availability:** Significantly boosts server reliability by catching memory leaks and load spikes instantly.

---
*Built with 💻 by Muhammad Ali*
