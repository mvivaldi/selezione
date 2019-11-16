### BASH
Abbiamo un apache con 3 virtualhost (site_a, site_b, site_c), ogni virtualhost ha un suo file di log ( CustomLog /var/log/apache/access_site_a.log combined, ecc. ), vogliamo uno script bash che:
- mandi un webhook in tempo reale a http://webhook.local/error_404 quando viene riscontrato un codice di errore 404
- mandi un webhook in tempo reale a http://webhook.local/pagina_404 quando viene trovato un log di accesso alla pagina /404.html
- crei un file di log delle chiamate fatte (in /var/log/webhook.log)
- lo script deve partire automaticamente all'avvio della macchina


### SOLUZIONE error_404
- Installare swatch sul sistema.
- Copiare il contenuto del file init.d_swatch.sh in vim /etc/init.d/swatch
- Abilitare l'esecuzione all'avvio systemctl enable swatch.service
- utilizzare swatch_01.conf

  

