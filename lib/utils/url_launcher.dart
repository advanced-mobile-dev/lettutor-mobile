import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUrlLauncher {
  static Future<void> launchHttpsUrl(context, String command) async {
    command = command.replaceAll(' ', '%20');
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Could not launch the pdf file')),
        );
    }
  }
}
