import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clothing_app/pages/HomePage.dart';

class NotificationsPage extends StatefulWidget {

  NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPage();
}

class _NotificationsPage extends State<NotificationsPage> {

  final bool notifications = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(228, 227, 212, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                TopBanner(),
                //TODO: add profile check later
                //CASE FOR WHEN THERES NO NOTIFICATIONS
                !notifications
                    ? Column(
                  children: [
                    SizedBox(height: 300),
                    Text(
                      'You have no notifications.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'Glacial',
                      ),
                    ),
                  ],
                )
                //CASE FOR WHEN THERES NOTIFICATIONS
                    : Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(right: 280),
                      child: Text(
                        'This Week',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'Glacial',
                        ),
                      ),
                    ),
                    DynamicNotificationStack()
                  ],
                )
              ]
            ),
          ),
        ]
      ),
    );
  }
}

class DynamicNotificationStack extends StatelessWidget {

  const DynamicNotificationStack({super.key});

  @override
  Widget build(BuildContext context) {

    int count = 3;

    return Column(
      children: [
        NotificationBox(
          dropTitle: 'Air Jordan 1 High OG',
          dropDate: DateTime(2025, 7, 25),
          productImage: 'assets/images/products/listing1.png',
        ),

        NotificationBox(
          dropTitle: 'Air Jordan 4 Rare Air',
          dropDate: DateTime(2025, 7, 10),
          productImage: 'assets/images/products/listing2.png',
        ),

        NotificationBox(
          dropTitle: 'Air Jordan 8 Aqua',
          dropDate: DateTime(2025, 7, 10),
          productImage: 'assets/images/products/listing3.png',
        ),
      ],
    );
  }
}

class NotificationBox extends StatelessWidget {

  const NotificationBox({
    super.key,
    required this.dropTitle,
    required this.dropDate,
    required this.productImage
  });

  final String dropTitle;
  final DateTime dropDate;

  final String productImage;

  @override
  Widget build(BuildContext context) {

    String dropYear = dropDate.year.toString();
    String dropMonth = dropDate.month.toString();
    String dropDay = dropDate.day.toString();

    DateTime currentDay = DateTime.now();

    bool isPast = dropDate.isBefore(currentDay);
    String label = isPast ? "Dropped" : "Dropping";
    Color labelColor = isPast ? Colors.red : Color.fromRGBO(0, 138, 71, 1);

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: 370,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Color.fromRGBO(217, 217, 217, 1),
              width: 2.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                width: 70,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    this.productImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.dropTitle,
                        style: TextStyle(
                          fontFamily: 'Glacial',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/clock.png',
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7, bottom: 1),
                            child: Text(
                              label + " " + dropMonth + "/" + dropDay + "/" + dropYear,
                              style: TextStyle(
                                fontFamily: 'Glacial',
                                fontSize: 16,
                                color: labelColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}