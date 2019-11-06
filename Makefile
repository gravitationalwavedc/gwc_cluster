.PHONEY: build test deploy down clean \
	kubespray _ks_init _ks_status _ks_update_vagrantfile

_DIR_KUBESPRAY=./roles/kubespray
_KUBESPRAY_RELEASE=release-2.11

# LOCAL DEPLOYMENT
build: kubespray
	@cd $(_DIR_KUBESPRAY) && vagrant up

provision:
	# Re Execute nominated vagrant provisioner (ansible)
	@cd $(_DIR_KUBESPRAY) && vagrant provision

kubespray: _ks_init _ks_status _ks_update_vagrantfile

_ks_init:
	# Initialise submodule submodule
	@git submodule update --init --recursive

_ks_status:
	# Confirm Kubespray Release 2.11 commit 86cc703c
	@cd $(_DIR_KUBESPRAY) && git branch

_ks_update_vagrantfile:
	# Update OS image
	@cat  $(_DIR_KUBESPRAY)/Vagrantfile | sed 's/generic\/ubuntu1804/ubuntu\/bionic64/g' > tmp

	# Update Container Network Interface
	@cat tmp | sed 's/flannel/calico/g' >  $(_DIR_KUBESPRAY)/Vagrantfile
	@rm tmp

test:
	# Perform api call to Kubernetes master

login_1:
	 @cd $(_DIR_KUBESPRAY) && vagrant ssh k8s-1

login_2:
	 @cd $(_DIR_KUBESPRAY) && vagrant ssh k8s-2

login_3:
	 @cd $(_DIR_KUBESPRAY) && vagrant ssh k8s-3

down:
	# Suspend vagrant local cluster
	@cd $(_DIR_KUBESPRAY) && vagrant suspend

clean:
	# Destroy local cluster
	@cd $(_DIR_KUBESPRAY) && vagrant destroy

# PRODUCTION OPERATIONS
# REFER TO KUBESPRAY DOCS

