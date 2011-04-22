<cfimport taglib="customtags" prefix="ss" />
<cfoutput>
<ss:table variable="mySpreadSheet">
	<ss:tr>
		<ss:th width="20">Col One</ss:th>
		<ss:th>Col Two</ss:th>
		<ss:th>Col Three</ss:th>		
	</ss:tr>
	<ss:tr>
		<ss:td width="30">Value One. This column has a lot of data which I hope will wrap. We shall see.</ss:td>
		<ss:td>Value Two</ss:td>
		<ss:td>Value Three</ss:td>		
	</ss:tr>
	<ss:tr>
		<ss:td>
			- Value Four Value Four Value Four
			- Value Four
		</ss:td>
		<ss:td>Value Five</ss:td>
		<ss:td width="20">Value Six</ss:td>		
	</ss:tr>	
</ss:table>
</cfoutput>
<cfheader name="content-disposition" value="attachment; filename=test.xls" />
<cfspreadsheet action="write" filename="#ExpandPath('temp.xls')#" name="mySpreadSheet" overwrite="true" />
<cfcontent file="#ExpandPath('temp.xls')#" reset="true" type="application/msexcel" deletefile="true" /> 

