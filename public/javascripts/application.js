// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function openWin(obj)
{
    name=obj.getSelected().text;
    str="\/devices\/"+name+"\/list\/";
    this.location=str;
}

//function showDialog(url)
//{
//    var val= showModalDialog(url,"true", "dialogWidth:450px;dialogHeight:300px;dialogLeft:100px;dialogTop:350px;status:no;help:no;location:no;resize=>no");
//    if(!val)
//    {
//        return;
//    }
//    else
//    {
//        document.all.returnvalue.value=val;
//    }
//}
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
//function   showDialog(url)
//{
//    if(   document.all   ) //IE
//    {
//        feature="dialogWidth:550px;dialogHeight:300px;dialogLeft:100px;dialogTop:350px;status:no;help:no";
//        window.showModalDialog(url,null,feature);
//    }
//    else
//    {
//        //modelessDialog可以将modal换成dialog=yes
//        //        feature ="width=550,height=300,menubar=no,toolbar=no,location=no,scrollbars=no,status=no,modal=yes";
//        //        window.open(url,null,feature);
//        feature="dialogWidth:550px;dialogHeight:300px;dialogLeft:100px;dialogTop:350px;status:no;help:no";
//        window.showModalDialog(url,null,feature);
//    }
//}