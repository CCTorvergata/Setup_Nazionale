
# Setup_Nazionale


## Requisiti

- ansible
- rsync
- git



## Configurazione iniziale

### Chiavi SSH

È necessario mettere la propria chiave pubblica SSH all'interno della cartella `./roles/vulnbox/copy-ssh-public-keys/files`.
è inoltre possibile mettere altre chiavi pubbliche (degli altri giocatori) all'interno di tale cartella,
ognuna di esse verrà aggiunta al file `authorized_keys` della vulnbox.

### IP della vulnbox

È necessario impostare correttamente l'IP della vulnbox all'interno del file `./inventory`



## Run del playbook

È sufficente eseguire il comando:
```bash
./setup.sh
```



## TODO

- Add variable to firegex port
- Add firegex ip:port info to out file
- Check if git clone overwrites modified/added files (flagWharehouse)
- Outfile with service name-port (?)
- Automatic docker container checkpoint generation (?)
