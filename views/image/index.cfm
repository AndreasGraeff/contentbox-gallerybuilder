<cfoutput>
	<style>
	.gallery-builder-thumb img {
	height: 50px;
	}
	</style>
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<div class="header">
				<i class="icon-list-alt icon-large"></i>
				#prc.gallery_name#
			</div>

			<div class="body">

				#getPlugin("MessageBox").renderIt()#

				#html.startForm(name="imagesForm",action=prc.xehImageDelete)#
				#html.hiddenField(name="image_id",value="")#

				<div class="well well-small">
					<div class="lead">
						<button class="btn btn-inverse" onclick="window.location.href='#event.buildLink(prc.xehGallery)#';return false;"><i class="icon-reply"></i> Change Gallery</button>
					<div class="buttonBar">
						<div class="btn-group">
							<button class="btn btn-danger" onclick="window.location.href='#prc.xehCreate#';return false;" title="Create new gallery item">Create Image</button>
						</div>
					</div>
					</div>
				</div>

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
			</div>
		</div>
	</div>

	<div class="span3" id="main-sidebar">
		<cfinclude template="../sidebar/help.cfm" >
	</div>
</div>
</cfoutput>