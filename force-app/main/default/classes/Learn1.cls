public class Learn1 {

    List<Account> acts = [select name,type,fax,industry,phone from account limit 5];
    
    public String name{get{name = 'abcde'; return name;}set;}
    public String email{get;set;}
    public String searchString{get;set;}
    public list<contact> listofAcc{get;set;}
    
    public pageReference search()
    {
        listofAcc = [select id,name from contact where lastname like :('%' + searchString + '%')];
        
        return null;
    }
    
    public list<account> getactsqq()
    {
        return acts;
    }
    
    public void createContact()
    {
        contact c = new contact();
        c.LastName = name;
        c.Email = email;
        
        insert c;
    }
    
    public pageReference moveToPage1()
    {
        
        return page.LearnVF1;
    }
    
}