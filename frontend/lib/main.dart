import 'package:flutter/material.dart';
import 'package:addnote/View/screens/Auth/loginin.dart';
import 'package:addnote/View/screens/Auth/loginup.dart';
import 'package:addnote/View/screens/home.dart';
import 'package:addnote/View/screens/notes/addnote.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpre;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpre=await SharedPreferences.getInstance();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
    // theme:sharedpre.getString("mode")=="dark"?ThemeData.dark():ThemeData.light(),
    debugShowCheckedModeBanner: false,
    title: 'Php Add Note',
    initialRoute:sharedpre.getString("id")==null ? "loginup" : "home" ,
    
    routes:{
      "addnotepage":(context) =>const Addnote() ,
      "loginin"    :(context) => const Loginin(),
      "loginup"    :(context) => const Loginup(),
      "home"       :(context) => const Homepage(),
    }
    
    );
  }
}
