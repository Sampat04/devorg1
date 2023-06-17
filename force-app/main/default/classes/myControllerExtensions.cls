public class myControllerExtensions{

    public account acc;

    public myControllerExtensions(ApexPages.StandardController controller) {
    
        this.acc = (account)controller.getRecord();
    }
    
    public string getGreeting()
    {
    
        return 'Hello User '+ UserInfo.getName() + ' from ' + acc.name + ' and ' + acc.type ;
    
    }
}