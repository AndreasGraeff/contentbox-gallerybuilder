#!/bin/sh

cd ..
file="install-module.zip"
if [ -f "$file" ]
then
	rm -f install-module.zip
fi

zip -r contentbox-gallerybuilder/install-module.zip contentbox-gallerybuilder -x *.git* *build.sh
cd contentbox-gallerybuilder
