.PHONEY: build test deploy down clean \
	kubespray _ks_init _ks_update

_DIR_KUBESPRAY=./roles/kubespray
_KUBESPRAY_RELEASE=release-2.11

# LOCAL TESTING

build: kubespray up

aprovision:
	# Re Execute nominated vagrant provisioner (ansible)
	@cd $(_DIR_KUBESPRAY) && vagrant provision

up:
	@cd $(_DIR_KUBESPRAY) && vagrant up

kubespray: _ks_init _ks_update

_ks_init:
	# Initialise submodule submodule
	@cd $(_DIR_KUBESPRAY) && git submodule update --init --recursive

_ks_update:
	# Update kubespray repo to selected release
	@cd $(_DIR_KUBESPRAY) && git checkout $(_KUBESPRAY_RELEASE)

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

