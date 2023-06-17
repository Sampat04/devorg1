public class Assignment3a
{
   
    public string str;
    
    public Assignment3a(ApexPages.StandardController controller) {
    
        string[] month = new string[12];
        month[0] = 'January';
        month[1] = 'February';
        month[2] = 'March';
        month[3] = 'April';
        month[4] = 'May';
        month[5] = 'June';
        month[6] = 'July';
        month[7] = 'August';
        month[8] = 'September';
        month[9] = 'October';
        month[10] = 'November';
        month[11] = 'December';
    
        integer i;
        
        for(i=0;i<12;i++)
        {
              str = str + month[i];
              
              if(i!=11)
              str = str + ' < ';
        }
   
    }
    
    public string getstr()
    {             
        return str;
    }
    
    public void setstr()
    {
        
    }



}