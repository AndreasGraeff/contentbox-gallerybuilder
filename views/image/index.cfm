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
				<th>Actions</th>
				<th>Delete</th>
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
				<td>
					<a href="#event.buildLink(prc.xehImageEditor)#/gallery_id/#prc.gallery_id#/image_id/#i.getImage_id()#"
					   title="Edit #i.getTitle()#"><i class="icon-edit icon-large"></i></a>
				</td>
				<td>#html.checkbox(name="delete_images",value="#i.getImage_id()#",title="Mark To Delete Image")#</td>
			</tr>
			</cfloop>
			<tr>
				<td colspan="3"></td>
				<td colspan="3">
					<button class="btn btn-danger" onclick="window.location.href='#prc.xehCreate#';return false;" title="Create Image">Create Image</button>
				</td>
				<td>
					<input type="submit" value="Delete Images" class="btn btn-danger" id="submit_#prc.gallery_id#" name="submit_#prc.gallery_id#">
				</td>
			</tr>
		</tbody>
	</table>
	#html.endForm()#
</td></tr>
</cfoutput>