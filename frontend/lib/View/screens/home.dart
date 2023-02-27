import 'package:flutter/material.dart';
import 'package:addnote/View/widgets/cardnote.dart';
import 'package:addnote/controller/crud.dart';
import 'package:addnote/constants/links.dart';
import 'package:addnote/main.dart';
import 'package:addnote/View/screens/notes/editnote.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class Homepage extends StatefulWidget  {
  const Homepage({ Key? key }) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with Crud {
bool isloading=false;

deletenote(AsyncSnapshot snap ,int index)async{
var repoofdelete= await postrequest(linkDeleteImageFile,
{"dir":linkDeleteImage,"name":snap.data['data'][index]["notes_image"]});

if(repoofdelete['status']=='fail'){
          return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          body: Row(
            children:const [
              SizedBox(height: 60, width: 120, child: Text("Network error")
              ),
            ],
          ))..show();
}

var repo=await postrequest(linkDeleteNotes, {
            "noteid":snap.data['data'][index]['notes_id'].toString()
          });

          if(repo['status']=="success"){
          setState(() {
          });
          return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          body: Row(
            children:const [
              SizedBox(height: 60, width: 120, child: Text("succefully deleted")),
            ],
          ))..show();
          }
          else{
          return AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          body: Row(
            children:const [
              SizedBox(height: 60, width: 60, child: Text("try delete again")),
            ],
          ))..show();
          }

}


viewnotes()async{
var response=await postrequest(linkViewNotes,{
    "id":sharedpre.getString("id").toString()
    }
    );
return response;
  }
@override
  void initState() {
  
    super.initState();
    viewnotes();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(onPressed: (){
        Navigator.of(context).pushNamed("addnotepage");
      },child:const Icon(Icons.add),),
    appBar:AppBar(actions: [
    

    
      MaterialButton(onPressed: (){
        sharedpre.clear();
        Navigator.of(context).pushNamed("loginin");
      },
      child:const Icon(Icons.clear),)
    ]),
    body:isloading ?
    const Center(child:CircularProgressIndicator()):
    ListView(
      children: [
        FutureBuilder(
        future:viewnotes(),
        builder:(BuildContext context,AsyncSnapshot snapshot){
        
          if(snapshot.hasData){
          if(snapshot.data['status']=="fail"){
            return const Padding(
              padding:EdgeInsets.only(top:20),
              child: Center(child:Text("there is no data"),)
              );
              }
          return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:snapshot.data["data"].length,
          itemBuilder:(context, index) {
          return CardNotes(
          ontap:(){
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder:((context){
            
            return Editnote(notes:snapshot.data['data'][index]);
          })),
          (route) =>true
          );
          },
          onDelete:()async{
          deletenote(snapshot,index);
          
          },
          mapofdata:snapshot.data['data'][index]
          
          );
          }
          );}

          if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child:Text("loading........"),);
          }
          return const Center(child:Text("loading........"),);
        }),
      
      ],

    ),
    );
  }
}