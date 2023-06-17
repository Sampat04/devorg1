public class Assignment7aConta {

public String country {get;set;}
public String country1 {get;set;}
public String country2 {get;set;}
   
//public List<selectoption> items {get;set;}   
    
public list <selectoption> getitems()
{

List<SelectOption> options = new List<SelectOption>(); 
options.add(new SelectOption('male','male')); 
options.add(new SelectOption('female','female')); 

return options;
}




public list <selectoption> getitems1()
{

List<SelectOption> options = new List<SelectOption>(); 
options.add(new SelectOption('US','US')); 
options.add(new SelectOption('CANADA','Canada')); 
options.add(new SelectOption('MEXICO','Mexico')); 

return options;
}


public list <selectoption> getitems2()
{

List<SelectOption> options = new List<SelectOption>(); 
options.add(new SelectOption('read','read')); 
options.add(new SelectOption('write','write')); 
options.add(new SelectOption('play','play')); 

return options;
}


public pagereference save()
{

    pagereference p = null;
    if(country==null)
    {  
        p = page.fail;
        p.getparameters().put('error','fail');   
    }
 
    else
    {  
        p = page.success;
        p.getparameters().put('error','pass');   
    }
    
    p.setredirect(true);
    return p;
}



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




public String getCountry() {
return country;
}
public void setCountry(String country) 
{ this.country = country; }


public Assignment7aConta() {

    country = 'male';

}



public Assignment7aConta(account controller) {
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