<cfoutput>
<!--- #renderView( "viewlets/assets" )# --->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<h4>Your ORM is not completed. Please reload it first!</h4>

		<p>(Menu: Admin Actions -> Reload ORM)</p>
	</div>

	<!--- Sidebar --->
	<div class="span3" id="main-sidebar">
		<cfinclude template="../sidebar/help.cfm" >
	</div>
</div>
</cfoutput>