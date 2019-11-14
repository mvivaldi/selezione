### CONSIDERAZIONI INIZIALI
- server ssh già installato su tutte le macchine
- accesso con ssh root@nome_server
- tutte le macchine siano risolvibili sul DNS

### Funzionamento
- eseguire lo script execute_On_All_Servers.sh. In questo modo viene eseguito da remoto lo script install_apache che si occupa di verificare la versione del OS
  e di installare la versione corretta del pacchetto. Il file viene creato come step successivo in quanto non necessità del riconoscimento del OS.
