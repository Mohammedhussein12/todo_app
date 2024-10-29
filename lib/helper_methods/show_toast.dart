import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showToast(
    {required String msg, required Color backgroundColor}) async {
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 5,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor,
  );
}
