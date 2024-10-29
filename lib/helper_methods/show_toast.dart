import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String msg, required Color backgroundColor}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 5,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor,
  );
}
