#!/bin/bash

########################################################################
#
# Autore: Matteo Cozzaglio
# Data: 13 Nov 2019
# Versione 1.0
# mail: matteocozzaglio@gmail.com
#
# Descrizione
#  Esecuzione remota di uno script sui vari server
#
########################################################################

# Radice nome server
serverRadix="vm_"

for i in 0{1..9} {10..50}
do
	# Creo il nome del server
	serverName="$serverRadix$i"
	echo "Installazione apache sul server $serverName"
	# Eseguo lo script in remoto - DEVE ESSERE INSTALLATA LA CHIAVE SSH SUL SERVER REMOTO
	ssh root@${serverName} 'bash -s' < ./install_apache.sh
done

