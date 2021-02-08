;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Ross MacLeod"
      user-mail-address "rmm+github@z.odi.ac"
      doom-font "Fira Code Retina-8"
      doom-theme 'doom-molokai
      org-directory "~/org/"
      display-line-numbers-type 'relative
      company-idle-delay nil
      evil-ex-substitute-global t)

(after! evil-snipe (evil-snipe-mode -1))
