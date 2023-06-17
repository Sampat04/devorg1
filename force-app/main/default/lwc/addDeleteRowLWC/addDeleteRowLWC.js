/* eslint-disable no-console */
import { LightningElement, api, track } from 'lwc';
import saveObject from '@salesforce/apex/AddDeleteRowController.saveObject';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AddDeleteRowLWC extends LightningElement {

    @api objectList = [];
    @api con;
    @api objectList2;
    @track reloadList = true;

    connectedCallback() {        
        this.createObjectData();
    }

    disconnectedCallback()
    {        
        //console.log('disconnected');
    }

    createObjectData()
    {
        this.objectList.push({                        
            'sobjectType': 'Custom_Object__c',
            'Name': '',
            'Field_1__c': '',
            'Field_2__c': ''
        });
         
       //console.log('this.objectList(parent) in createObjectData = '+JSON.stringify(this.objectList));
    }

    addNewRowParent(event)
    {
        //console.log('objectList in addNewRowParent = '+JSON.stringify(event.detail));
        this.objectList = event.detail;
    }
 
    removeRowParent(event) //filter
    {
        //this.reloadList = false;

        this.objectList = event.detail;
        //console.log('this.objectList in removeRowParent = '+JSON.stringify(this.objectList));
        this.objectList2 = JSON.stringify(this.objectList);
        //console.log('this.reloadList-'+this.reloadList);
        //this.reloadList = true;
    }

    handleFieldChangeParent(event)
    {
        //console.log('objectList in handleFieldChangeParent = '+JSON.stringify(event.detail));
        this.objectList = event.detail;
    }

    save(){              
        if(this.validateRequired())
        {
            saveObject({ ListCustomObject: this.objectList})
            .then(result => {
                this.con = result;
                
                const toastEvent = new ShowToastEvent({
                        title : 'Insert Successful',
                        message: 'The records were saved sucessfully',
                        variant: 'success',
                        mode: 'dismissible'
                    });
                this.dispatchEvent(toastEvent);


            })
            .catch(error => {
                this.error = error;
            });           
        }
        
        
    }

    validateRequired()
    {
        var isValid = true;
        var allObjectRows = this.objectList;
        var indexVar;

        for (indexVar = 0; indexVar < allObjectRows.length; indexVar++) {
            if (allObjectRows[indexVar].Name === '') {
                isValid = false;

                const evt = new ShowToastEvent({
                    title: 'Missing Name',
                    message: 'Name is blank for some rows',
                    variant: 'warning',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt);
            }
        }

        return isValid;
    }

    
    /*
validateRequired
Save
removeDeletedRow

    doInit: function(component, event, helper) {
        helper.createObjectData(component, event);
    },
 
    Save: function(component, event, helper) {
        if (helper.validateRequired(component, event)) { 
           
            var action = component.get("c.saveObject");
            action.setParams({
                "ListCustomObject": component.get("v.objectList")
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.objectList", []);
                    helper.createObjectData(component, event);
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Insert Sucessful',
                        message: 'The records were saved sucessfully',
                        type: 'success',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(action);
        }
    },
 
    addNewRow: function(component, event, helper) {
        helper.createObjectData(component, event);
    },
 
    removeDeletedRow: function(component, event, helper) {
        var index = event.getParam("indexVar");  
        var AllRowsList = component.get("v.objectList");
        AllRowsList.splice(index, 1);
        component.set("v.objectList", AllRowsList);
    }*/


    //===========HELPER

    /*
    createObjectData: function(component, event) {
                var RowItemList = component.get("v.objectList");
        RowItemList.push({
            'sobjectType': 'Custom_Object__c',
            'Name': '',
            'Field_1__c': '',
            'Field_2__c': ''
        });  
        component.set("v.objectList", RowItemList);
        
    },

    validateRequired: function(component, event) {
        var isValid = true;
        var allObjectRows = component.get("v.objectList");
        for (var indexVar = 0; indexVar < allObjectRows.length; indexVar++) {
            if (allObjectRows[indexVar].Name == '') {
                isValid = false;
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Missing Field',
                    message: 'Name is required at row ' + (indexVar + 1) + '.',
                    type: 'warning',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
        }
        return isValid;
    },*/


    

        //console.log('entered parent delete');
        //this.deleteIndex = event.detail;
        //console.log('deleteIndex = '+this.deleteIndex);
        //this.AllRowsList = this.objectList;
        //console.log('AllRowsList 1 = '+JSON.stringify(this.AllRowsList));
        //this.objectList.splice(this.deleteIndex,1);
        //this.objectList = this.objectList;
        //this.objectList = this.AllRowsList;
        //console.log('removeDeletedRow objectList = '+JSON.stringify(this.objectList));
        //component.set("v.objectList", AllRowsList);

}