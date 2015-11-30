# contentbox-gallerybuilder

## Version 1.0.2

contentbox-gallerybuilder is a module for ContentBox, the ColdFusion based Content Management System.

You can create image galleries with it. These galleries are automatically pagenated and they also include support for a "Lightbox" view of an image.

It focuses on galleries of artists, who have distinct themes of art and want to present them thematically (i.e. each photography belongs to one single theme).

# Installation
Download and expand the Zip-file from github to a directory of your choice or "git clone" the latest releases. Take care of the file "install-module.zip", it contains the complete module.

To install the "contentbox-gallerybuilder" go the ContentBox Administrator, click on "Modules" -> Manage. Select the file "install-module.zip" to upload in the "Module Uploader" or install it directly from the "ForgeBox" tab.

**Caution: DO NOT INSTAll** the zip-file "contentbox-gallerybuilder-master.zip" (or releases like "contentbox-gallerybuilder-1.0.2.zip") you downloaded from github, it contains the branch name in it's path, this will cause errors.

The contentbox-gallerybuilder also requires the gallerybuilder widget, please take care you have also installed this widget.

# Documentation

## Gallery

All Galleries have one single parent "directory" in your web site, the "Gallery Path". It defaults to "gallery", but you can change it (click on "Default Setting" in the help box on the right) for a name you like. I.e. "nature-photography", if you like this more or if it better fits your SEO needs. Every single Gallery (i.e. "water-birds", "flowers", "leaf", "landscapes") is placed under this "gallery" directory. Be careful to choose a good name first, automatic rename of your images will be available in a future release, yet it's not implemented %-). Each Gallery has a unique name (in ContentBox called slug). A good practice for the slug: if you have non standard ascii letters, create the slug with standard ascii letters. I.e. a german title is "Blumen und Blüten", slug should be "blumen-und-blueten".

You can use the Lightbox-Plugin to show the content of your Gallery. If you use Lightbox, the GalleryBuilder renders your page with the thumb as a preview and the image will be shown on click on a transparent overlay of your page. If you don't use Lightbox, the image will be rendered directly into your page, the thumb will not be used.

The images in your page are rendered into a HTML table. You can choose the number of rows and the number of columns in your Gallery. To have an equal view for both images in landscape and portrait format, the table cells are rendered with square dimensions. You can set the height/width of a cell in the global settings, available via the "Default Setting" in the help box on the right of the GalleryBuilder Administrator view.

## Image

If you create or edit an Image you have to select the gallery and set the Image. All other entries are optional.
The "Title" is the title and alt attribute of the image. It's a good practice to set it for SEO. If you do not set the title, the attributes will be empty.
The Description is shown below the image in the Lightbox view.
The date (as text, i.e. "September 2015" or "Late Summer 2015") is appended to the description, if set.
With "visible", you can make an image visible or invisible in your page.

