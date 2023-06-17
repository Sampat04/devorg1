import { LightningElement } from 'lwc';
export default class ParentTest extends LightningElement {

    connectedCallback(){
        console.log('parent cc');
    }

}