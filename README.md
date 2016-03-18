# sign2enter: Signed SSH key authentication.
testcase for using signed SSH keys with Ansible

Please note that signed ssh keys were introduced in 2010 in openssh 5.4
In 2016 RHEL6.7 still runs openssh 5.3.

Requirements
- laptop that can run ansible
- virtualbox
- vagrant
- internet

Description
The host 'target' is configured to accept only signed keys.
The host 'control' will run a playbook on 'target' using a certificate.

Usage: 'make all' should finish without errors.
