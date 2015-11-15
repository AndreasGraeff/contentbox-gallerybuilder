<cfoutput>
<script type="text/javascript">
$(document).ready(function(){
	$('##images_number_rows').change(function(){
		calculate($('##images_number_rows').val(), $('##images_number_columns').val());
	});

	$('##images_number_columns').change(function(){
		calculate($('##images_number_rows').val(), $('##images_number_columns').val());
	});

	function calculate(rows, cols)
	{
		$('##images_per_page').val(rows*cols);
	}
});
</script>
</cfoutput>