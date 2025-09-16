# Infra
## conjur
* conjur1.lab
* conjur2.lab
* conjur3.lab
## conjur-tmp : dgsuser
* conjur-temp-1.lab  
* conjur-temp-2.lab  
* conjur-temp-3.lab  

# Pre-controlli
* aperture rete,
* versione podman,
* risoluzione DNS



# Installazione
1. `sudo su` 	>  farlo sempre, lavorare come sudo
2. Creazione cartelle & file:
```
mkdir -p /opt/cyberark/conjur/{security,config,backups,seeds,logs}
touch /opt/cyberark/conjur/config/conjur.yml
chmod o+x /opt/cyberark/conjur/config 
chmod o+r /opt/cyberark/conjur/config/conjur.yml
```
3. load immagine ... 
4. seccomp:
`podman run --rm --entrypoint "/bin/cat" registry.tld/conjur-appliance:13.5.0 /usr/share/doc/conjur/examples/seccomp.json > /opt/cyberark/conjur/security/seccomp.json`
4. start container:
```
podman run --add-host=conjur-1-podman:10.32.45.10 --add-host=conjur-2-podman:10.32.45.11 --add-host=conjur-3-podman:10.32.45.12 --name conjur --detach --restart=unless-stopped --cap-add AUDIT_WRITE --publish "443:443" --publish "444:444" --publish "5432:5432" --publish "1999:1999" --log-driver journald --security-opt seccomp=/opt/cyberark/conjur/security/seccomp.json --volume /opt/cyberark/conjur/security:/opt/cyberark/conjur/security:Z --volume /opt/cyberark/conjur/backups:/opt/conjur/backup:Z --volume /opt/cyberark/conjur/seeds:/opt/cyberark/conjur/seeds:Z --volume /opt/cyberark/conjur/logs:/var/log/:Z --volume /opt/cyberark/conjur/config:/etc/conjur/config/:Z conjur-appliance:13.5.0
```
5. enable restart & verify $ persist user-process

`CONTAINER_NAME=conjur && podman generate systemd --name --container-prefix="" --separator="" "$CONTAINER_NAME" > /etc/systemd/system/${CONTAINER_NAME}.service && systemctl daemon-reexec && systemctl daemon-reload && systemctl enable ${CONTAINER_NAME}.service`


`systemctl is-enabled conjur.service`

6. configure leader:
```
podman exec conjur evoke configure leader   --accept-eula   --hostname conjur-cluster-temp.lab   --leader-altnames conjur-1-podman,conjur-2-podman,conjur-3-podman   --admin-password CyberArk@123! \dgs-lab
```
7. check /info & /health

8. Generate seeds & ship them to the 2 nodes "/opt/cyberark/conjur/seeds":
```
podman exec conjur evoke seed standby conjur-2-podman > /tmp/conjur-2-podman.tar
scp /tmp/conjur-2-podman.tar dgsuser@10.32.45.11:/tmp
```

```
podman exec conjur evoke seed standby conjur-3-podman > /tmp/conjur-3-podman.tar
scp /tmp/conjur-3-podman.tar dgsuser@10.32.45.12:/tmp
```


9. open 2 new terminal & `ssh dgsuser@conjur-temp-2.lab` &&  `ssh dgsuser@conjur-temp-3.lab` 
create conjur cnt step 0-5

```
 mv /tmp/conjur-2-podman.tar /opt/cyberark/conjur/seeds/
 podman exec -it conjur evoke unpack seed /opt/cyberark/conjur/seeds/conjur-2-podman.tar
 podman exec -it conjur  evoke configure standby
```
!!!NB : in case of PERMISSION ERROR > podman rm -f conjur & recreate container ::: domanda per cappiccino1

10. on the Leader :Start sync replication and do all the due checks : `podman exec conjur sh -c "evoke replication sync start"`

### Policy
1. install conjur cli,
2. Download script folder & customize [TO-DO: mark up all diff btw env]
3. login as admin `./loader-admin.sh`
4.  `./loader-admin.sh `
5.  `./loader-admin-synchronizer.sh`
6.  `./loader-cluster.sh`
6.1 complete autofailover cluster by running: https://docs.cyberark.com/conjur-enterprise/13.5/en/content/deployment/highavailability/auto-failover-setup-continue.htm
`
podman exec conjur evoke cluster enroll -n conjur-1-podman dgs-lab #leader
podman exec conjur evoke cluster enroll -n conjur-2-podman -m conjur-1-podman dgs-lab #foll1
podman exec conjur evoke cluster enroll -n conjur-3-podman -m conjur-1-podman dgs-lab #foll2
`
6.2 abilitare gli autenticatori su tutti i nodi e sul leader `run evoke config apply` 

wait 5 min and check for etcd to be on point -> "evoke cluster member list" 
7.  `./loader-app-lab.sh`

### Configure Authenticator  --- e set up follower con docu passo passo
1. `./inizializzazione-CA.sh`
2. SetUp sa token & Upload

 ####
 TO DO:
 secondo cluster 
 DIFF dei parameti mobili
 GRANT ESO e set-up HARMONIA
 finire procedura follower -> puntuale e completa


