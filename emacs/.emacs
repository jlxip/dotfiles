; Can I remove this? Not sure...
(custom-set-variables
 '(package-selected-packages
   (quote
    (doom-themes all-the-icons treemacs magit htmlize org-bullets centaur-tabs use-package))))
(custom-set-faces)

; Load the config from the ORG file
(package-initialize)
(org-babel-load-file "~/.emacs.org")
