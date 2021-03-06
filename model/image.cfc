component persistent="true" table="cb_gallery_builder_image"
{
	property name="image_id" fieldtype="id" column="id" generator="identity" setter="false";
	property name="gallery_id" notnull="true" cfc="contentbox.modules.contentbox-gallerybuilder.model.gallery" fieldtype="many-to-one" fkcolumn="gallery_id" lazy="true" fetch="join";
	property name="title" type="string" notnull="false" length="200" default="";
	property name="thumb" type="string" notnull="true" length="200" default="";
	property name="image" type="string" notnull="true" length="200" default="";
	property name="description" notnull="false" length="2000" default="";
	property name="image_date" type="string" notnull="false" index="idx_image_date";
	property name="created_at" ormtype="timestamp" notnull="true";
	property name="updated_at" ormtype="timestamp" notnull="false";
	property name="visible" ormtype="boolean" notnull="true" default="true" dbdefault="1";

	function init() { return this; }

	array function validate()
	{
		var errors = [];
		if ( not len(image) ) { arrayAppend(errors, "Image is required"); }
		return errors;
	}
}
