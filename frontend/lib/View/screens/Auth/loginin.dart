import 'package:flutter/material.dart';
import 'package:addnote/View/screens/Auth/validate.dart';
import 'package:addnote/controller/crud.dart';
import 'package:addnote/View/widgets/customtextform.dart';
import 'package:addnote/constants/links.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:addnote/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';




class Loginin extends StatefulWidget {


  const Loginin({ Key? key}) : super(key: key);
  

  @override
  State<Loginin> createState() => _LogininState();
}

class _LogininState extends State<Loginin> {
  

  TextEditingController email=TextEditingController();

  TextEditingController password=TextEditingController();

final Crud _crud=Crud();

GlobalKey<FormState> stateform = GlobalKey<FormState>();

validateemail(email){
 final bool isValid = EmailValidator.validate(email);
if(isValid==true){
return null;
}else{
return "email not valid";
}
}

bool isloading=false;

signin()async {
var validatedata=stateform.currentState!;
  
if(validatedata.validate()){

isloading=true;
setState(() {
});
var response= await _crud.postrequest
(
  linksignin, {
  
  
  "email"    :email.text,
  "password" :password.text,
}
);
if(response['status']=="success")
{
sharedpre.setString("id", response['data']['id'].toString());
Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
}else{
    isloading=false;
    setState(() {
});
    return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          body: Row(
            children:const [
              SizedBox(height: 60, width: 120, child: Text("password or email is wrong")
              ),
            ],
          ))..show();
}
isloading=false;
setState(() {

});
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isloading ? const Center(child:Center(child:CircularProgressIndicator()),):
      ListView(
        children: [
        Form(
          key:stateform,
          child:Column(
          children: [
          Image.asset("images/logo.png"),
          Customtextfrom(
          onsave:(sa){
          },
          hint:"email",
          textediting:email,
          valida:(val){
          return  validateemail(val!);
          }
          ),
          Customtextfrom(
          onsave:(sa){
          },hint:"password",textediting: password,valida:(val){
            return  validate(val!, 20, 10);
          },),
          const SizedBox(height: 20,),
          
          MaterialButton(color:Colors.blue,padding:const EdgeInsets.symmetric(horizontal:70,vertical:20),
          child:const Text("Sign in ",style:TextStyle(color:Colors.white))
          ,onPressed: ()async{
          await signin();
          }
          ),
          const SizedBox(height: 3,),
          MaterialButton(padding:const EdgeInsets.symmetric(horizontal:70,vertical:20),child:const Text("Sign up"),onPressed: (){
            Navigator.of(context).pushNamed("loginup");
          })
          ],
        )
        
        )
      ]),
    );
  }
}