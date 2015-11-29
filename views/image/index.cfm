<cfoutput>
<tr><td colspan="8">
	#getPlugin("MessageBox").renderIt()#
	<!--- this form can be injected multiple (one for every gallery) --->
	#html.startForm(name="imagesForm_#prc.gallery_id#",action=prc.xehImageDelete)#
	#html.hiddenField(name="image_id",id="image_id_#prc.gallery_id#",value="")#
	#html.hiddenField(name="gallery_id",value="#prc.gallery_id#")#

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
					<a class="hand-cursor" href="#event.buildLink(prc.xehImageEditor)#/gallery_id/#prc.gallery_id#/image_id/#i.getImage_id()#"
					   title="Edit #i.getTitle()#">#i.getTitle()#</a></td>
				<td>#getMyPlugin(plugin="formatHelper",module="contentbox-gallerybuilder").thumbnail(i.getThumb(),"gallery-builder-admin-thumbnail")#</td>
				<td>#i.getDescription()#</td>
				<td>#i.getImage_date()#</td>
				<td>#getMyPlugin(plugin="formatHelper",module="contentbox-gallerybuilder").boolean(i.getVisible())#</td>
				<td class="center">
					<a href="#event.buildLink(prc.xehImageEditor)#/gallery_id/#prc.gallery_id#/image_id/#i.getImage_id()#"
					   title="Edit #i.getTitle()#"><i class="icon-edit icon-large"></i></a>
					<a title="Delete Image" href="javascript:void(0);" class="confirmIt textRed" data-title="Delete Image?">
						<i data-gallery_id="#prc.gallery_id#" data-image_id="#i.getImage_id()#"
						id="deleteImage_#prc.gallery_id#_#i.getImage_id()#" class="icon-trash icon-large"></i></a>
				</td>
			</tr>
			</cfloop>
		</tbody>
	</table>
	#html.endForm()#
</td></tr>
</cfoutput>