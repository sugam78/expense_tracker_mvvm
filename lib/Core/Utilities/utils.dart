import 'package:expense_tracker_mvvm/Core/Theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilities{
  static void fieldFocusChange(BuildContext context, FocusNode current,FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  void toastMesssage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppPallete.gradient1,
        textColor: AppPallete.whiteColor,
        fontSize: 16.0
    );
  }
}