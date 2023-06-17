public with sharing class A6extra {

public String country1 {get;set;}

public List<contact> options {get;set;}
public List<selectoption> options1 {get;set;}
public List<skill__c> options2 {get;set;}
 
public list <selectoption> getitems()
{        
    options = new list<contact>();
    options1 = new List<selectoption>(); 
    
    options = [select firstname from contact];      
    for(contact c:options)
    {   
        options1.add(new selectoption(c.firstname,c.firstname));    
    }  
    return options1;
}

public String getCountry1() {
return country1;
}

public void setCountry1(String country1) 
{ this.country1 = country1; }

public List<skill__c> getoptions2()
{
    return options2;
} 


public PageReference save1()
{
    options2 = new list<skill__c>();   
    contact q = [select id from contact where firstname =: getcountry1()];   
    options2 = [select id,name,Skill_1_Proficiency__c from skill__c where contact__c =: q.id];
       
    return null;
}

public PageReference save()
{
    update options2;
    return null;
}









}