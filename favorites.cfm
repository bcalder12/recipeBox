<!--- Query to get basic recipe info --->
<cfquery name="recipeTeaser">
  SELECT
    recipe_id AS recID,
    recipe_title AS title,
    recipe_summary AS summary,
    recipe_time AS prep,
    recipe_image AS image
  FROM
    recipes
  WHERE
    is_favorite = 1
  ORDER BY
    recipe_title ASC
</cfquery>

<!--- Set header and footer using CF custom tag --->
<cfimport taglib="customTags/" prefix="layout" />
<layout:page section="favorites">

<h1 class="page-header">Favorites</h1>
<!--- Start body of pages --->
<div id="main-content">
  <!---Start recipe cards --->
  <div class="recipe-card">
    <!-- Print recipe -->
   <cfoutput>
     <!--- Check that favorites exist --->
     <cfif #recipeTeaser.recID# == "">
       You haven't selected any favorites!
     </cfif>
     <cfloop query="recipeTeaser">
     <div class="recipe-heading">
       <img src="assets/images/#recipeTeaser.image#" alt=" " border="0" class="recipe-img"/>
      <!-- Recipe heading -->
      <h2><a href="recipepage.cfm?id=#recipeTeaser.recID#">#recipeTeaser.title#</a> <span>&nbsp;</span></h2>
      <h4>#recipeTeaser.summary#</h4>
      <br>
      <h5>#recipeTeaser.prep#</h5>
    </div> <!--- end recipe heading --->
  </cfloop>
    </cfoutput>
  </div><!--recipe card end -->
</div>		  <!--main content end -->


</layout:page>
