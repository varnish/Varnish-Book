#!/usr/bin/env make

EMACS=/usr/bin/emacs

runtests:
	$(EMACS) --batch -l tests-basic.el
	$(EMACS) --batch -l tests-adjust-section.el

runtests-emacs-cvs:
	$(EMACS) --script tests-basic.el
	$(EMACS) --script tests-adjust-section.el

