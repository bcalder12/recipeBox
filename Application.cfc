component {

this.name ='myrecipes';
this.datasource='myrecipes';
this.applicationTimeout = CreateTimeSpan(10,0,0,0);
this.sessionManagement = true;
this.sessionTimeout = CreateTimeSpan(0,0,30,0);

function onApplicationStart() {
application.myname = "BC";
application.myPosition = "A Great Developer";
application.utilities = CreateObject('cfc.utilities');
return true;
}

function onRequestStart(string targetPage) {
  if(structKeyExists(url,'reload')) {
    onApplicationStart();
  }
}

}
