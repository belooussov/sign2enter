
# Create a certificate authority for SSH
ca:
	mkdir -p roles/ssh/files
	ssh-keygen -f roles/ssh/files/ca_key -P ''

# Create a user's SSH key.
userkey:
	ssh-keygen -t rsa -b 4096 -f roles/test_ssh/files/id_rsa -P ''

# Sign the users' SSH keys to generate the certificate they need for the servers.
sign:
	ssh-keygen -s roles/ssh/files/ca_key -I id_vagrant -n vagrant roles/test_ssh/files/id_rsa.pub

test:
	@ssh -p2222 -i ${HOME}/.vagrant.d/insecure_private_key -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null vagrant@127.0.0.1 ./playbook.yml

retest:
	vagrant halt
	vagrant destroy -f
	vagrant up --provider=virtualbox

clean:
	rm -rf roles/ssh/files/ roles/test_ssh/files/id_rsa roles/test_ssh/files/id_rsa-cert.pub roles/test_ssh/files/id_rsa.pub

all: ca userkey sign retest test
