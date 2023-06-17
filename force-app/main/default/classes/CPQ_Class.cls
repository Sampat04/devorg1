public class CPQ_Class {

    @AuraEnabled
    public static void createInvoice(id orderId, List<id> orderItemIdList)
    {
        
        Invoice__c inv = new Invoice__c();
        insert inv;
        
        List<OrderItem> orderitemList = [select id from OrderItem where id in :orderItemIdList];
        List<InvoiceLineItem__c> invList = new List<InvoiceLineItem__c>();
        
        for(OrderItem ol : orderitemList)
        {
            InvoiceLineItem__c invLineItem = new InvoiceLineItem__c();
            invLineItem.invoice__c = inv.id;
//            invLineItem.product = ;
            invList.add(invLineItem);
            
        }        
        insert invList;
    }     
       
    public id invoiceID;    
    public CPQ_Class(ApexPages.StandardController controller) {
		invoiceID = ApexPages.currentPage().getParameters().get('id');
    }

    public list<InvoiceLineItem__c> getInfo()
    {
    	list<InvoiceLineItem__c> info = [select id from InvoiceLineItem__c where Invoice__c = :invoiceID]; 
        return info;
    }

}