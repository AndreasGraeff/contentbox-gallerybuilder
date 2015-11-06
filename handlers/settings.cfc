component extends="super"
{
	function index(event,rc,prc)
	{
		prc.settings = deserializeJSON(settingService.getSetting("gallery_builder"));
		event.setView(view="settings/index", module="contentbox-gallerybuilder");
	}


	function save(event,rc,prc)
	{
		var crudSetting = "";
		var newProperty = {};
		var newSettings = {};
		var objSetting = settingService.findWhere( { name="gallery_builder" } );
		if ( structKeyExists(rc,"gallery_path") )
		{
			crudSetting = serializeJSON({"gallery_path"=rc.gallery_path});
			newProperty = deserializeJSON(crudSetting);
			structAppend(newSettings, newProperty);
		}
		var currentSettings = deserializeJSON(objSetting.getValue());
		// append (overwrite) old settings
		structAppend(currentSettings, newSettings);
		objSetting.setValue( serializeJSON(currentSettings) );
		settingService.save( objSetting );
		settingService.flushSettingsCache();
		getPlugin("MessageBox").info("Settings Saved & Updated!");
		event.setView(view="gallery/index");
		setNextEvent(event=prc.xehGallery);
	}
}