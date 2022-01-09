import 'package:flutter/material.dart';
import 'package:visual_notes/constants/Colors.dart';

Widget defaultButton({
  required String text,
  required VoidCallback onTap,
}) {
  return ElevatedButton(

    onPressed: onTap,
    child: Text(text),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColor.purple),
    ),
  );
}