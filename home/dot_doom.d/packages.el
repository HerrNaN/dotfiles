(package! feature-mode)    ; Cucumber Gherkin files
(package! gitconfig)       ; Gitconfig
(package! dockerfile-mode) ; Docker files
(package! lsp-haskell)     ; Haskell LSP
(package! gruvbox-theme)   ; Gruvbox Theme

; KMonad syntax highlighting
(package! kbd-mode
  :recipe (:host github
           :repo "kmonad/kbd-mode"))

; Systemd syntax highlighting
(package! systemd
  :recipe (:host github
           :repo "holomorph/systemd-mode"))
