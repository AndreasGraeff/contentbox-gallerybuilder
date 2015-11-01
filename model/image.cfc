/* galleryItem entity */
component persistent="true" table="cb_gallery_builder_image"
{
	property name="image_id" fieldtype="id" column="id" generator="identity" setter="false";
	// 1:n relation
	property name="gallery_id" notnull="true" cfc="contentbox.modules.contentbox-gallerybuilder.model.gallery" fieldtype="many-to-one" fkcolumn="gallery_id" lazy="true" fetch="join";
	// props
	property name="title" type="string" notnull="false" length="200" default="";
	property name="thumb" type="string" notnull="true" length="200" default="";
	property name="image" type="string" notnull="true" length="200" default="";
	property name="description" notnull="false" length="2000" default="";
	property name="image_date" type="string" notnull="false" index="idx_image_date";
	property name="created_at" ormtype="timestamp" notnull="true";
	property name="visible" ormtype="boolean" notnull="true" default="true" dbdefault="1";

	function init() { return this; }

	array function validate()
	{
		var errors = [];
		title				= left(title,200);
		image				= left(image,2000);
		thumb				= left(thumb,2000);
		// Required
		if ( not len(title) ) { arrayAppend(errors, "Title is required"); }
		if ( not len(image) ) { arrayAppend(errors, "Image is required"); }
		if ( not len(thumb) ) { arrayAppend(errors, "Thumb is required"); }
		return errors;
	}
}
