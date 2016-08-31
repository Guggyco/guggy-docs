#!/bin/bash

git commit -a -m "new docs version"
git push origin master
git push origin --delete gh-pages
mkdocs gh-deploy --clean
