#!/bin/bash 
sendmessage() 
{
        for ID in $CHATIDS; do
                curl -s -X POST https://api.telegram.org/bot$BOTKEY/sendMessage -d chat_id=${ID} -d text="$1" -d parse_mode="Markdown"
        done
}

delegate_check () 
{
   NEWDELEGATIONS=$(sk-val validator delegations $VALID | grep "$STATUS" | sed 's/$/\n/');
   if [ -z $NEWDELEGATIONS ]; then
      :
   else
      sendmessage "👀 NEW SKALE DELEGATIONS %0A%0A $NEWDELEGATIONS"
   fi
}

CONFIG="skale_delegations_bot.ini"
while true; do
   CHATIDS=$(cat ${PWD}/${CONFIG} | grep -v "#" | grep "CHATIDS" | awk -F "=" '{print $2}');
   BOTKEY=$(cat ${PWD}/${CONFIG} | grep -v "#" | grep "BOTKEY" | awk -F "=" '{print $2}');
   STATUS=$(cat ${PWD}/${CONFIG} | grep -v "#" | grep "STATUS" | awk -F "=" '{print $2}');
   VALID=$(cat ${PWD}/${CONFIG} | grep -v "#" | grep "VALID" | awk -F "=" '{print $2}');
   delegate_check
   sleep 14400;
done
