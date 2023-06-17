public class ContactTriggerHandler {
    
    public static void myMethod1(List<Contact> newList, Map<Id,Contact> newMap){
        system.debug('B4*newlist = '+newList); system.debug('B4**newMap = '+newMap);
    }
    
    public static void myMethod2(List<Contact> newList, Map<Id,Contact> newMap){
        system.debug('Af*newlist = '+newList); system.debug('Af**newMap = '+newMap);
    }
}


        /* Integer myVar = 0;
        for(Contact c : contacts){
            myVar++;
            c.Random__c = String.valueOf(myVar);
            system.debug('value : '+myVar);
        }*/
        /*if(myVar){
            myVar = false;
        }*/