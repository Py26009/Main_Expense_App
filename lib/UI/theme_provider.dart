import 'package:flutter/cupertino.dart';

class themeProvider extends ChangeNotifier{

    bool _isDarkTheme = false;

    bool getThemeValue()=> _isDarkTheme;

    void setThemeValue(bool value){
      _isDarkTheme = value;
      notifyListeners();
    }

}