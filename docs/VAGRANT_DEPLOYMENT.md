VAGRANT_DEPLOYMENT
==========
Instructions to deploy a local dev/test cluster

Pre deployment considerations
--------------
* Ensure that [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) and [Vagrant](https://www.vagrantup.com/downloads.html) are installed
* Pip dependencies exists and are dynamically dependent on [Kubespray](https://github.com/kubernetes-sigs/kubespray)
* Refer to [Kubespray](https://github.com/kubernetes-sigs/kubespray) documentation for the pip dependencies
* A Virtual environment (venv) maybe desired to isolate the installation of the pip dependencies

Deployment
--------------
* Local Orchestration is handled by the [Makefile](./Makefile)
* Deployment is intended to emulate the infrastructure of the production cluster albeit with limited resources.

Makefile Commands make $COMMAND
--------------
* build - Initialises kubespray submodule, creates VM, executes Ansible
* login_$(NODE_NUM) - SSH into specified node
* down - Suspends all VMs
* clean - Destroys the cluster
