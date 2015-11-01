<cfoutput>
<!--- <cfdump var="#prc.image.getGallery_id#" abort=True> --->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<div class="header">
				<i class="icon-file-alt"></i>
				<cfif prc.image.getImage_id() gt 0>Edit<cfelse>Create</cfif> Image
			</div>
			<div class="body">

				#getPlugin("MessageBox").renderIt()#

				<div class="tabbable tabs-left">
					<ul class="nav nav-tabs">
						<li class="active"><a href="##galleryTab" data-toggle="tab"><i class="icon-list-alt"></i> Image Details</a></li>
					</ul>

					<div class="tab-content">
						<div class="tab-pane active" id="galleryItemTab">
							#html.startForm(name="imageForm", action=prc.xehImageSave, novalidate="novalidate", class="form-vertical")#
								#html.startFieldset(legend="Image")#
								<!--- #html.options(prc.galleries, "gallery_id", "name")# --->
								#html.select(name="gallery_id",bind=prc.image,options=html.options(prc.galleries, "gallery_id", "name"),label="*Gallery:",required="required",title="Gallery of your image")#
								#html.hiddenField(name="image_id",bind=prc.image)#
								#html.textField(name="title",bind=prc.image,label="*Title:",required="required",size="50",class="textfield",title="Title of your image")#
								#html.textarea(name="image",bind=prc.image,label="*Image:",required="required",rows="3",title="The image")#
								#html.textarea(name="thumb",bind=prc.image,label="*Thumb:",required="required",rows="1",title="Thumb of the image")#
								#html.textarea(name="description",bind=prc.image,label="*Description:",required="required",rows="3",title="Description of your image", class="width98")#
								#html.textField(name="image_date",bind=prc.image,label="*Date:",required="required",size="20",class="textfield",title="Creation date")#
								#html.checkbox(name="visible",bind=prc.image,label="Visible:",class="textfield",title="Set image visible or hidden in your gallery")#
								<div class="form-actions">
									<input type="submit" value="Save" class="btn btn-danger">
									<button class="btn" onclick="return to('#event.buildLink(prc.xehImage)#')">Cancel</button>
								</div>
								#html.endFieldSet()#

							#html.endForm()#
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="span3" id="main-sidebar">
		<cfinclude template="../sidebar/help.cfm" >
	</div>
</div>
</cfoutput>