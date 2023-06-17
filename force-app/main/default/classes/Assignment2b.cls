public with sharing class Assignment2b {

    Employee__c employee;
    public Assignment2b(ApexPages.StandardController controller) {

    }


    public Assignment2b(ApexPages.StandardSetController controller) {

    }
    
    
    public PageReference fetchfunc()
    {
        
        pagereference secondpage = page.assignment2c;
        employee = [select id from employee__c where id = :ApexPages.currentPage().getParameters().get('id')];
        secondpage.setredirect(true);
        secondpage.getparameters().put('id',employee.id);      
        return secondpage;
    
    }

    
    
}