<cfoutput>
	<!--- CB GB --->
#renderView(view="_tags/editors",module="contentbox-admin")#
<script type="text/javascript">
// toolbar Configuration
var	$imageForm = $( "##imageForm" );

$(document).ready( function()
{
 	// Editor Pointers
	$imageForm = $( "##imageForm" );
	setupEditors( $imageForm, true, '#event.buildLink( prc.xehImageSave )#' );
	var ckImageOnlyToolbar = $.parseJSON( '[{"name":"insert","items":["Image"]}]' );
	var $image				= $imageForm.find("##image");
	var $thumb				= $imageForm.find("##thumb");
	// Active Image
	$image.ckeditor(function(){}, {
		toolbar: ckImageOnlyToolbar,
		toolbarCanCollapse: true,
		height: 300,
		filebrowserBrowseUrl: 'http://localhost:8888/index.cfm/cbadmin/ckfilebrowser/',
		baseHref: 'http://localhost:8888//'
	});
	// Active Thumb
	$thumb.ckeditor(function(){}, {
		toolbar: ckImageOnlyToolbar,
		toolbarCanCollapse: true,
		height: 150,
		filebrowserBrowseUrl: 'http://localhost:8888/index.cfm/cbadmin/ckfilebrowser/',
		baseHref: 'http://localhost:8888//'
	});
});
</script>
</cfoutput>