import 'package:flutter/material.dart';

enum DialogType { success, error, confirm }

class DialogUtils {
  static void showCustomDialog(
    BuildContext context, {
    @required String title,
    @required String content,
    @required Function onOkPressed,
    DialogType dialogType,
    bool barrierDismissible = true,
    String okBtnText = "Ok",
    String cancelBtnText = "Cancel",
    Function onCancelPressed,
  }) {
    Widget icon;
    if (dialogType == null)
      icon = SizedBox();
    else {
      switch (dialogType) {
        case DialogType.success:
          icon = Icon(
            Icons.check_box_rounded,
            size: 36,
            color: Colors.green,
          );
          break;
        case DialogType.error:
          icon = Icon(
            Icons.error_outline,
            size: 36,
            color: Colors.red,
          );
          break;
        default:
          icon = SizedBox();
      }
    }
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => AlertDialog(
              title: Row(
                children: [
                  icon,
                  SizedBox(
                    width: dialogType == null ? 0 : 5,
                  ),
                  Text('$title')
                ],
              ),
              content: content != null
                  ? Text(
                      '$content',
                    )
                  : SizedBox(),
              actions: [
                onCancelPressed == null
                    ? SizedBox()
                    : TextButton(
                        child: Text('$cancelBtnText'),
                        onPressed: onCancelPressed,
                      ),
                TextButton(
                  child: Text('$okBtnText'),
                  onPressed: onOkPressed,
                ),
              ],
            ));
  }
}
