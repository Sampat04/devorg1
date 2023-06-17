Public class MyController2 {
    Public string MyString_From_Method{get;set;}

    public MyController2(ApexPages.StandardController controller) {

    }

    public string ActionFunMethod(){
     MyString_From_Method = 'Method called from js using Action function';
     return null;
    }
}