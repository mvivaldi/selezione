#!/bin/bash
############################################################################################################
#
# Author: Danilo Sbordone
# Data: 18/11/2019
# La traccia è poco chiara sui server. Cmq ipotizziamo che siano i primi 25 server di cui non sappiamo quale OS è installato. 
# Lo script andrà inserito in crontab per far si di verificare lo stato a cadenza temporale.
# Lo script richiama un altro script in python per l'invio delle email, in modo da utilizzare il protocollo TLS ed una casella email di cui si dispone l'account.
# Il file l'ho uplodato, ma è soltanto un esempio.
#
#############################################################################################################

FILE=/usr/controls/myprogram.conf.md5   #file che mantine lo stato del file di configurazione
if test -f "$FILE"; then                #test se è o meno presente il file
    echo "$FILE exist"                  
else
    mdc=`md5sum "/etc/myprogram.conf" ` #calcolo del md5 del file di configurazione nel quale il file non è presente 
    echo $mdc > /usr/controls/myprogram.conf.md5    #creazione del file di stato con l'hash md5
fi
   for servername in vm-{01..25}.fbk.com
     do
        app=0               #inizializzazione della variabile di stato per il servizio apache. E' reinizializzata per ogni server e quindi ad ogni ciclo
        test=`ssh user@$servername "uname -a | grep ubuntu| wc -l" `
          if [ "$test" -gt "0" ]; then
             app=`ssh user@$servername "sudo systemctl status apache2 |wc -l " `               
          else
             app=`ssh user@$servername "sudo systemctl status httpd | wc -l" `
          fi
          if [ "$app" -gt "0" ]; then
               app=`python notifybyemail.py -s "SERVICE HTTPD/APACHE DOWN SU $servername" -b "IL servizio HTTPD/APACHE è down sul server $servername. Intervenire" `
          fi
     done

mdc=`md5sum "/etc/myprogram.conf" `   #calcola l'hash del file
mdc_old=`cat /usr/controls/myprogram.conf.md5` #legge l'hash precedente
if [ "$mdc" != "mdc_old" ]; then   #Compara gli hash. 
    app=`python notifybyemail.py -s "myprogram.conf change configuration" -b "IL file myprogram.conf ha cambiato la sua configurazione. Verificare" `
fi
exit



