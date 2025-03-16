
import 'package:expense_app/UI/theme_provider.dart';
import 'package:expense_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child:
       SwitchListTile.adaptive(
         title: Text("Dark Mode"),
           controlAffinity: ListTileControlAffinity.leading,
           value: context.watch<themeProvider>().getThemeValue(),
           onChanged: (value){
             context.read<themeProvider>().setThemeValue(value);
           })
      ),
    );
  }
}