public with sharing class PPe1 {

    Contact c;
    public PPe1(ApexPages.StandardController controller) {
    
        if(c == null)
        c = [select id,name from contact where id =: Apexpages.currentpage().getparameters().get('id')];        

    }
    
    public pagereference send()
    {   
        pagereference secondpage = page.PalmerPets1a;
        secondpage.setredirect(true);     
        secondpage.getparameters().put('id',c.id);
        return secondpage;
    
    }

}