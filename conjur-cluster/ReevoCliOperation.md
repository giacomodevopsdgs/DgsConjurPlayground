${projectdir}\CYBR-Conjur-automation\dgs-conjur-playground\conjur-cluster\docker-compose.yaml
### In the cnt shell:
* cd /reevo-cli/Playground-Temp/
* apt update && apt install dos2unix && find . -type f -name "*.sh" -exec dos2unix {} \;
* apt install jq


  apt update
  apt install dos2unix
  find . -type f -name "*.sh" -exec dos2unix {} \;

  
# Admin Operation
1. ./authenticate-admin.sh
2. ./loader-admin.sh
3. conjur policy load -f mock-synchronizer.yaml -b root
4. ./loader-cluster.sh 




# Set Up autofailover
leader 

* podman exec conjur evoke cluster enroll -n conjur-1-podman dgs-playground

standby

* podman exec conjur evoke cluster enroll -n conjur-2-podman -m conjur-1-podman dgs-playground
* podman exec conjur evoke cluster enroll -n conjur-3-podman -m conjur-1-podman dgs-playground

verify status evoke cluster member list

# Set Up Follower

./loader-app-lab.sh

