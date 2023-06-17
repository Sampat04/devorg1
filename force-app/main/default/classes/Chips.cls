public class Chips {
    
    public Chips(){
        Account acc = [Select id from Account limit 1];
        system.debug('acc = '+acc);
        acc.Account_Ext_ID__c = '5555';
        update acc;
        
    }

}