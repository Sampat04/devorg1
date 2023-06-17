public with sharing class A4c {

    public list<project__c> options {get;set;}
    public list<assignment__c> options1 {get;set;}
    public list<WrapperClass> wc {get;set;}
    
    public date mydate {get;set;}
    
    
    public class WrapperClass
    {
    //abc
        public decimal hrs {get;set;}
        public assignment__c aname {get;set;}
        
        public wrapperclass(decimal h,assignment__c a)
        {       
            hrs = h;
            aname = a;        
        }  
        
    }
    
    
    public PageReference save1() {
        options = [select id,name from project__c where start_date__c =: getmydate()];
        system.debug(options);
        return null;
    }
  
    public decimal x;
    
    
    public PageReference display() {
        wc = new list<wrapperclass>();
        
        options1 = [select id,name,contact__r.firstname from assignment__c where project__c =: apexpages.currentpage().getparameters().get('id')];
        
        for(assignment__c a1 :options1)
        {
            string x1 = a1.id;
        
            x = 0;
            
            list<timecard__c> t1 = [select number_of_hours__c from timecard__c where assignment__c =: x1];
            
            for(timecard__c t2 : t1)
            {          
                x = x + t2.number_of_hours__c;           
            }
            
            wc.add(new wrapperclass(x,a1));
        
        
        }
            
        system.debug(options1);
        return null;
    }
    
    public date getmydate()
    {    
        return mydate;
    }
    
    public list<assignment__c> getoptions1()
    {    
        return options1;
    }  
       
    public list<project__c> getoptions()
    {    
        return options;
    }     
    
    public list<wrapperclass> getwc()
    {    
        return wc;
    }     

}