import 'package:flutter/material.dart';

class AlertToast {
  final Scaffold? scaffold;
  final BuildContext context;
  final int? duration;
  const AlertToast(
      {Key? key, this.scaffold, required this.context, this.duration});

  showSuccess(text) {
    final snackBar = SnackBar(
      duration: Duration(seconds: duration ?? 5),
      content: Text(
        text,
        // style: TextStyle(color: appTheme.black900),
      ),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      // width: SizeUtils.width - 40,
      // backgroundColor: appTheme.blue50
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // scaffold.currentState.showSnackBar(snackbar);
  }

  showMsg(text) {
    final snackBar = SnackBar(
      duration: Duration(seconds: duration ?? 5),
      content: Text(
        text,
        // style: TextStyle(color: TrybeColors().c.whiteConstant),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // scaffold.currentState.showSnackBar(snackBar);
  }

  showError(text) {
    final snackBar = SnackBar(
      duration: Duration(seconds: duration ?? 5),
      content: Text(
        text,
        //  style: TextStyle(color: theme.colorScheme.onPrimary),
      ),
      // backgroundColor: appTheme.indigoA20001
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
