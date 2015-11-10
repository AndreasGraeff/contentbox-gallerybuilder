<cfoutput>
<link href="#prc.moduleRoot#/includes/css/gallery-builder.css" rel="stylesheet" type="text/css" />
<link href="#prc.moduleRoot#/includes/css/gallery-builder-lightbox.css" rel="stylesheet" type="text/css" />
<!--- Javascript --->
<h1 class="gallery-builder-gallery-title">#prc.gallery.getName()#</h1>

#prc.Pagenation#

#prc.TableImages#

#prc.Pagenation#

<cfdump var="#event#">

<!--- <table class="gallery-builder-gallery-table">

	<cfloop array="#prc.images#" index="g">
		<td><div class="divImage">
			<a href="images/02_036_DSC_7672.jpg" rel="lightboxgalery" title="Eine Ringelnatter schwimmt von Ufer zu Ufer, Nationaal Park De Weerribben, NL. (30.05.2014)" alt="Eine Ringelnatter schwimmt von Ufer zu Ufer, Nationaal Park De Weerribben, NL. (30.05.2014)">
			<img src="images/TN_02_036_DSC_7672.jpg" class="imgGalery"></a></div></td>

		</td>
	</cfloop>
</table> --->


<!--- <cfdump var="#prc.images#"> --->
</cfoutput>