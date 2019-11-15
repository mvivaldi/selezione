#!/bin/bash
# Nome:         monitorfile.sh
# Autore:       Matteo Pastorelli
# Data:         13/11/2019
# Versione:     1.0
# Utilizzo:     Per lanciare script al boot il file start-monitoring deve essere inserito nella dir /etc/init.d e va aggiornato rc.d con update-rc.d
#               Per utilizzo singolo : nohup monitorfile.sh > /var/log/nohupmonitorfile.log &
#
# Note:
# Modifiche:

# Inizializzazione Variabili
FILE_LOG1=/var/log/apache/access_site_a.log
FILE_LOG2=/var/log/apache/access_site_b.log
FILE_LOG3=/var/log/apache/access_site_c.log

webhooklog=/tmp/webhook.log

#Verifica della presenza dei file di log
if [ -e $FILE_LOG1 ]; then
        echo $FILE_LOG1 ":file presente"
fi
if [ -e $FILE_LOG2 ]; then
        echo $FILE_LOG2 ":file presente"
fi
if [ -e $FILE_LOG3 ]; then
        echo $FILE_LOG3 ":file presente"
fi

tail -f $FILE_LOG1 -f $FILE_LOG2 -f $FILE_LOG3 | while read LINE; do

        if echo $LINE | grep -q '" 404 ' ; then
                echo "Errore 404 -- $LINE" >> $webhooklog
                curl -i http://webhook.local/error_404
        elif echo $LINE | grep -q '/404.html' ; then
                echo "Pagina 404 -- $LINE" >> $webhooklog
                curl -i http://webhook.local/pagina_404
        fi

done
