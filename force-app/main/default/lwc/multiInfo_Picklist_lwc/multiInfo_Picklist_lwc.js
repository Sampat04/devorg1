/* eslint-disable no-console */
import { LightningElement, api, track } from 'lwc';
import getObjs from '@salesforce/apex/MultiInfo_PicklistControllerLwc.getObjs';
import getSObjectLabel from '@salesforce/apex/MultiInfo_PicklistControllerLwc.getSObjectLabel';

export default class MultiInfo_Picklist_lwc extends LightningElement {
    @api objectApiName;
    @track filterOptions;  //list
    @track selectedFilter;  //string
    @track filteredObjs;  //list
    @track objLabel;  //string
    @track objs;  //list 


    connectedCallback() {
        var sObj = this.objectApiName;
        console.log('in connectedCallback sobj=' + sObj);
        console.log('objs' + this.objs);
        console.log('objlabel-' + this.objLabel);

        if (sObj) {
            this.getData(sObj);
            this.getLabelForRecord(sObj);
        } else {
            sObj = "Account";
            this.getData(sObj);
            this.getLabelForRecord(sObj);
        }
    }


    doFunction() {
        var x = this.selectedFilter;
    }


    populateFilterOptions() {
        // eslint-disable-next-line vars-on-top
        // eslint-disable-next-line no-unused-vars
        var filterOptions = this.filterOptions;
        var objs = this.objs;
        var index, obj, option;
        var options = [];
        // eslint-disable-next-line guard-for-in
        for (index in objs) {
            obj = objs[index];
            option = {
                "label": "Id: " + obj.Id + " - Name: " + obj.Name,
                "value": obj.Id.toString(),
            };
            options.push(option);
        }
        this.filterOptions = options;
    }


    getData(sObj) {
            getObjs({ sObjName: sObj })
                .then(result => {
                    this.objs = result;
                    this.populateFilterOptions();
                })
                .catch(error => {
                    this.error = error;
                    console.log('getData ERROR is:' + error.message);
                });
    }


    getLabelForRecord(sObj) {
        getSObjectLabel({ sObjName: sObj })
            .then(result => {
                var label = result;
                this.objLabel = label;
            })
            .catch(error => {
                this.error = error;
                console.log('getLabelForRecord ERROR is:' + error.message);
            });
    }

}