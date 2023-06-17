public class TaskTriggerHelper {
    
    public static void updateFlag(List<Task> newTasks)
    {		               
        if(newTasks.size()==1 && newTasks[0].whatId!=null){
			system.debug('reached');            
            List<Opportunity> opptyList = [Select id from Opportunity where id = :newTasks[0].whatId];
            if(!opptyList.isEmpty()){
                newTasks[0].Loan_Application_Task__c = true;
            }
        }        
    }
}