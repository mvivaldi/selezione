base:
  '*':
    - configurazioni valide per tutti i server
    - ....
  'os:Ubuntu':
    - match: grain
    - apache-ubuntu
    - altre configurazioni per OS ubuntu    
  'os:RedHat':
    - match: grain
    - apache-redhat
    - altre configurazionie per OS redhat
