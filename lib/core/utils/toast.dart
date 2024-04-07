import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

flutterShowSnackbar({required BuildContext context, required String content}) {
  // return ScaffoldMessenger.of(context)
  //   ..hideCurrentSnackBar()
  //   ..showSnackBar(
  //     SnackBar(
  //       content: Text(content),
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  return Fluttertoast.showToast(
    msg: content,
    gravity: ToastGravity.SNACKBAR,
  );
}
