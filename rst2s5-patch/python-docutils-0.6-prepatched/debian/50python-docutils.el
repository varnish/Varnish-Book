;; autoload support for reStructuredText, from python-docutils
(autoload 'rst-mode "rst" "mode for editing reStructuredText documents" t)

;; The following lines are not enabled by default because the 'correct'
;; extension for reStructuredText files, according to the ReST
;; documentation, is '.txt'.  (Or nothing, for that matter.)
;;
;;(setq auto-mode-alist
;;       (append '(("\\.rst$" . rst-mode)
;;                 ("\\.rest$" . rst-mode)) auto-mode-alist))
