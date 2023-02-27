import 'package:flutter/material.dart';
class Customtextfrom extends StatelessWidget {
  
  
const Customtextfrom({ Key? key ,required this.textediting,required this.hint, required this.valida,required this.onsave }) : super(key: key);
  final String hint;
  final TextEditingController textediting;
  final String? Function(String?) valida;
  final Function(String?) onsave;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(bottom:20),
      child: TextFormField(
        onSaved:onsave,
        validator:valida,
        controller:textediting,
        decoration:InputDecoration(
        hintText:hint,
        contentPadding: const EdgeInsets.symmetric(vertical:10,horizontal:20),
        border: OutlineInputBorder(
        borderSide:const BorderSide(width:2),
        borderRadius: BorderRadius.circular(30)
      )
      )
      ),
      );
  }
}