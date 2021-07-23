mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(abspath $(dir mkfile_path))

link = ln -sb ${current_dir}/$(1) $(2)/$(1)

ALL := \
	.spacemacs \
	config.fish \
	kubectl.fish \
	minikube.fish \
	emacs.service \
	.gitconfig

.PHONY: all
all: $(ALL)

.PHONY: .spacemacs
.spacemacs:
	$(call link,$@,~)

.PHONY: config.fish
config.fish:
	$(call link,$@,~/.config/fish)

.PHONY: kubectl.fish
kubectl.fish:
	$(call link,$@,~/.config/fish/completions)

.PHONY: minikube.fish
minikube.fish:
	$(call link,$@,~/.config/fish/completions)

.PHONY: emacs.service
emacs.service:
	$(call link,$@,~/.config/systemd/user)

.PHONY: .gitconfig
.gitconfig:
	$(call link,$@,~)
