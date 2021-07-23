mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(abspath $(dir mkfile_path))

link = ln -sb ${current_dir}/$(1) $(2)/$(1)

.PHONY: all
all: .spacemacs

.PHONY: .spacemacs
.spacemacs:
	$(call link,$@,~)
