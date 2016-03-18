
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

retest:
	vagrant halt
	vagrant destroy -f
	vagrant up

all: ca userkey sign retest

