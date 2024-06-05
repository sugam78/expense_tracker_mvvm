import 'package:flutter/cupertino.dart';

class Utilities{
  static void fieldFocusChange(BuildContext context, FocusNode current,FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }
}