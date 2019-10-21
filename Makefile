.PHONEY: build update test deploy down clean

# LOCAL TESTING
build: update
	cd roles/kubespray && vagrant up

provision:
	# Re Execute nominated vagrant provisioner (ansible)
	cd roles/kubespray && vagrant provision

update:
	# Update submodule

test:
	# Perform api call to Kubernetes master

down:
	# Suspend vagrant local cluster
	cd roles/kubespray && vagrant suspend

clean:
	# Destroy local cluster
	cd roles/kubespray && vagrant destroy

# PRODUCTION OPERATIONS
# REFER TO KUBESPRAY DOCS