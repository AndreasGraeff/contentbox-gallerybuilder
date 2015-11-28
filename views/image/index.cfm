<cfoutput>
<tr><td colspan="8">
	#getPlugin("MessageBox").renderIt()#

	#html.startForm(name="imagesForm",action=prc.xehImageDelete)#
	#html.hiddenField(name="image_id",value="")#

	<table class="tablesorter table table-striped" width="98%">
		<thead>
			<tr class="gallery-builder-admin-th">
				<th>Title</th>
				<th>Thumb</th>
				<th>Description</th>
				<th>Date</th>
				<th>Visible</th>
				<th width="75" class="center {sorter:false}">Actions</th>
			</tr>
		</thead>
		<tbody>
			<cfloop array="#prc.images#" index="i">
			<tr>
				<td>
					<a class="hand-cursor" href="#event.buildLink(prc.xehImageEditor)#/gallery_id/#i.getGallery_id().getGallery_id()#/image_id/#i.getImage_id()#"
					   title="Edit #i.getTitle()#">#i.getTitle()#</a></td>
				<td>#getMyPlugin(plugin="formatHelper",module="contentbox-gallerybuilder").thumbnail(i.getThumb(),"gallery-builder-admin-thumbnail")#</td>
				<td>#i.getDescription()#</td>
				<td>#i.getImage_date()#</td>
				<td>#getMyPlugin(plugin="formatHelper",module="contentbox-gallerybuilder").boolean(i.getVisible())#</td>
				<td class="center">
					<a href="#event.buildLink(prc.xehImageEditor)#/gallery_id/#i.getGallery_id().getGallery_id()#/image_id/#i.getImage_id()#"
					   title="Edit #i.getTitle()#"><i class="icon-edit icon-large"></i></a>
					<a title="Delete Image" href="javascript:deleteImage('#i.getImage_id()#')" class="confirmIt textRed"
						data-title="Delete Image?"><i id="delete_#i.getImage_id()#" class="icon-trash icon-large"></i></a>
				</td>
			</tr>
			</cfloop>
		</tbody>
	</table>
	#html.endForm()#
</td></tr>
</cfoutput>