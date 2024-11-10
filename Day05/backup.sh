
#!/bin/bash

# This is a script for backup with 5 days rotation

# Usage:
# ./backup.sh <path to your source> <path to backup folder>

       function display_usage {
           echo "Usage: ./backup.sh <path to your source> <path to backup folder>"
       }

    # Check if correct number of arguments are provided
           if [ $# -ne 2 ]; then
            display_usage
            exit 1
           fi

            source_dir=$1
            backup_dir=$2
            timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
           
            # Check if source directory exists
            if [ ! -d "$source_dir" ]; then
             echo "Error: Source directory '$source_dir' does not exist!"
             exit 1
            fi

            # Check if backup directory	 exists, create if not
            if [ ! -d "$backup_dir" ]; then
               echo "Backup directory does not exist, creating it"
	       mkdir -p "$backup_dir"
            fi

	     function create_backup {
            # Creating a backup zip
              zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null
                  
              if [ $? -eq 0 ]; then
                                      
                 echo "Backup generated successfully for ${timestamp}" 
       	       else
                 echo "Backup failed!"
               exit 1
              fi
             }
            # Backup rotation: Delete backups older than 5 days
                find "$backup_dir" -type f -name "backup_*.zip" -mtime +5 -exec rm {} \;
             	 echo "Removed backups older than 5 days."


	    #Function to perform rotation
	      function perform_rotation {

		      #Get the list sorted by time, most recent first
		      backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))
		       

	              #Check if there are more than 5 backups
		      if [ "${#backups[@]}" -gt 5  ]; then
        		      echo "Performing rotation for 5 days"

			      # Remove backups older than 5 days (we start removing from the 6th backup onwards)
		              for backup in "${backups[@]:5}"; do
   	 		     #  echo "Removing old backup: $backup"
	                       rm -f "$backup"
			       done
	              fi       
	      }
              create_backup
	      perform_rotation

