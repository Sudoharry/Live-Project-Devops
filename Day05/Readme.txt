Production Backup Rotation with Cronjob
----------------------------------------------------------------------------------------------
Below is a guide to setting up a production backup rotation with a cronjob on a Linux system.
This includes script creation, backup scheduling, and a rotation policy to manage storage.
-----------------------------------------------------------------------------------------------
1. Overview
Purpose: Automate backups with a rotation policy (e.g., retain only the last 5 backups).

Components:
A shell script to perform backups and enforce rotation.
A cronjob to schedule the script execution.

2. Create the Backup Script
Script Functionality
Create a compressed backup of the specified directory.
Save the backup with a timestamp.
Delete backups older than the specified retention period (e.g., 5 days).

Script on file: backup.sh

3. Set Up the Cronjob
What is Cron?
Cron is a Linux utility that schedules scripts or commands to run automatically at specified intervals.

Create a Cronjob:
 3.1) Open the cron editor:
  -crontab -e
 3.2) Add a cron entry to schedule the script. For example:
 - Run the backup every minute: 
    - * * * * * bash /home/ubuntu/Test4/backup.sh /home/ubuntu/Test4/data /home/ubuntu/Test4/backups
 3.3) Save and exit the editor.

  ------Explanation of Cron Fields-----
  * * * * *: at every minute.
  /path/to/backup.sh: Path to the backup script.
  >> /path/to/backup.log: Append the output to a log file.
  2>&1: Redirect errors to the same log file

4. Test the Setup
  4.1) Run the Script Manually:
      ./backup.sh
  4.2) Check the Backup Directory: Verify that a backup file is created and older backups are deleted according to the rotation policy.
  4.3) Check Cron Logs: View the cron execution log:
    grep CRON /var/log/syslog

5. Monitoring and Maintenance
   Log Monitoring: Review the log file periodically to ensure backups run successfully.
   Disk Space: Ensure sufficient space is available in the backup directory.
   Backup Restore Test: Regularly test restoring backups to ensure data integrity.
-----------------------------------------------------------------------------------------------------------------------------------------
Benefits
Automated backups reduce human error.
Rotation prevents storage overuse.
Log files provide clear insight into the backup status.
------------------------------------------------------------------------------------------------------------------------------------------







