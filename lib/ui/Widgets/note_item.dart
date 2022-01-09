import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:visual_notes/business%20_logic/add_visual_cubit.dart';
import 'package:visual_notes/constants/navigator.dart';
import 'package:visual_notes/data/model/noteModel.dart';
import 'package:visual_notes/ui/Screens/details_Screen.dart';

Widget noteItem(
  NoteModel model,
  context,
  index,



) {
  return Slidable(
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      // dismissible: DismissiblePane(onDismissed: () {}),
      children: [
        SlidableAction(
          onPressed: (context) {
          AddVisualCubit.get(context).deleteNote(index);
          },
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
    child: InkWell(
      onTap: () {
        navigatTo(context, DetailsScreen(itemIndex: index));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    "${model.Image_url}",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 220,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Text(
                        "${model.title}",
                        style:
                            const TextStyle(fontSize: 26, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    ),
  );
}
