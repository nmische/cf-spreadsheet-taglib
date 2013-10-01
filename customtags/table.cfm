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
			ssObj = attributes.spreadsheetObj;
			SpreadsheetCreateSheet(attributes.spreadsheetObj, attributes.sheetName);
			SpreadsheetSetActiveSheet(attributes.spreadsheetObj, attributes.sheetName);
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
				
				// get the width for the column, can be auto						
				currWidth = (ArrayIsDefined(colWidths,j)) ? colWidths[j] : 0 ;
				newWidth = StructKeyExists(cell,"width") ? cell.width : 0 ;

				if (currWidth neq "auto") {
					if (newWidth eq "auto") {
						colWidths[j] = "auto";	
					} else if (isNumeric(newWidth)) {
						colWidths[j] = Max(newWidth,currWidth);	
					} else {
						colWidths[j] = Max(0,currWidth);	
					}
				}
				
			}
		}		
		
		// set column width
		for (k = 1; k lte ArrayLen(colWidths); k++) {
			width = colWidths[k];

			if (width eq "auto") {
				// have to drop down to POI for auto sized columns
				try {
					sheet = ssObj.getWorkBook().getSheet(JavaCast("string",attributes.sheetName));
					sheet.autoSizeColumn(JavaCast("int",k-1));
				} catch (any e) { 
					WriteLog(text="CF-SPREADSHEET-TAGLIB: Error setting auto sized column.",application="true",log="Application",type="Error");
				}
			} else if (width neq 0) {
				if ( ListGetAt(server.coldfusion.productversion,1,",") eq 10 and ListGetAt(server.coldfusion.productversion,3,",") eq 11 ) {
					// work around bug 3616845 (https://bugbase.adobe.com/index.cfm?event=bug&id=3616845)
					WriteLog(text="CF-SPREADSHEET-TAGLIB: Using auto sized column instead of provided value of #width#, see https://bugbase.adobe.com/index.cfm?event=bug&id=3616845.",application="true",log="Application",type="Warning");
					try {
						sheet = ssObj.getWorkBook().getSheet(JavaCast("string",attributes.sheetName));
						sheet.autoSizeColumn(JavaCast("int",k-1));
					} catch (any e) { 
						WriteLog(text="CF-SPREADSHEET-TAGLIB: Error setting auto sized column.",application="true",log="Application",type="Error");
					}
				} else {
					SpreadSheetSetColumnWidth(ssObj,k,width);
				}
			}	
		}

		caller[attributes.variable] = ssObj;
	</cfscript>

</cfif>