import { LightningElement, api, wire} from 'lwc';
import fetchListViews from '@salesforce/apex/DynamicListViewController.fetchListViews';

export default class DynamicListViewLwc extends LightningElement {

    @api objectApiName = 'Lead';
    @api ListViews;
    @api LoadAllListView = false;
    @api rows = 25;
    @api showSearchBar = false;
    @api showActionBar = false;
    @api enableInlineEdit = false;
    @api showRowLevelActions = false;
    @api listViewName = 'Working';
    @api i;
    @api optionValues = [];

@wire(fetchListViews , 
    {strObjName: '$objectApiName',
     strListViews: '$ListViews',
     loadAllListViews: '$loadAllListView'})

     wiredContacts({ error, data }) {
        if (data) {

            this.ListViews = data;
            for(this.i = 0; this.i < this.ListViews.length; this.i++) {
                this.optionValues.push({
                    class : "optionclass",
                    label : this.ListViews[this.i].label,
                    value : this.ListViews[this.i].value
                });
            }

            this.body = [];
        } 

        else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    }


    connectedCallback()
    {
        this.objectApiName = 'Lead';
        this.ListViews = 'abc';
    }
        

    get listViewNameNotNull()
    {
        return this.listViewName!=null;       
    }

    /*
    doInit : function(component,event){
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS") {                 
                $A.util.removeClass(component.find("myDiv"), "slds-hide");
                $A.util.addClass(component.find("myDiv"), "slds-show");
                
                var listViews = response.getReturnValue();
                for(var i = 0; i < listViews.length; i++) {
                    optionValues.push({
                        class : "optionclass",
                        label : listViews[i].label,
                        value : listViews[i].value
                    });
                }




                lviews.set("v.options", optionValues);
                component.set("v.body" , []);
                var rows = component.get("v.rows");
                var showSearchBar = component.get("v.showSearchBar");
                var showActionBar = component.get("v.showActionBar");
                var enableInlineEdit = component.get("v.enableInlineEdit");
                var showRowLevelActions = component.get("v.showRowLevelActions");
                $A.createComponent(            
                    "lightning:listView",
                    {
                        "objectApiName" : sObjectName,
                        "listName" : listViews[0].value,
                        "rows": rows,
                        "showActionBar":showActionBar,
                        "enableInlineEdit":enableInlineEdit,
                        "showRowLevelActions":showRowLevelActions,
                        "showSearchBar":showSearchBar
                    } ,
                    function(newListView, status, errorMessage){
                        if (status === "SUCCESS") {
                            var bodyResult = [];
                            bodyResult.push(newListView);
                            component.set("v.body", bodyResult);
                        }
                        else if (status === "INCOMPLETE") {
                            console.log("No response from server or client is offline.");
                        }
						else if (status === "ERROR") {
                            console.log("Error: " + errorMessage);
                        }
                    }            
                ); 
            }
        });
        $A.enqueueAction(action); 
    },
    
    onListViewChange : function(component, event, helper) {
        helper.showRecordsData(component,event,helper);
    }*/

}

/*
({
    doInit : function(component,event){
        var sObjectName = component.get("v.sObjectName");
        var ListViews = component.get("v.ListViews");
        var LoadAllListView = component.get("v.LoadAllListView");
        var lviews = component.find("lviews");
        var optionValues = [];
        
        var action = component.get("c.fetchListViews");
        action.setParams({
            "strObjName": sObjectName,
            "strListViews" : ListViews,
            "loadAllListViews" : LoadAllListView
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS") {                 
                $A.util.removeClass(component.find("myDiv"), "slds-hide");
                $A.util.addClass(component.find("myDiv"), "slds-show");
                
                var listViews = response.getReturnValue();
                for(var i = 0; i < listViews.length; i++) {
                    optionValues.push({
                        class : "optionclass",
                        label : listViews[i].label,
                        value : listViews[i].value
                    });
                }
                lviews.set("v.options", optionValues);
                component.set("v.body" , []);
                var rows = component.get("v.rows");
                var showSearchBar = component.get("v.showSearchBar");
                var showActionBar = component.get("v.showActionBar");
                var enableInlineEdit = component.get("v.enableInlineEdit");
                var showRowLevelActions = component.get("v.showRowLevelActions");
                $A.createComponent(            
                    "lightning:listView",
                    {
                        "objectApiName" : sObjectName,
                        "listName" : listViews[0].value,
                        "rows": rows,
                        "showActionBar":showActionBar,
                        "enableInlineEdit":enableInlineEdit,
                        "showRowLevelActions":showRowLevelActions,
                        "showSearchBar":showSearchBar
                    } ,
                    function(newListView, status, errorMessage){
                        if (status === "SUCCESS") {
                            var bodyResult = [];
                            bodyResult.push(newListView);
                            component.set("v.body", bodyResult);
                        }
                        else if (status === "INCOMPLETE") {
                            console.log("No response from server or client is offline.");
                        }
						else if (status === "ERROR") {
                            console.log("Error: " + errorMessage);
                        }
                    }            
                ); 
            }
        });
        $A.enqueueAction(action); 
    },
    
    onListViewChange : function(component, event, helper) {
        helper.showRecordsData(component,event,helper);
    }
})



=======

helper

({    
    showRecordsData : function(component, event, helper) {
        var sObjectName = component.get("v.sObjectName");
        var rows = component.get("v.rows");
        var showSearchBar = component.get("v.showSearchBar");
        var showActionBar = component.get("v.showActionBar");
        var enableInlineEdit = component.get("v.enableInlineEdit");
        var showRowLevelActions = component.get("v.showRowLevelActions");
        var selectedName = component.find("lviews").get("v.value");
        var sObjectName = component.get("v.sObjectName");
        component.set("v.listViewName", selectedName);
        component.set("v.body" , []);
        $A.createComponent(            
            "lightning:listView",
            {
                "objectApiName" : sObjectName,
                "listName" : selectedName,
                "rows": rows,
                "showActionBar":showActionBar,
                "enableInlineEdit":enableInlineEdit,
                "showRowLevelActions":showRowLevelActions,
                "showSearchBar":showSearchBar
            } ,
            function(newListView, status, errorMessage){
                if (status === "SUCCESS") {
                    var bodyResult = [];
                    bodyResult.push(newListView);
                    component.set("v.body", bodyResult);
                    console.log("bodyResult "+bodyResult);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.");
                }
				else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                }
            }            
        );  
    }
    
}) */