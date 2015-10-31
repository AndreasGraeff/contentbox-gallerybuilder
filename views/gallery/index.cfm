<cfoutput>
	<!--- <cfdump var='#getModuleSettings( "contentbox-filebrowser" ).settings.directoryroot#'>
	<cfdump var='#getModuleSettings( "contentbox-gallerybuilder" ).entrypoint#'>
	<cfset pp=expandpath(getModuleSettings( "contentbox-filebrowser" ).settings.directoryroot
			& "/" & getModuleSettings( "contentbox-gallerybuilder" ).entrypoint)>
	<cfdump var='#pp#'>
	<cfdump var='#prc.cgp#'> --->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<div class="header">
				<i class="icon-list-alt icon-large"></i>
				Galleries
			</div>
			<div class="body">
				#getPlugin("MessageBox").renderit()#

				<div class="well well-small">
					<div class="buttonBar">
						<button class="btn btn-danger" onclick="window.location.href='#event.buildLink(prc.xehGalleryEditor)#';return false;" title="Create new gallery">Create Gallery</button>
					</div>
					<div class="filterBar" style="min-height: 30px;"></div>
				</div>

				<table class="tablesorter table table-striped">
					<thead>
						<tr>
							<th>Gallery</th>
							<th>Slug</th>
							<th>Created</th>
							<th>Images per Page</th>
							<th>Images per table row</th>
							<th>Images per table column</th>
							<th>Lightbox</th>
							<th width="75" class="center {sorter:false}">Actions</th>
						</tr>
					</thead>
					<tbody>
						<cfloop array="#prc.galleries#" index="g">
						<tr>
							<td><a class="hand-cursor" href="#event.buildLink(prc.xehImage)#/gallery_id/#g.getGallery_id()#"
								   title="Images In Gallery &quot;#g.getName()#&quot;">#g.getName()#</a></td>
							<td>#g.getSlug()#</td>
							<td>#dateFormat(g.getCreated_at(),"short")# #timeFormat(g.getCreated_at(),"short")#</td>
							<td>#g.getImages_per_page()#</td>
							<td>#g.getImages_per_row()#</td>
							<td>#g.getImages_per_column()#</td>
							<td>#g.getUse_lightbox()#</td>
							<td class="center">
								<!--- edit link --->
								<a href="#event.buildLink(prc.xehGalleryEditor)#/gallery_id/#g.getGallery_id()#"
								   title="Edit #g.getName()#"><i class="icon-edit icon-large"></i></a>
								<!--- delete link  --->
								<a title="Delete Gallery" href="javascript:remove('#g.getGallery_id()#')" class="confirmIt textRed" data-title="Delete Gallery?"><i id="delete_#g.getGallery_id()#" class="icon-trash icon-large"></i></a>
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