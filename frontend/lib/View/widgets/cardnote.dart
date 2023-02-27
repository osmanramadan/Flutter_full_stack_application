
import 'package:flutter/material.dart';
import 'package:addnote/Model/notemodel.dart';
import 'package:addnote/constants/links.dart';

// ignore: must_be_immutable
class CardNotes extends StatefulWidget {
  
  final void Function() ontap;
  // ignore: prefer_typing_uninitialized_variables
  var mapofdata;
  final void Function()? onDelete;
   CardNotes(
      {Key? key,
      required this.ontap,
      
      required this.onDelete,
      required this.mapofdata
      
      })
: super(key: key);

  @override
  State<CardNotes> createState() => _CardNotesState();
}

class _CardNotesState extends State<CardNotes> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                "$linkImageRoot/${
                  NoteModel.fromJson(widget.mapofdata).notesImage
                }",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )
                ),
            Expanded(
                flex: 2,
                child: ListTile(
                  title:    Text("${NoteModel.fromJson(widget.mapofdata).notesTitle}"),
                  subtitle: Text("${NoteModel.fromJson(widget.mapofdata).notesContent}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
