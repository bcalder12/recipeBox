<!---
*Add check for measurement or way to add new measurements - or make dropdown?
*Hide recipe header form once submitted? or just display info?
*Show already submitted recipe ing/steps
--->

<!--- Set header and footer using CF custom tag --->
<cfimport taglib="customTags/" prefix="layout" />
<layout:page section="addrecipe">

<cfparam name="id" default = "1" type="integer" />
<cfset newID = #id# />

<!--- Params for recipe header --->
<cfparam name="form.submitHeader" default=0 />
<cfparam name="form.recipeTitle" default="" />
<cfparam name="form.recipeDesc" default="" />
<cfparam name="form.recipePrep" default="" />
<!--- Params for ingredients and amounts --->
<cfparam name="form.submitIngredient" default=0 />
<cfparam name="form.amount" default=0 />
<cfparam name="form.measure" default="" />
<cfparam name="form.ingredient" default="" />
<!--- Params for recipe steps --->
<cfparam name="form.submitStep" default=0 />
<cfparam name="form.stepNo" default=0 />
<cfparam name="form.stepDesc" default="" />

<h1 class="page-header">Add a Recipe</h2>

<div id="recipe-page">

<div class = "add-title">
  <cfoutput>
    <cfif !form.submitHeader || !form.submitIngredient || !form.submitStep>
      <form id="recipeHeaderForm" action="addrecipe.cfm" method="post">

        <label>Recipe Name: </label>
        <input name="recipeTitle" type="text" class="required" value="#form.recipeTitle#" />

        <label>Recipe Description: </label>
        <input name="recipeDesc" type="text" class="required" value="#form.recipeDesc#" />

        <label>Prep/cook time: </label>
        <input name="recipePrep" type="text" class="required" value="#form.recipePrep#" />

        <div>
          <input id="submitBtn" value="Add Recipe Name"  name="submit" type="submit" class="submitBtn" />
        </div>
        <input type="hidden" name = "submitHeader" value ="1" />
      </form>
    </cfif>
  </cfoutput>
</div><!--- end add title --->

<!--- form action for add recipe header --->
<!--- **add check if recipe already exists** --->
<cfif form.submitHeader>
  <cfquery name="addRecipeHeader">
  INSERT INTO
    recipes (recipe_id, recipe_title, recipe_summary, recipe_time, is_favorite)
  VALUES (0, <cfqueryparam value='#form.recipeTitle#' cfsqltype="cf_sql_char">,
    <cfqueryparam value='#form.recipeDesc#' cfsqltype="cf_sql_char">,
    <cfqueryparam value='#form.recipePrep#' cfsqltype="cf_sql_char">, 0);
  </cfquery>
  <cfquery name="getRecipeID">
  SELECT
    recipe_id
  FROM
    recipes
  WHERE
    recipe_title = <cfqueryparam value='#form.recipeTitle#' cfsqltype="cf_sql_char">
  </cfquery>
  <cfset newID = #getRecipeID.recipe_id# />
</cfif>


<div class="add-ing"><!--- Begin add ingredient --->
  <cfoutput>
    <form id="ingredientForm" action="addrecipe.cfm?id=#newID#" method="post">
      <label>Ingredient amount: </label>
      <input name="amount" type="float" class="required" value="#form.amount#" />

      <label>Measurement: </label>
      <input name="measure" type="text" class="required" value="#form.measure#" />

      <label>Ingredient name: </label>
      <input name="ingredient" type="text" class="required" value="#form.ingredient#" />

      <div>
        <input id="submitBtn" value="Add Ingredient"  name="submit" type="submit" class="submitBtn" />
      </div>
      <input type="hidden" name = "submitIngredient" value ="1" />
    </form>
  </cfoutput>
</div>

<!--- form action for adding an ingredient --->
<cfif form.submitIngredient>
  <cfquery name="checkIngredient">
  SELECT
    ingredient_id, ingredient_name
  FROM
    ingredients
  </cfquery>
  <cfset ing_id = 0 />

  <!--- Check if ingredient exists in database and get id if it is --->
  <cfloop query="checkIngredient">
    <cfif #form.ingredient# == #checkIngredient.ingredient_name#>
      <cfset ing_id = #checkIngredient.ingredient_id# />
    </cfif>
  </cfloop>
<!--- Add ingredient if not in database --->
  <cfif ing_id == 0>
    <cfquery name="addIngredient">
    INSERT INTO
      ingredients (ingredient_id, ingredient_name)
    VALUES (#ing_id#, <cfqueryparam value='#form.ingredient#' cfsqltype="cf_sql_char">);
    </cfquery>
    <cfquery name="getIngID">
    SELECT
      ingredient_id
    FROM
      ingredients
    WHERE
      ingredient_name = <cfqueryparam value='#form.ingredient#' cfsqltype="cf_sql_char">
    </cfquery>
    <cfset ing_id = #getIngID.ingredient_id# />
  </cfif>

  <cfquery name="checkMeasure">
  SELECT
    measurement_id, measurement_name
  FROM
    measurements
  </cfquery>
  <cfset measure_id = 0 />

  <!--- Check if measurement exists in database and get id if it is --->
  <cfloop query="checkMeasure">
    <cfif #form.measure# == #checkMeasure.measurement_name#>
      <cfset measure_id = #checkMeasure.measurement_id# />
    </cfif>
  </cfloop>

<cfquery name="addAmount">
  INSERT INTO
    amounts (amount_id, recipe_id, ingredient_id, measurement_id, ingredient_amount)
  VALUES
    (0, #newID#, #ing_id#, #measure_id#, <cfqueryparam value = '#form.amount#' cfsqltype="cf_sql_float">);
</cfquery>
</cfif> <!--- end form.submitIngredient --->

<!--- begin add recipe steps --->
<div class = "add-steps">
  <cfoutput>
    <form id="stepForm" action="addrecipe.cfm?id=#newID#" method="post">

      <label>Step Number: </label>
      <input name="stepNo" type="float" class="required" value="#form.stepNo#" />

      <label>Step Description: </label>
      <input name="stepDesc" type="text" class="required" value="#form.stepDesc#" />

      <div>
        <input id="submitBtn" value="Add Step"  name="submit" type="submit" class="submitBtn" />
      </div>
      <input type="hidden" name = "submitStep" value ="1" />
    </form>
  </cfoutput>
</div>
<!--- Begin adding new step to database --->
  <cfif form.submitStep>
    <cfquery name="addStep">
    INSERT INTO
      steps (step_id, recipe_id, step_number, step_summary)
    VALUES (0, #newID#, <cfqueryparam value="#form.stepNo#" cfsqltype="cf_sql_integer">,
      <cfqueryparam value= '#form.stepDesc#' cfsqltype="cf_sql_char">);
    </cfquery>
    <cfquery name="getRecipeID">
    SELECT
      recipe_id
    FROM
      recipes
    </cfquery>
  </cfif>

</div><!--- end recipe page --->

</layout:page>
