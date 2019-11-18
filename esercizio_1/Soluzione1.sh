#!/bin/bash
############################################################################################################
#
# Author: Danilo Sbordone
# Data: 18/11/2019
#
# Al fine di far avviare lo scritp allo startup si può spostare il file in /etc/init.d/ e creare un soft link 
# ln -s /etc/init.d/script1 /etc/rc.d/scritp1
# Script da inserire in crontab con cadenza ogni 10 sec oppure ogni minuto a differenz del paramentro presente nel calcolo del timestamp.
# Si poteva anche effettuare un ciclo while, ma in questi di solito, è indicato l'utilizzo di crontab.
#
#
#############################################################################################################

FILE=/var/log/repositorywebhook/webhook.log   #iniziazilizzazione variabile per il webhook
if test -f "$FILE"; then                      #verifica se il file di log del webhook esiste
    echo "$FILE exist"
else
    mdc=`touch "/var/log/repositorywebhook/webhook.log" ` #nel caso il file non esista, lo creae tramite touch. 
fi

filelist=` dir -a /var/log/apache2/acc*.log `          
tim=` date -R | awk -F ' ' '{ printf "%s%s%s%s%s%s%s\n", $2, "/",$3, "/", $4,":", $5 }'|rev|cut -c 2-|rev ` #si estrapola la data e l'ora corrente per non cercare log datati. La risoluzione con -c 2- e' ogni 10 sec- -c 3- e' al minuto.
for f in $filelist;
  do
     test=` cat $f |grep $tim |grep "404" `  # fa il grep del timestamp alla risoluzione scelta, e del 404
     if [ "$test" != " " ]; then
        curl -X POST -H 'Content-type: application/json' --data '{"$f $test": "$ "}' http://webhook.local/pagina_404   #invio del webhook.
        echo "$f $test" >> /var/log/repositorywebhook/webhook.log                                  #aggiornamento del file di log in append
     fi
  done

filerrors=` dir -a /var/log/apache2/err*.log `      #stessa logica per i file di log dell'errore
for f in $filerrors;
  do
     test=` cat $f |grep $tim |grep 404 `
     if [ "$test" != " " ]; then
        curl -X POST -H 'Content-type: application/json' --data '{"$f $test": "$ "}' http://webhook.local/error_404
        echo "$f $test" >> /var/log/repositorywebhook/webhook.log
     fi
  done
exit
