public class OpptyHandler {
    public static void method1(List<Opportunity> newList){
        
        for(Opportunity opp : newList){
            opp.CloseDate = system.today();      
        }
        
        system.debug('entered oppty trigger');
        Set<String> accIdSet = new Set<String>();
        Opportunity opp1 = newList[0];
        Map<Id,Opportunity> accOppMap = new Map<Id,Opportunity>();
        
        for(Opportunity opp : newList){
            opp.CloseDate = system.today();
            accIdSet.add(opp.AccountId);
            accOppMap.put(opp.AccountId,opp);
        }
        
        List<Account> acclist = [Select Id,Name,(Select Id,Name from Opportunities) from Account where Id in :accIdSet];
        Map<Id,Account> accMap = new Map<Id,Account>([Select Id,Name,(Select Id,Name from Opportunities) from Account where Id in :accIdSet]);
        
        
        //for()
        
        
        for(Opportunity oppty : newList){
            if(accMap.get(oppty.AccountId).Opportunities.size() == 1){
                oppty.addError('Account already has oppty');
            }
        }
        
        
        system.debug('acclist = '+acclist);
        
        for(Id accId : accOppMap.keySet()){
            //system.debug('acc name is = '+acc.Name+' size is ='+acc.Opportunities.size());
            if(accMap.get(accId).Opportunities.size() == 1){
                system.debug('entered error block');
                accOppMap.get(accId).addError('Account already has oppty');
            }
        }
        
        for(Account acc : acclist){
            system.debug('acc name is = '+acc.Name+' size is ='+acc.Opportunities.size());
            if(acc.Opportunities.size() == 1){
                system.debug('entered error block');
                opp1.addError('Account already has oppty');
            }
        }
    }
    
    public static void method2(List<Opportunity> newList, Map<Id,Opportunity> oldMap){
        List<Task> taskList = new List<Task>();
        for(Opportunity opp : newList){
            Opportunity oldOpp = oldMap.get(opp.Id);
            if(opp.StageName == 'Qualification' && opp.StageName != oldOpp.StageName){
                Task t = new Task();
                t.Subject = 'July 26 Task '+system.now();
                t.WhatId = opp.Id;
                taskList.add(t);
            }
        }
        insert taskList;
    }
}