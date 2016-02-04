NEWS
====

This file is meant for trainers.
Below are the main changes that might affect the flow of a training session.
Main changes from last training session based on:

Changes for future tag ``version-5.4``
--------------------------------------

Add most relevant changes here!

Tag version-5.3
---------------

Printed version for training held by Dridi on February 1, 2016

- ``vcl_backend_response`` together with the `Waiting State`_ section are now in `VCL_Basics`_ chapter
- Demo for health probes
- `Compression`_ subsection added in `Saving a Request`_ chapter.
- VCL is shown for first time in the introduction

Tag version-5.2
---------------

This is the printed version for Arianna's training.

- Figure to explain reordered output of ``varnishlog``.
- ``varnishtest`` throughout the book.
- Installation of Apache as backend is in Appendix F.
- Solutions are moved to Appendix G.


Tag version-5.1
---------------

- ``vcl_recv`` is in the `VCL Basics` chapter, first as a snippet and then the built-in code.
  This subroutine is revisited in the `VCL built-in subroutines` chapter.
- `Waiting State` is moved from `VCL Basics` to `VCL Built-in Subroutines`.
- Install Apache and Varnish are exercises with provided solutions.

General reminders
-----------------

Look for relevant comments in the source code::

  $ git grep -A5 "..TODO for trainer"
