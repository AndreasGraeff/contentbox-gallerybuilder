<cfoutput>
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<div class="header">
				<i class="icon-list-alt icon-large"></i>
				Galleries
			</div>
			<div class="body">
				#getPlugin("MessageBox").renderit()#

				#html.startForm(name="galleriesForm",action=prc.xehGalleryDelete)#
				#html.hiddenField(name="gallery_id",value="")#

				<div class="well well-small">
					<div class="buttonBar">
						<button class="btn btn-danger" onclick="window.location.href='#event.buildLink(prc.xehGalleryEditor)#';return false;" title="Create new gallery">Create Gallery</button>
					</div>
					<div class="filterBar" style="min-height: 30px;"></div>
				</div>

				<table id="gallery" class="tablesorter table table-striped">
					<thead>
						<tr>
							<th>Gallery</th>
							<th>Slug</th>
							<th>Created</th>
							<th>Images Per Page</th>
							<th>Number Of Rows Per Page</th>
							<th>Number Of Columns Per Page</th>
							<th>Lightbox</th>
							<th width="75" class="center {sorter:false}">Actions</th>
						</tr>
					</thead>
					<tbody>
						<cfloop array="#prc.galleries#" index="idx" item="g">
						<tr name="reihe-#idx#">
							<td><i class="icon-plus-sign icon-large text" id="plus-minus-sign-#idx#"
									data-row="#idx#" data-toogle="plus" data-id="#g.getGallery_id()#"></i>
								<a class="hand-cursor" href="#event.buildLink(prc.xehImage)#/gallery_id/#g.getGallery_id()#"
								   title="Images In Gallery &quot;#g.getName()#&quot;">
								#g.getName()#</a></td>
							<td><a class="hand-cursor" href="#event.buildLink(prc.xehImage)#/gallery_id/#g.getGallery_id()#"
								   title="Images In Gallery &quot;#g.getName()#&quot;">#g.getSlug()#</a></td>
							<td>#dateFormat(g.getCreated_at(),"short")# #timeFormat(g.getCreated_at(),"short")#</td>
							<td>#g.getImages_per_page()#</td>
							<td>#g.getImages_number_rows()#</td>
							<td>#g.getImages_number_columns()#</td>
							<td>#getMyPlugin(plugin="formatHelper",module="contentbox-gallerybuilder").boolean(g.getUse_lightbox())#</td>
							<td class="center">
								<a href="#event.buildLink(prc.xehGalleryEditor)#/gallery_id/#g.getGallery_id()#"
								   title="Edit Gallery"><i class="icon-edit icon-large"></i></a>
								<a title="Delete Gallery" href="javascript:deleteGallery(#g.getGallery_id()#)" class="confirmIt textRed"
									data-title="Delete Gallery?"><i id="delete_#g.getGallery_id()#" class="icon-trash icon-large"></i></a>
							</td>
						</tr>
						</cfloop>
					</tbody>
				</table>
				#html.endForm()#
			</div>
		</div>
	</div>

	<div class="span3" id="main-sidebar">
		<cfinclude template="../sidebar/help.cfm" >
	</div>
</div>
</cfoutput>