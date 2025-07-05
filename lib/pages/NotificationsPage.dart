import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {

  NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPage();
}

class _NotificationsPage extends State<NotificationsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.red,
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