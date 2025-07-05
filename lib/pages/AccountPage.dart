import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {

  AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _NotificationsPage();
}

class _NotificationsPage extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.yellow,
        body: Container(
          color: Colors.red,
          width: 20,
          height: 20,
          child: Align(
            alignment: Alignment.center,
          ),
        )
    );
  }
}