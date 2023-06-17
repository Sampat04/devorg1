public class StudentController{


//    Public String student{get;set;}
    Public List<string> studlist{get;set;}
    
    Public String student{
    
    get
    {
        return student;
    
    }
    
    set
    {
        student = value + ' oyerq';
    }
    
    }
    
    
    
  /*   Public String studlist{
    
    get
    {
        return studlist;
    
    }
    
    set
    {
  //      student = value + ' oyer';
        studlist = value + ' kx';
    }
    
    }
    */
    
    Public StudentController()
    {
        student='abcd';
        studList = new List<string>();
        studlist.add('sam');
        studlist.add('bam');
        
        
    }

}