# CF Spreadsheet Taglib

This is a very basic set of custom tags that allow you to create Excel files from ColdFusion 9 using syntax similar to HTML tables.

##Example

    <cfimport taglib="customtags" prefix="ss" />
    <ss:table variable="mySpreadSheet">
      <ss:tr>
        <ss:th width="20">Col One</ss:th>
        <ss:th>Col Two</ss:th>
        <ss:th>Col Three</ss:th>		
      </ss:tr>
      <ss:tr>
        <ss:td width="30">This column has a lot of data which will wrap. Blah, blah, blah.</ss:td>
        <ss:td>Blah</ss:td>
        <ss:td>Blah</ss:td>		
      </ss:tr>
      <ss:tr>
        <ss:td>Blah</ss:td>
        <ss:td>Blah</ss:td>
        <ss:td width="20">
          Blah, Blah
          Blah, Blah
        </ss:td>		
      </ss:tr>	
    </ss:table>
    
    <cfheader name="content-disposition" value="attachment; filename=test.xls" />
    <cfspreadsheet action="write" filename="#ExpandPath('temp.xls')#" name="mySpreadSheet" overwrite="true" />
    <cfcontent file="#ExpandPath('temp.xls')#" reset="true" type="application/msexcel" deletefile="true" /> 

