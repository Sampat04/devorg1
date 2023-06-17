public class Custom2bb {

    Employee__c employee;
    public Employee__c getEmployee() {
    
        if(employee == null)
      employee = [select fname__c,country__c,state__c from employee__c where id = :ApexPages.currentPage().getParameters().get('id')];      
        return employee;
    }
    
    public PageReference save()
    {
        update employee;
        pagereference secondpage = page.assignment2b;
        secondpage.setredirect(true);
       
        return secondpage;
    
    }
    
    public PageReference save1()
    {
        update employee;
        return null;    
    }


}