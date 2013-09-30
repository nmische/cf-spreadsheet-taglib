<cfif thisTag.executionMode eq "end">
	<cfparam name="thisTag.cells" default="#ArrayNew(1)#">	
	<cfset attributes.cells = thisTag.cells />		
	<cfassociate basetag="CF_TABLE" datacollection="rows" />
</cfif>