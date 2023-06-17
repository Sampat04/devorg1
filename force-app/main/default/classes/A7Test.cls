@isTest
public class A7Test
{
    static testmethod void debugmethod()
    { 
        pagereference p = page.assignment7a;
        test.setcurrentpage(p);
        Assignment7aConta cont = new Assignment7aConta();
        string url = cont.save().geturl();
        system.debug('* ' + cont.country + ' *' + url);
        system.assertequals('/apex/success?error=pass',url);
        
    } 
}