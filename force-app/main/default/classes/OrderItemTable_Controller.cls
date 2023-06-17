public class OrderItemTable_Controller {
    
    @AuraEnabled
    public static list<orderitem> getData(id RecordId)
    {
        list<orderitem> orderitemlist = [select id,quantity,unitprice,Product2Id,Product2.Name,
                                         ProductName__c,closed__c from orderitem where orderid =: RecordId];       
        return orderitemlist;
    }
    
    @AuraEnabled
    public static void deleteAction(id OrderItemId)
    {
        List<OrderItem> oiList = [select id from orderitem where id =: OrderItemId];
        Delete oiList;
        
    }
    
    @AuraEnabled
    public static void closeAction(String OrderItemId)
    {       
        system.debug('order item was closed');
        system.debug('orderitemid = '+OrderItemId);
        
        List<OrderItem> oiList = [select id,closed__c from orderitem where id =: OrderItemId];
        system.debug('orderitemlist size = '+oiList.size());
        oiList[0].closed__c = true;
        update oiList;
    }

}