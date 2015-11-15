<cfoutput>
<!--- <cfdump var="#prc.settings#"> --->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<div class="header">
				<i class="icon-list-alt icon-large"></i>
				Default Settings
			</div>

			<div class="body">

				<div class="well well-small">
					<div class="lead">
						<button class="btn btn-inverse" onclick="window.location.href='#event.buildLink(prc.xehGallery)#';return false;"><i class="icon-reply"></i> Galleries</button>
					</div>
				</div>

				<div class="tab-content">
					<div class="tab-pane active" id="galleryItemTab">
						#html.startForm(name="settingsForm", action=prc.xehSettingsSave, novalidate="novalidate")#
							#html.startFieldset(legend="Settings")#
							#html.textField(name="GALLERY_PATH", label="*Gallery Path:", value="#prc.settings.GALLERY_PATH#", class="textfield large", title="Name of the gallery path, change for your SEO needs")#
							#html.textField(name="SIZE_IMAGE", label="*Size of image/thumb in gallery page:", value="#prc.settings.SIZE_IMAGE#", class="textfield large", title="Size of the thumb image (square), take a little larger value")#
							<div class="form-actions">
								<button class="btn" onclick="return to('#prc.xehCancel#')">Cancel</button>
								<input type="submit" value="Save" class="btn btn-danger">
							</div>
							#html.endFieldSet()#
						#html.endForm()#
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