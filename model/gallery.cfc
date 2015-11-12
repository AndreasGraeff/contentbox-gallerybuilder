/* gallery entity */
component persistent="true" table="cb_gallery_builder_gallery"
{
	property name="gallery_id" fieldtype="id" column="id" generator="identity" setter="false";
	property name="name" type="string" notnull="true" length="200" default="";
	property name="slug" type="string" notnull="true" length="200" default="" unique="true" index="idx_slug";
	property name="images_per_page" ormtype="integer" notnull="true" default=15;
	property name="images_number_rows" ormtype="integer" notnull="false" default=3;
	property name="images_number_columns" ormtype="integer" notnull="false" default=5;
	property name="created_at" ormtype="timestamp" notnull="true";
	property name="updated_at" ormtype="timestamp" notnull="false";
	property name="use_lightbox" ormtype="boolean" notnull="true" default="true" dbdefault="1";


	// Constructor
	function init() { return this; }

	// TODO, remove for gallery_id? Needed to populate image editor
	function get() { return this; }


	array function validate()
	{
		var errors = [];
		name				= left(name,200);
		slug				= left(slug,200);
		// Required parameter
		if ( not len(name) ) { arrayAppend(errors, "Name is required"); }
		if ( not len(slug) ) { arrayAppend(errors, "Slug is required"); }
		if ( not isnumeric(images_per_page) or images_number_rows lt 1 or images_number_columns gt 30 ) { arrayAppend(errors, "Invalid value for images per page"); }
		return errors;
	}
}
