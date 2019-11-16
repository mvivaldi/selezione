#!/bin/bash

########################################################################
#
# Autore: Matteo Cozzaglio
# Data: 16 Nov 2019
# Versione 1.0
# mail: matteocozzaglio@gmail.com
#
# Descrizione
#  Invio webhook in caso di errore 404
#
########################################################################

# Verifico quale sito ha ricevuto l'errore
sitePrefix="site_"
siteName=""

for name in {a..c}
do
    siteName="$sitePrefix$name"
    # Controllo Access ed error LOG
    access= `tail -n 1 "/var/log/apache/access_$siteName.log" | grep -i 404`
    error= `tail -n 1 "/var/log/apache/error_$siteName.log" | grep -i 404`
    
    # In caso sia presente l'acesso genero il webhook
    if [ $access -ne 0 ] 
    then
        accessString= echo $(date -u) " ACCESS: $siteName 404 access"
        curl -X POST -H 'Content-type: application/json' --data '{"text":"$accessString"}' http://webhook.local/pagina_404
        echo $accessString >> /var/log/webhook.log
    fi

# In caso sia presente l'errore genero il webhook
    if [ $error -ne 0 ] 
    then
        accessString= echo $(date -u) " ERROR: $siteName 404 access error"
        curl -X POST -H 'Content-type: application/json' --data '{"text":"$accessString"}' http://webhook.local/error_404
        echo $accessString >> /var/log/webhook.log
    fi


done