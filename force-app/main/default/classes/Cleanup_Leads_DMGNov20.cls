global class Cleanup_Leads_DMGNov20 implements Database.Batchable<sObject>{
   
    public Database.querylocator start(Database.BatchableContext BC){        
        String Qry = 'select id,name from lead where id in (select leadid from campaignMember)';
        return Database.getQueryLocator(Qry);
    }
    
    public void execute(database.BatchableContext BC, List<Lead> leadList){
        for(lead ld : leadList)        
        {
            ld.DoNotCall = true;
        }
        update leadList;
    }
    
    public void finish(database.BatchableContext BC){  
        
    }   
    
}