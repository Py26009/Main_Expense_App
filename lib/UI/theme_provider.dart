import 'package:flutter/cupertino.dart';

class themeProvider extends ChangeNotifier{

    bool _isTheme = false;

   bool getThemeValue()=> _isTheme;

    void setThemeValue(bool value){
      _isTheme = value;
      notifyListeners();
    }

}