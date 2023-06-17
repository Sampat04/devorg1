public with sharing class ext4a {
    public integer noOfRecords ;
public static integer PageSize{get;set;}
ApexPages.StandardSetController setCon ;

    public ext4a(ApexPages.StandardSetController controller) {
        PageSize = 5;
        setCon =controller;
        setCon.setpagesize(PageSize);

        //comment added

    }

}