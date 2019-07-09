<cfcomponent>

<cffunction name="getRecipeHeader" output="false" returntype="query" access="public">
	<cfset var recipeHeader = "" />
	<cfquery name="recipeHeader">
		SELECT
			recipe_id AS recID,
			recipe_title AS title,
			recipe_summary AS summary,
			recipe_time AS prep,
			recipe_image AS image
		FROM
			recipes
		ORDER BY
			recipe_id ASC
	</cfquery>
		<cfreturn recipeHeader />
	</cffunction>

</cfcomponent>
