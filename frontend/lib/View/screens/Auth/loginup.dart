
import 'package:flutter/material.dart';
import 'package:addnote/View/screens/Auth/validate.dart';
import 'package:addnote/controller/crud.dart';
import 'package:addnote/View/widgets/customtextform.dart';
import 'package:addnote/constants/links.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';


class Loginup extends StatefulWidget {
  const Loginup({ Key? key }) : super(key: key);

  @override
  State<Loginup> createState() => _LoginupState();
}

class _LoginupState extends State<Loginup> {
  
  
  TextEditingController name=TextEditingController();
  
  TextEditingController email=TextEditingController();

  TextEditingController password=TextEditingController();

final Crud _crud=Crud();



validateemail(email){
 final bool isValid = EmailValidator.validate(email);
if(isValid==true){
return null;
}else{
return "email not valid";
}
}

bool isloading=false;
GlobalKey<FormState> stateformm = GlobalKey<FormState>();


signup()async {

var validatedata=stateformm.currentState!;
  
if(validatedata.validate()){

isloading=true;
setState(() {
});
var response= await _crud.postrequest
(
  linksignup, {
  "username" :name.text,
  "email"    :email.text,
  "password" :password.text,
}
);
if(response['status']=="success")
{
  
  Navigator.of(context).pushNamedAndRemoveUntil("loginin", (route) => false);
  Navigator.pushNamed(context, "loginin");

}
isloading=false;
setState(() {
  
});

}}
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      body:isloading?const Center(child:Center(child:CircularProgressIndicator()),):
      ListView(children: [
        Form(
          key: stateformm,
          child: 
        Column(
          children: [
          Image.asset("images/logo.png"),
          Customtextfrom(onsave: (s){},hint:"name",textediting:name,valida:(val){
          return validate(val!, 10, 5);
          },),
          Customtextfrom(onsave: (s){},hint:"email",textediting:email,valida:(val){
          return  validateemail(val!);
          },),
          Customtextfrom(onsave: (s){},hint:"password",textediting: password,valida:(val){
            return  validate(val!, 20, 10);
          },),
          const SizedBox(height: 20,),
          
          MaterialButton(color:Colors.blue,padding:const EdgeInsets.symmetric(horizontal:70,vertical:20),
          child:const Text("Sign up ",style:TextStyle(color:Colors.white))
          ,onPressed: ()async{
          await signup();
          }
          ),
          const SizedBox(height: 3,),
          MaterialButton(padding:const EdgeInsets.symmetric(horizontal:70,vertical:20),child:const Text("Sign in")
            ,onPressed: (){
            Navigator.of(context).pushNamed("loginin");

          })

          
          ],
        )
        
        )
      ]),
    );
  }
}