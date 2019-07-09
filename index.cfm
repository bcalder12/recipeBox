
<!--- Set header and footer using CF custom tag --->
<cfimport taglib="customTags/" prefix="layout" />
<layout:page section="home">

<cfset utilities = CreateObject('cfc.utilities') />
<cfset recipeHeader = utilities.getRecipeHeader() />

<h1 class="page-header">All Recipes</h1>

<!--- Start body of pages --->
<div id="main-content">
  <!---Start recipe cards --->
  <div class="recipe-card">
    <!-- Print recipe -->
   <cfoutput>
     <cfloop query="recipeHeader">
     <div class="recipe-heading">
       <img src="assets/images/#recipeHeader.image#" alt=" " border="0" class="recipe-img"/>
      <!-- Recipe heading -->
      <h2><a href="recipepage.cfm?id=#recipeHeader.recID#">#recipeHeader.title#</a> <span>&nbsp;</span></h2>
      <h4>#recipeHeader.summary#</h4>
      <br>
      <h5>#recipeHeader.prep#</h5>
    </div> <!--- end recipe heading --->
  </cfloop>
    </cfoutput>
  </div><!--recipe card end -->
</div>		  <!--main content end -->


</layout:page>
