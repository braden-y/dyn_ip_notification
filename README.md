# dyn_ip_notification

##About
Bash script
Written for Ubuntu Server 22.04

Tracks changes in dynamic public IP, and sends an email notification.

Developed for my home-lab as the first in a series of notification scripts.
Intended to update me on IP changes so that I can update my VPN clients.

The same could be accomplished by using a Dynamic DNS service, however, this is perfectly sufficient for my needs.


## Necessary alterations for script to function properly
It is best to place the script in a directory where it will stay permanently.
Update the $working_dir variable in the script with the absolute path to the location where the script is stored.
Provide the email(s) you wish to receive updates within the script (see script notes for location, if you are providing mulitiple email addresses, just copy that line of script with additional email addresses within the same if-else statement.)

## Package Requirements
Requires the installation and configuration of "ssmtp."
Configuring ssmtp with a gmail account is simple, and has been working great.
Best practice would be to create a new gmail account specifically for this purpose.


## Additional Info
Initial email is marked as spam, after marking as "not spam" I receive all future mail to my primary inbox with no issues.

After installation and configuration of ssmtp, the script does NOT require root privileges.

Set as a user cronjob to run once a day. 0 12 * * * /path/to/script

The same concept can be applied to generate notifications for many events.
