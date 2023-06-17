public class TrialContact {
    
    public void fetch()
    {
        list<contact> c = [select account.name from contact ];
        system.debug(c);
        system.debug('data'+c[0].account.name);
    }

}