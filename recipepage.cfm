<!---
*Move more queries to utilities?
--->

<cfimport taglib="customTags/" prefix="layout" />
<layout:page section="recipepage">

<cfparam name="id" default = "1" type="integer" />
<cfparam name="form.submitted" default=0 />

<!--- Query to get the ingredients and amounts for selected recipe --->
<cfquery name="ingredientList">
  SELECT
    i.ingredient_name AS ingredient,
    a.ingredient_amount AS amount,
    m.measurement_name AS measure,
    r.is_favorite AS favorite
  FROM
    ingredients AS i
  JOIN
    amounts AS a ON a.ingredient_id = i.ingredient_id
  JOIN
    measurements AS m ON m.measurement_id = a.measurement_id
  JOIN
    recipes AS r ON r.recipe_id = a.recipe_id
  WHERE
    r.recipe_id = #id#
  ORDER BY
    r.recipe_title,
    i.ingredient_name ASC
  </cfquery>
<!--- query to get steps for selected recipe --->
<cfquery name="recipeSteps">
	SELECT
    s.step_number AS stepNum,
    s.step_summary AS stepSum,
    r.recipe_title AS recTitle
	FROM
		steps AS s
  JOIN
    recipes AS r ON r.recipe_id = s.recipe_id
  WHERE
    r.recipe_id = #id#
	ORDER BY
		r.recipe_title,
    s.step_number ASC
</cfquery>

<!--- use component function to get recipe header --->
<cfset utilities = CreateObject('cfc.utilities') />
<cfset recipeHeader = QueryGetRow(utilities.getRecipeHeader(),#id#) />

<div class="recipe-page-header">
<cfoutput>

     <h2 class="page-header">#recipeHeader.title#<span>&nbsp;</span></h2>
     <h4>#recipeHeader.summary#</h4>
     <br>
     <h5>#recipeHeader.prep#</h5>

     <!--- Button to add or remove from favorites --->
       <form id="form" action="recipepage.cfm?id=#id#" method="post">
         <div>
           <cfif #ingredientList.favorite# == 0 && form.submitted ||
           #ingredientList.favorite# == 1 && !form.submitted>
             <input id="submitBtn" value="Remove from Favorites"  name="submit" type="submit" class="submitBtn" />
           <cfelse>
             <input id="submitBtn" value="Add to Favorites"  name="submit" type="submit" class="submitBtn" />
             </cfif>
         </div>
         <input type="hidden" name = "submitted" value ='1' />
       </form>
       <br>

       <!-- Update whether or not recipe is favorite -->
       <cfif form.submitted>
         <cfif #ingredientList.favorite# == 0>
           <cfset addToFavorite = 1 />
           <p>Recipe added to favorites!</p>
           <cfelse>
             <cfset addToFavorite = 0 />
             <p>Recipe removed from favorites.</p>
         </cfif>
           <cfquery name="addToFavorite">
           UPDATE
             recipes
           SET
             recipes.is_favorite = #addToFavorite#
           WHERE
             recipes.recipe_id = #id#
           </cfquery>
       </cfif>

     </div> <!--- recipe page header end --->

  <div class = "recipe-page">

   <div class = "col-left">
     <img src="assets/images/#recipeHeader.image#" alt=" " border="0"/>
   </div> <!--- End left column --->

  <div class="col-right">
    <!---Print the ingredient list --->
    <cfloop query="ingredientList">
        <p>
          <span>#trim(ingredientList.amount)/1# #ingredientList.measure#(s) #ingredientList.ingredient#</span>
        </p>
        <br>
      </cfloop>

      <!--- Print instruction steps for recipe --->
      <cfloop query = "recipeSteps">
        <p>#stepNum#. #stepSum#</p>
      </cfloop>
    </cfoutput>
  </div> <!--- End right column --->

  </div><!--recipe page end -->



</layout:page>
