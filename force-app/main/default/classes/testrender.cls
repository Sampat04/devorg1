public with sharing class testrender {

    public contact c {get;set;}
    public String favDate{set;get;}
    public testrender(ApexPages.StandardController controller) {
        
    }

    public pagereference func1()
    {
        c = [select id,name,email,phone,birthdate,fav_date__c,assistantname from contact where name = 'Mario Ruiz'];
         c = [select id,name,email,phone,birthdate,fav_date__c,assistantname from contact where name = 'Mario Ruiz'];
       
       Date dt = c.fav_date__c;
       favDate=dt.day()+'/'+dt.month()+'/'+dt.year();
        return null;
    }
    
    public contact getc()
    {
    
        return c;
    }
    
    public void setc(contact c) 
    { 
    
        this.c=c; 
    }

}