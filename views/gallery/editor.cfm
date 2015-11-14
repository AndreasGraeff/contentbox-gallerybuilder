<cfoutput>
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<!--- Body Header --->
			<div class="header">
				<i class="icon-file-alt"></i>
				<cfif prc.gallery.getGallery_id() gt 0>Editing "#prc.gallery.getName()#"<cfelse>Create Gallery</cfif>
			</div>
			<!--- Body --->
			<div class="body">

				#getPlugin("MessageBox").renderIt()#

				<div class="tabbable tabs-left">
					<!--- User Navigation Bar --->
					<ul class="nav nav-tabs">
						<li class="active"><a href="##galleryTab" data-toggle="tab"><i class="icon-list-alt"></i> Gallery Details</a></li>
					</ul>

					<div class="tab-content">
						<div class="tab-pane active" id="galleryTab">
							<!--- gallery formular --->
							#html.startForm(name="galleryForm", action=prc.xehGallerySave, novalidate="novalidate")#
								#html.startFieldset(legend="Gallery Details")#
								#html.hiddenField(name="gallery_id",bind=prc.gallery)#
								#html.textField(name="name",bind=prc.gallery,label="*Name:",required="required",size="50",class="textfield",title="The unique name (or key for I18N) of your gallery")#
								#html.textField(name="slug",bind=prc.gallery,label="*Slug:",required="required",size="50",class="textfield",title="The unique slug to identify your gallery (use a SEO friendly name of your gallery content).")#
								#html.inputField(name="images_per_page",bind=prc.gallery,label="Images per page (automatic calculated):",disabled=true)#
								#html.select(name="images_number_rows",bind=prc.gallery,options=prc.images_in_table,label="*Number Of Rows:",title="The number of rows in a table on a single gallery page.")#
								#html.select(name="images_number_columns",bind=prc.gallery,options=prc.images_in_table,label="*Number Of Columns:",title="The number of columns in a table on a single gallery page.")#
								#html.checkbox(name="use_lightbox",bind=prc.gallery,label="Use Lightbox:",class="textfield",title="Use Lightbox for your view")#
								<div class="form-actions">
									<input type="submit" value="Save" class="btn btn-danger">
									<button class="btn" onclick="return to('#event.buildLink(prc.xehGallery)#')">Cancel</button>
								</div>
								#html.endFieldSet()#
							#html.endForm()#
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--- Sidebar --->
	<div class="span3" id="main-sidebar">
		<cfinclude template="../sidebar/help.cfm" >
	</div>
</div>
</cfoutput>