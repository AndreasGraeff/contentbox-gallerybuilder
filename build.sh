#!/bin/sh

cd ..
zip -r contentbox-gallerybuilder/install-module.zip contentbox-gallerybuilder -x *.git* *build.sh
cd contentbox-gallerybuilder
