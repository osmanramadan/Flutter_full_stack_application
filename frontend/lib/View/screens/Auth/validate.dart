

validate(String val,int max,int min){
if(val.isEmpty){
return "the field shouldnt be empty";
}
if(val.length>max){
return "the field shouldnt be greater than $max";
}
if(val.length<min){
return "the field shouldnt be less than $min";
}

}
