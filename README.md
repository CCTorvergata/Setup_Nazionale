# Setup_Nazionale

## Installazione iniziale

Eseguire:
```sudo ./setup.sh```

## Iniziare una ctf
Configurare flagwarehouse e tulip (clonati tramite git dallo script setup.sh)
Poi eseguire:
```sudo ./start_ctf.sh```
E poi:
```cd ansible```
```ansible-playbook -i inventory setup_vulnbox.yml```