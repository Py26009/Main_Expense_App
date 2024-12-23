

     import 'package:flutter/material.dart';

InputDecoration mfieldDecor({required String hint, required String heading, IconData ? mIcon}){
   return InputDecoration(
     hintText: hint,
        label: Text(heading),
        prefixIcon: mIcon != null ? Icon(mIcon): null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(width: 1)
        ),
       focusedBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(24),
         borderSide: BorderSide(width: 1),
       )
     );
     }