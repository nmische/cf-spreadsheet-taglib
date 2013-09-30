<cfif thisTag.executionMode eq "end">	
	<cfparam name="attributes.sheetName" default="Sheet1" />
	<cfparam name="attributes.variable" default="spreadsheet" />
	<cfparam name="attributes.format" default="xls" />
	<cfparam name="attributes.spreadsheetObj" default="" />
	<cfparam name="thisTag.rows" default="#ArrayNew(1)#" />		
	<cfscript>

		if ( attributes.spreadsheetObj eq "" ) {
			ssObj = SpreadsheetNew(attributes.sheetName, (attributes.format eq "xlsx") );
		} else {
			SpreadsheetCreateSheet(attributes.spreadsheetObj, attributes.sheetName);
			SpreadsheetSetActiveSheet(attributes.spreadsheetObj, attributes.sheetName);
			ssObj = attributes.spreadsheetObj;
		}		
		
		// track column widths
		colWidths = [];		
		
		for (i = 1; i lte ArrayLen(thisTag.rows); i++) {
			row = thisTag.rows[i];
			values = "";
			headers = [];			
			for (j = 1; j lte ArrayLen(row.cells); j++) {
				cell = row.cells[j];
				SpreadsheetSetCellValue(ssObj,cell.value,i,j);
				
				format = {textwrap = true, verticalalignment="vertical_center"};
				
				// is it a header
				if(StructKeyExists(cell,"isHeader") and cell.isHeader) {
					format.bold = true;
				}

				if(StructKeyExists(cell,"dataformat")) {
					format.dataformat = cell.dataformat;
				}

				SpreadsheetFormatCell(ssObj,format,i,j);
				
				// get the width for the column							
				currWidth = (ArrayIsDefined(colWidths,j)) ? colWidths[j] : 0 ;
				newWidth = StructKeyExists(cell,"width") ? cell.width : 0 ;			
				colWidths[j] = Max(newWidth,currWidth);	
			}
		}		
		
		// set column width
		for (k = 1; k lte ArrayLen(colWidths); k++) {
			width = colWidths[k];
			if (width neq 0) {
				SpreadSheetSetColumnWidth(ssObj,k,width);
			}			
		}
		
		caller[attributes.variable] = ssObj;
	</cfscript>

</cfif>