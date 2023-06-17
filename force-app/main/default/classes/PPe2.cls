public with sharing class PPe2 {

   public integer counter=0;  //keeps track of the offset
   public integer list_size=5; //sets the page size or number of rows
   public integer total_size; //=6;
   public list<deal__c> data;
   
   public integer pagenumber;
   public integer Totalpages;
   
   public list<ImageAssign> mydata=new list<ImageAssign>();
     
    Contact c;
    deal__c d;

    public List<Deal__c> deallist = new list<deal__c>();
        
    public PPe2(ApexPages.StandardController controller) {
    
        
        c = [select id,name,Deals_Accepted__c,Deals_rejected__c from contact 
        where id =: Apexpages.currentpage().getparameters().get('id')]; 
             
        total_size = [select count() from deal__c where Valid_Through__c >= TODAY AND Available_Deals__c > 0];
              
        }

    public List<deal__c> getdeallist()
    {       
        deallist = [select id,name,Valid_Through__c,Available_Deals__c from deal__c 
        where Valid_Through__c >= TODAY AND Available_Deals__c > 0 
        order by Valid_Through__c,Available_Deals__c,name limit :list_size offset :counter ];
        
        return deallist;
    }
    
    
    
    
    
    
    
    
    
    
public class ImageAssign{
      public boolean v{get;set;}
      public deal__c de{get;set;}
      public string imageurl{get;set;}
      public string imagestatus{get;set;}
      public boolean buttonstatus{get;set;}
      
      public ImageAssign(deal__c  mydeal,string img,boolean vv,string i,boolean b){
  
      de=mydeal;
      imageurl=img;
      v=vv;
      imagestatus = i;
      buttonstatus = b;
      
      }
 
} 
    
public list<ImageAssign> getmydata()
{

      string status;
      boolean button;
      integer flag;
      mydata =new list<ImageAssign>();
            
            
            
      data=[SELECT Available_Deals__c,Id,Name,Valid_Through__c FROM Deal__c 
      where ( (Valid_Through__c  >=:system.today()) and Available_Deals__c >0) 
      order by Valid_Through__c,Available_Deals__c,Name limit :list_size offset :counter];
        
      contact z = [select id,name,Deals_Accepted__c,Deals_rejected__c from contact 
        where id =: Apexpages.currentpage().getparameters().get('id')]; 
        
      List<deal_action__c> y = [select id,action__c,deal__c,contact__c from deal_action__c where contact__c =: z.id];
      
    
       string url='/servlet/servlet.FileDownload?file=';
       
              
       for(deal__c dd:data){
       
          flag = 0;
          for(deal_action__c q2: y)
          {                                
              if(q2.deal__c == dd.id)
              {
                  system.debug('deal approved/rejected');
                  status = q2.action__c;
                  button = false;
                  flag = 1;
                  break;
              }                   
          }
          
          if(flag==0)
          {
          system.debug('deal available');
                  
              status = 'Available';
              button = true;
      
          }
              
        list<attachment> mf=[select Id,ParentId, Name, Description, LastModifiedDate from Attachment where ParentId = :dd.id ];
        system.debug(mf.size());
        
        if(mf.size()>0){
                                system.debug('status is '+status);
                               mydata.add(new ImageAssign(dd,url+mf[0].id,true,status,button));
                       //        attach.add(mf[0].id);  
        }
        else{
                     mydata.add(new ImageAssign(dd,'',false,status,button));
                //   attach.add('dummy.jpg'); 
        } 
                
                
    }

return mydata;
}
  
  
  
  
  
  
  
  
  
    
    public pagereference accept()
    {      
    
        c = [select id,name,Deals_Accepted__c,Deals_rejected__c from contact 
        where id =: Apexpages.currentpage().getparameters().get('id')]; 

        
        d = [select id,name,acceptances__c,Rejections__c from deal__c 
        where id =: Apexpages.currentpage().getparameters().get('ix')]; 

       
        c.Deals_Accepted__c += 1;
        update c;
                     
        d.Acceptances__c += 1;
        update d;
        
        deal_action__c da = new deal_action__c();
        da.action__c = 'Accepted';
        da.contact__c = c.id;
        da.deal__c = d.id;
        insert da;
    
        return null;
    }

    public pagereference reject()
    {
          
        d = [select id,name,acceptances__c,Rejections__c from deal__c 
        where id =: Apexpages.currentpage().getparameters().get('ix')]; 

    
        c.Deals_rejected__c += 1;
        update c;
        
        d.Rejections__c += 1;
        update d;
        
        deal_action__c da = new deal_action__c();
        da.action__c = 'Rejected';
        da.contact__c = c.id;
        da.deal__c = d.id;
        insert da;
    
        return null;
    }
    
    public pagereference backtocont()
    {
        pagereference secondpage = page.PalmerPetsa;
        secondpage.setredirect(true);     
        secondpage.getparameters().put('id',c.id);
        return secondpage;
    
    
    }
    
     public PageReference Beginning() { //user clicked beginning
      counter = 0;
      return null;
   }

   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      return null;
   }

   public PageReference Next() { //user clicked next button
      counter += list_size;
      return null;
   }

   public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      return null;
   }

   public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
   }

   public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
   }

   public Integer getTotal_size() {
      return total_size;
   }

   public Integer getPageNumber() {
      return counter/list_size + 1;
   }

   public Integer getTotalPages() {
      if (math.mod(total_size,list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }

    
    
    
}