import 'package:flutter/material.dart';
import 'package:addnote/View/screens/Auth/validate.dart';
import 'package:addnote/controller/crud.dart';
import 'package:addnote/View/widgets/customtextform.dart';
import 'package:addnote/constants/links.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:addnote/main.dart';
import "dart:io";

class Addnote extends StatefulWidget {
  const Addnote({Key? key}) : super(key: key);

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> with Crud {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> stateform = GlobalKey();

  bool isloading = false;
  late File myfile;
  XFile? picker;
  bool isclicked=false;
  Future getImagefromcamera(context) async {
    picker = (await ImagePicker().pickImage(source:ImageSource.camera))!;
    if (picker != null) {
      Navigator.of(context).pop();
      isclicked=true;
      setState(() {
      myfile = File(picker!.path);

      // var filename1 = basename(picker!.path);
      // var filenamerandom = Random().nextInt(10000);
      // String filename = filenamerandom.toString() + filename1;
      });
    } else {
      return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          body: Row(
            children:const[
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
      isclicked=true;
      setState(() {
        myfile = File(picker!.path);
        
        // String Filename1 = basename(picker!.path);
        // int filenamerandom = Random().nextInt(10000);
        // String Filename = filenamerandom.toString() + Filename1;
      });
    } else {
      return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          body: Row(
            children:const [
              SizedBox(height: 60, width: 60, child: Text("select image")),
            ],
          ))
        ..show();
    }
  }
  addnote() async {
    if (picker == null) {
      return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          body: Row(
            children:const [
            SizedBox(
                  height: 60,
                  width: 60,
                  child: Text("select image")),
            ],
          ))
        ..show();
    }
    var formdata = stateform.currentState!;
    if (formdata.validate()) {
      formdata.save();
      isloading = true;
      setState(() {});
      var response = await postrequstwithfile(
      linkAddNotes,
          {
          "title":   title.text,
          "content": content.text,
          "id":      sharedpre.getString("id"),
          },myfile
        );

      isloading = false;
      setState(() {});

      if (response['status'] == "success") {
        Navigator.of(context).pushNamed("home");
      }else{
          return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          body: Row(
            children: const[
              SizedBox(
                  height: 60,
                  width: 60,
                  child: Text("there is an error"),
          )]))
        ..show(); 
      }
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
                  const SizedBox(
                    height: 15,
                  ),
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
                            ),
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
                          SizedBox(height: 37),
                          Text("image from gallery",
                          style: TextStyle(fontSize: 23))
                        ],
                      )),
  ],
  ));});
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView(
                children: [
                Form(
                  key: stateform,
                  child:Column(
                    children:[
                      Customtextfrom(
                        onsave: (p0) {
                        title.text=p0!; 
                        },
                          textediting: title,
                          hint: "title",
                          valida: (val) {
                            return validate(val!, 1000, 3);
                          }),
                      Customtextfrom(
                        onsave: ((p0) {
                          content.text=p0!;
                        }),
                          textediting: content,
                          hint: "content",
                          valida: (val) {
                            return validate(val!, 1000, 3);
                          }),
                      MaterialButton(
                          child: const Text("add image"),
                          onPressed: () {
                            addimage(context);
                          }),
                      MaterialButton(
                        color:isclicked?Colors.orange:Colors.blue,
                        onPressed: () async {
                          await addnote();
                        },
                        child: const Text("add note",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                )
              ]),
            ),
    );
  }
}
