#!/bin/bash

##declare script working directory
working_dir=</input/path/to/script/dir> ## provide absolute path to directory where script is stored without trailing /

##check for existing ip_list file and create one if needed
##
if [ -f $working_dir/ip_list.txt  ]; then
  echo "file exists" > /dev/null
else
  touch $working_dir/ip_list.txt
  dig +short myip.opendns.com @resolver1.opendns.com > $working_dir/ip_list.txt
fi


### declare variables - current public IP from openDNS & Last known IP from local list
current_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
known_ip=$(tail -1 $working_dir/ip_list.txt)

### Get Current Date and Time
timestamp=$(timedatectl | grep "Universal time:" | awk '{ print $3, $4, $5 }')

## check for existing log file and create one if needed
##
if [ -f $working_dir/log.txt  ]; then
  echo "file exists" > /dev/null
else
  touch $working_dir/log.txt
fi


##check for existing email file and create one if needed
##
if [ -f $working_dir/email.txt  ]; then
  echo "file exists" > /dev/null
else
  touch $working_dir/email.txt
fi

##compare known ip to current ip, compile email file and send update email as necessary, update ip_list, and log result.
##
if [ "$known_ip" = $current_ip ]; then
  echo "$timestamp: IP has not changed" >> $working_dir/log.txt
else
  echo "$timestamp: New IP = $current_ip" >> $working_dir/log.txt
  echo $current_ip >> $working_dir/ip_list.txt
  echo -e "Subject: IP Address Change\n" > $working_dir/email.txt
  tail -1 $working_dir/log.txt >> $working_dir/email.txt
  echo "Update VPN Clients" >> $working_dir/email.txt
  ssmtp youremail@email.com < $working_dir/email.txt ##provide the email that will receive the updates
fi


## ip_list.txt will carry a list of current and previous IPs. log.txt file contains a timestamp of last run, and the result. email.txt file is overwritten with new text each time it is sent. Email is only sent if IP changes.
