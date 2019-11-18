### PIPELINE
Creare una pipeline per l'esercizio 2 in modo che ci siano le fasi di creazione delle immagini e la messa in produzione su un server docker.

Migliorativo:
- aggiungere una fase di test (gli applicativi hanno un endpoint /actuator/health che risponde con un json {"status": "UP"} in caso sia tutto ok)
- aggiungere una fase per pubblicare l'immagine su registro pubblico
- se il branch nei quali si fa il commit e' diverso dal master pubblicare l'immagine con un tag DEV e metterla in produzione sul docker di DEV

e' possibile usare qualsiasi sistema di CI (gitlab-ci, travis-ci, drone ecc.).


Non ho avuto tempo di configurarre la pipeline, però qeusta puo' essere configurata attraverso le istruzioni presenti a questo sito:  https://jenkins.io/doc/book/pipeline/docker/  
