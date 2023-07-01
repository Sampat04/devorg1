//comment #1
public with sharing class A6a {

public String country1 {get;set;}
public String country2 {get;set;}
public boolean boolval = false;
List<SelectOption> options = new List<SelectOption>(); 
   
//public List<selectoption> items {get;set;}   

public boolean getboolval()
{
      return boolval;
}


public string getpopulate()
{

    options = new List<SelectOption>();
    if(country1=='a')
    {
        options.add(new SelectOption('apple','apple')); 
        options.add(new SelectOption('apricots','apricots')); 
options.add(new SelectOption('avacado','avacado')); 
boolval = true;
return null;

//return options;
        
    }
    else if(country1=='b')
    {
    
        options.add(new SelectOption('banana','banana')); 
options.add(new SelectOption('blueberries','blueberries')); 
options.add(new SelectOption('breadfruit','breadfruit'));
boolval = true;
//return options;
    return null;
    }
    return null;
    

}


public list <selectoption> getitems1()
{

List<SelectOption> options2 = new List<SelectOption>(); 
options2.add(new SelectOption('none','none'));
options2.add(new SelectOption('A','A')); 
options2.add(new SelectOption('B','B')); 

return options2;
}


public list <selectoption> getitems2()
{ 

return options;
}


/*
public pagereference save()
{

    pagereference p = null;
    if(gender==null)
    {  
        p = page.fail;
        p.getparameters().put('','');   
    }
 
    else
    {  
        p = page.success;
        p.getparameters().put('','');   
    }
    
    p.setredirect(true);
    return p;
}


*/

public String getCountry1() {
return country1;
}
public void setCountry1(String country1) 
{ this.country1 = country1; }


public String getCountry2() {
return country2;
}
public void setCountry2(String country2) 
{ this.country2 = country2; }



public A6a () {
}



public A6a (account controller) {
}



//public String getCountry(){
//return country;}             


/*
public PageReference test() {
return null;
}
*/

public PageReference save1()
    {
  //      update employee;
        return null;    
    }


}