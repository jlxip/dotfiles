#!/bin/bash
# This is meant to be run automatically by incron.
cd
emacs jotaOS.org --batch -f org-html-export-to-html
echo 'put ./jotaOS.html' | sftp -i ~/.ssh/stronghold_jotaOS jotaOS@stronghold
rm jotaOS.html
