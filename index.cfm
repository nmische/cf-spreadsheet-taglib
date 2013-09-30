<cfimport taglib="customtags" prefix="ss" />
<ss:table variable="mySpreadSheet">
  <ss:tr>
    <ss:th width="20">Col One</ss:th>
    <ss:th>Col Two</ss:th>
    <ss:th>Col Three</ss:th>        
  </ss:tr>
  <ss:tr>
    <ss:td width="30">This column has a lot of data which will wrap.</ss:td>
    <ss:td>Blah, Blah</ss:td>
    <ss:td>Blah, Blah, Blah</ss:td>     
  </ss:tr>
  <ss:tr>
    <ss:td>Blah</ss:td>
    <ss:td>Blah, Blah</ss:td>
    <ss:td width="20">Blah, Blah, Blah</ss:td>        
  </ss:tr>  
</ss:table>

<ss:table variable="mySpreadSheet" spreadsheetobj="#mySpreadSheet#" sheetname="Sheet 2">
  <ss:tr>
    <ss:th width="20">Col One</ss:th>
    <ss:th>Col Two</ss:th>
    <ss:th>Col Three</ss:th>
    <ss:th>Col Four</ss:th>       
  </ss:tr>
  <ss:tr>
    <ss:td width="30">This column has a lot of data which will wrap.</ss:td>
    <ss:td dataformat="0.00">1</ss:td>
    <ss:td dataformat="m/d/yy"><cfoutput>#DateFormat(Now(),'short')#</cfoutput></ss:td>  
    <ss:td dataformat="$##,######0.00;[Red]($##,######0.00)">1234.89</ss:td>  
  </ss:tr>
  <ss:tr>
    <ss:td>Blah</ss:td>
    <ss:td dataformat="0.00">2.3456</ss:td>
    <ss:td dataformat="m/d/yy"><cfoutput>#DateFormat(DateAdd("d",1,Now()),'short')#</cfoutput></ss:td>
    <ss:td dataformat="$##,######0.00;[Red]($##,######0.00)">-99</ss:td>         
  </ss:tr>  
</ss:table>

<cfheader name="content-disposition" value="attachment; filename=test.xls" />
<cfspreadsheet action="write" filename="#ExpandPath('./temp.xls')#" name="mySpreadSheet" overwrite="true" />
<cfcontent file="#ExpandPath('./temp.xls')#" reset="true" type="application/msexcel" deletefile="true" />
