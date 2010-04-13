// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function openWin(obj)
{
    name=obj.getSelected().text;
    str="\/devices\/"+name+"\/list\/";
    this.location=str;
}

function showDetails(item_id,log_id){
    var oa = document.getElementById(item_id);
    var ob = document.getElementById(log_id);
    if(ob.style.display == "block"){
        ob.style.display = "none";
        oa.innerHTML = "[+]";
    }else{
        ob.style.display = "block";
        oa.innerHTML = "[-]";
    }
    return false;
}