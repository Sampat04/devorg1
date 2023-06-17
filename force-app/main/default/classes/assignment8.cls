global class assignment8 implements Database.Batchable<sObject>
{
	String query;

	global Database.QueryLocator start(Database.BatchableContext BC)
	{
		query = 'select id,number_of_hours__c,assignment__c,date__c from timecard__c';
		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<Timecard__c> scope)
	{
		List<Missing_Timecard__c> mtlist = new List<Missing_Timecard__c>();
		for(Timecard__c t : scope)
		{
			if(t.Number_of_hours__c < 9)
			{
				
				Missing_Timecard__c mt = new Missing_Timecard__c();
				mt.Hrs_Missed__c = 9 - t.Number_of_hours__c;
				mt.assignment__c = t.assignment__c;
				mt.date__c = t.date__c;
				mtlist.add(mt);	
			}			
		}
        insert mtlist;
	}

	global void finish(Database.BatchableContext BC)
	{

	}
}