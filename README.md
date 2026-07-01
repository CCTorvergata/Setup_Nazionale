
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

- Install community.docker collection
- Solve eventual host key verification rsync error (root).
- Check if firegex works
- Check why firegex restarts multiple times
- Check if firegex password is being changed
- Check if git clone overwrites modified/added files (flagWharehouse)
