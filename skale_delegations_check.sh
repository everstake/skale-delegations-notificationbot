#!/bin/bash
sendmessage() 
{
        for ID in $CHATIDS; do
                curl -s -X POST https://api.telegram.org/bot$BOTKEY/sendMessage -d chat_id=${ID} -d text="$1" -d parse_mode="html"
        done
}

delegate_check () 
{
   for STATUS in $STATUSES; do
      DELEGATIONS=$(sk-val validator delegations $VALID | grep "$STATUS" | awk '{print $3}' | sed 's/$/\n/');
      for DEL in $DELEGATIONS; do
         NUM=$(sk-val validator delegations $VALID | grep "$DEL" | sed 's/$/\n/');
         if [ -z $DEL ]; then
            :
         elif [ "$DEL" == "PROPOSED" ]; then
            sendmessage "👀 NEW SKALE DELEGATIONS %0A%0A $NUM"
         elif [ "$DEL" == "UNDELEGATION_REQUESTED" ]; then 
            sendmessage "👀 NEW SKALE UNDELEGATIONS %0A%0A $NUM"
         fi
         break
      done       
   done
}

CONFIG="skale_delegations_bot.ini"
while true; do
   CHATIDS=$(cat ${PWD}/${CONFIG} | grep -v "#" | grep "CHATIDS" | awk -F "=" '{print $2}');
   BOTKEY=$(cat ${PWD}/${CONFIG} | grep -v "#" | grep "BOTKEY" | awk -F "=" '{print $2}');
   STATUSES=$(cat ${PWD}/${CONFIG} | grep -v "#" | grep "STATUSES" | awk -F "=" '{print $2}');
   VALID=$(cat ${PWD}/${CONFIG} | grep -v "#" | grep "VALID" | awk -F "=" '{print $2}');
   delegate_check
   sleep 14400;
done
