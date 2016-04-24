.PHONY: load
load: dockersock.pp
	semodule -i $^

.PHONY: unload
unload:
	semodule -r dockersock

dockersock.mod: dockersock.te
	checkmodule -M -m $< -o $@

dockersock.pp: dockersock.mod
	semodule_package -m $< -o $@

.PHONY: clean
clean::
	rm -f dockersock.pp dockersock.mod
