.PHONEY: build test deploy down clean \
	kubespray _ks_init _ks_update

_KUBESPRAY_RELEASE=release-2.11

# LOCAL TESTING
build: kubespray
	@cd roles/kubespray && vagrant up

provision:
	# Re Execute nominated vagrant provisioner (ansible)
	@cd roles/kubespray && vagrant provision

kubespray: _ks_init _ks_update

_ks_init:
	# Initialise submodule submodule
	@cd roles/kubespray && git submodule update --init --recursive

_ks_update:
	# Update kubespray repo to selected release
	@cd roles/kubespray && git checkout $(_KUBESPRAY_RELEASE)

test:
	# Perform api call to Kubernetes master

down:
	# Suspend vagrant local cluster
	@cd roles/kubespray && vagrant suspend

clean:
	# Destroy local cluster
	@cd roles/kubespray && vagrant destroy

# PRODUCTION OPERATIONS
# REFER TO KUBESPRAY DOCS