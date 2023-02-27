
import 'package:flutter/material.dart';
import 'package:addnote/View/screens/Auth/validate.dart';
import 'dart:io';
import "package:awesome_dialog/awesome_dialog.dart";
import 'package:addnote/controller/crud.dart';
import 'package:addnote/View/widgets/customtextform.dart';
import 'package:addnote/constants/links.dart';
import 'package:image_picker/image_picker.dart';


class Editnote extends StatefulWidget {
  
  // ignore: prefer_typing_uninitialized_variables
  final notes;
  const Editnote({required this.notes ,Key? key }) : super(key: key);

  @override
  State<Editnote> createState() => _EditnoteState();
}

class  _EditnoteState extends State< Editnote> with Crud {
late TextEditingController title=TextEditingController();
late TextEditingController content=TextEditingController();

GlobalKey<FormState> stateform=GlobalKey<FormState>();

bool isloading=false;

File? myfile;
XFile? picker;

  Future getImagefromcamera(context) async {
    picker = (await ImagePicker().pickImage(source: ImageSource.camera))!;
    if (picker != null) {
      Navigator.of(context).pop();
      setState(() {
      myfile = File(picker!.path);

        // var Filename1 = basename(picker!.path);
        // var filenamerandom = Random().nextInt(10000);
        // String Filename = filenamerandom.toString() + Filename1;
      });
    } else {
      return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          body: Row(
            children: const[
              SizedBox(height: 60, width: 60, child: Text("select image")),
            ],
          ))
        ..show();
    }
  }

  getImagefromgallery() async {
    picker = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    if (picker != null) {
      Navigator.of(context).pop();
      setState(() {
        myfile = File(picker!.path);
        // String Filename1 = basename(picker!.path);
        // int filenamerandom = Random().nextInt(10000);
        // String Filename = filenamerandom.toString() + Filename1;
      });
    } else {
      return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context:context,
          body: Row(
            children:const [
              SizedBox(height: 60, width: 60, child: Text("select image")),
            ],
          ))
        ..show();
    }
  }

 addimage(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
              height: 500,
              width: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.all(30),
                      child: const Text(
                        "please choose image",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(height: 15),
                  InkWell(
                      onTap: () {
                        getImagefromcamera(context);
                      },
                      hoverColor: Colors.blue,
                      child: Row(
                        children:const [
                          Icon(Icons.camera),
                          SizedBox(
                            height: 37,
                          ),
                          Text(
                            "image from camera",
                            style: TextStyle(fontSize: 23),
                          )
                        ],
                      )),
                  const SizedBox(height: 6),
                  InkWell(
                      hoverColor: Colors.blue,
                      onTap: () {
                        getImagefromgallery();
                      },
                      child: Row(
                        children:const [
                          Icon(Icons.browse_gallery),
                          SizedBox(
                            height: 37,
                          ),
                          Text(
                            "image from gallery",
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      )),
                ],
              ));
        });}

updatenote()async{
var formdata=stateform.currentState!;  
if(formdata.validate())
{

formdata.save();
setState(() {
  
});

if(myfile==null){
var   response=await postrequest(linkEditNotes,{
  "notetitle":title.text.toString(),
  "notecontent":content.text.toString(),
  "noteid":widget.notes['notes_id'].toString(),
  "imagename":widget.notes['notes_image'].toString()
});
if(response['status']=="success"){
Navigator.of(context).pushNamed("home");
}
}else{
var   response=await postrequstwithfile(linkEditNotes,{
  "notetitle":title.text,
  "notecontent":content.text,
  "noteid":widget.notes['notes_id'].toString(),
  "imagename":widget.notes['notes_image'].toString()

},myfile!);

if(response['status']=="success"){
Navigator.of(context).pushNamed("home");}
}
}
}

@override
  void initState() {
    super.initState();
    title.text=widget.notes['notes_title'];
    content.text=widget.notes['notes_content'];

  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      isloading?const Center(child:CircularProgressIndicator()):
      ListView(children: [
        Padding(
          padding: const EdgeInsets.only(top:20),
          child: Form(
            key: stateform,
            child: Column(children: [
              Customtextfrom(
              
                onsave: (p0) {
                title.text=p0!;
              },
              textediting:title,
              hint:"title",valida:(val){
                return validate(val!, 1000, 3);
              }),
              Customtextfrom(
              
                onsave:((p0) {
                  content.text=p0!;
                }),
                textediting:content , hint:"content", valida:(val){
                return validate(val!, 1000,3 );
              }),
              MaterialButton(
              color:Colors.blue,
              onPressed: ()async{
              await  addimage(context);
              },
                child:const Text("change image",style:TextStyle(color: Colors.white),)),
              MaterialButton(color:Colors.blue,onPressed: ()
              async{
                await updatenote();
                },
                child:const Text("update note",style:TextStyle(color: Colors.white),),)
            ],),
          ),
        )
      ]),
    );
  }
}
