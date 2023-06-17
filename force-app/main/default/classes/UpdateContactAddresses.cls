global class UpdateContactAddresses implements Database.Batchable<sObject>, Schedulable {
    
    // instance member to retain state across transactions

    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug('entered 1');
        return Database.getQueryLocator(
            'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
            'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
            'MailingState, MailingPostalCode FROM Contacts) FROM Account ' + 
            'Where name = \'GenePoint12\''
        );
    }
    
    global void execute(Database.BatchableContext bc, List<Account> scope){

        system.debug('entered 2');
        system.debug('acc list = '+scope);
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                
                contacts.add(contact);

            }
        }
        system.debug('entered 3');
        update contacts;
    }    
    
    
    global void finish(Database.BatchableContext bc){
        System.debug(' EXECUTED SUCCESSFULLY');
        
    }    
    
    
    global void execute(SchedulableContext sc)
    {
        
	}
    
    
}