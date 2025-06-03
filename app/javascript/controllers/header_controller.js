import { Controller } from "@hotwired/stimulus"
 //3 functions provioded by this library 
import {enter, leave, toggle} from 'el-transition'

export default class extends Controller {
  
    static targets = ['openUserMenu' , 'dropDown']
    //default method that gets call 
    connect() {
        //to check connectivity of stimulus
        //console.log("Header connected")

        //testing el-transiton working 
        //console.log("enter:" , enter);

        //definiing action and event  --- stimulus allows event controllers to be introduced and can be used 
        this.openUserMenuTarget.addEventListener("click" , (e) => {
            //console.log("Header clicked");
            openDropDown(this.dropDownTarget)
        })
    }

}

function openDropDown(element) {
    toggle(element).then(() => {
        console.log("Enter transition complete")
    })
}

// remove element when close
function closeDropDown() {
    leave(element).then(() => {
        element.destroy();
    })
}


