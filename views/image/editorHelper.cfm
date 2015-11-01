<cfoutput>
	<!--- CB GB --->
#renderView(view="_tags/editors",module="contentbox-admin")#
<script type="text/javascript">
$( document ).ready( function() {
 	// Editor Pointers
	$imageForm = $( "##imageForm" );
	//setupEditors( $imageForm, #prc.cbSettings.cb_page_excerpts#, '#event.buildLink( prc.xehImageSave )#' );
	setupEditors( $imageForm, #prc.cbSettings.cb_page_excerpts#, '#event.buildLink( prc.xehImageSave )#' );
} );
</script>
</cfoutput>