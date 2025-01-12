
import 'package:boilerplate/shared/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoutDialogWidget extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialogWidget({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Logout'),
      content: Text('Are you sure, you want to logout?'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Yes', style: fontMedium.copyWith(color: Theme.of(context).primaryColor)),
          onPressed: () {
            onLogout();
          },
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No', style: fontMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withAlpha((.5 * 255).toInt()))),
        ),
      ],
    );
  }
}