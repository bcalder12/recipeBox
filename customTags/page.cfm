<cfif thisTag.executionMode eq "start">

<cfparam name="attributes.section" default="home" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="description" content="Personal recipe catalog" />
	<meta name="keywords" content="coldfusion, recipes, database" />
	<meta http-equiv="X-UA-Compatible" content="IE=9" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<title>A Collection of Recipes</title>

	<!-- CSS Files -->
	<link href="assets/reset.css" rel="stylesheet" type="text/css" />
	<link href="assets/style.css" rel="stylesheet" type="text/css" />
</head>

<body>

	<!-- wrapper -->
	<div class="clr" id="top-head">&nbsp;</div>
	<div id="page-container">
		<!--header -->
		<div id="header" >
					<!--// Navigation //-->
					<div class="menu-nav">
							<ul class="nav-list" id="nav">
								<li class="home" <cfif attributes.section == "home"> id="selected"</cfif>><a href="index.cfm">Home</a></li>
								<li class="about" <cfif attributes.section == "addrecipe"> id="selected"</cfif>><a href="addrecipe.cfm">Add a Recipe</a></li>
								<li class="resume" <cfif attributes.section == "favorites"> id="selected"</cfif>><a href="favorites.cfm">Favorites</a></li>
							</ul>
					</div>
					<!--// Navigation End //-->
					<h2 class="header-title"><a href = "index.cfm">My Recipe Box</a></h2>
		</div>
		<!--header end -->

		<cfelse>
	</div>  <!--Page Container / wrapper end -->
	</body>
	</html>

</cfif>
