#!/bin/bash

########################################################################
#
# Autore: Matteo Cozzaglio
# Data: 13 Nov 2019
# Versione 1.0
# mail: matteocozzaglio@gmail.com
#
# Descrizione
#  Installazione del pacchetto apache su server Linux. 
#  In caso di sistema ubuntu viene esguito apt mentre per redhat yum
#
########################################################################

# Leggo il contenuto del file os<F4>release
osVersion="/etc/os-release"
osOk=$true

# Parte dichiarazione messaggi
progressString="Procedo con l'installazione del pacchetto"
endProgress="Installazione terminata"
endSciptOk="Esecuzione terminata"
endScriptNo="Sistema non supportato"


# Controllo il sistema operativo ed effettuo l'installazione del pacchetto richiesto
if grep -q ubuntu "$osVersion"; then
	echo "Rilevato Ubuntu...."	
	apt update
	echo "$progressString"
	apt -y install apache2
	echo "$endProgress"
elif grep -q red "$osVersion"; then
	echo "Rilevato Redhat..."
	echo "$progressString"
	yum -y install httpd
	echo "$endProgress"
else
	# In questo caso non effettuo alcuna operazione
	echo "$endScriptNo"
	osOk=$false
fi


if [$osOk -eq $true]; then
	# Sistema Operativo riconosciuto - Creo il file
	echo "WORKDIR=/home/myprogram/" > /etc/myprogram.conf
	echo "$endScriptOk"
else
	# Sistema operativo NON riconosciuto - Per il momento non faccio nulla
	echo "$endScriptNo"
fi
