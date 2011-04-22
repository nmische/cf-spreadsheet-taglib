<cfif thisTag.executionMode eq "end">	
	<cfparam name="attributes.value" default="#Trim(thisTag.generatedContent)#" />
	<cfset attributes.isHeader = true />
	<cfset thisTag.generatedContent = "" />	
	<cfassociate basetag="CF_TR" datacollection="cells" />
</cfif>