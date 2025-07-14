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
                SizedBox(height: 60),
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
                          BannerBox(
                            brand: 'Nike',
                            dropTitle: 'Air Jordan 3 White and Silver',
                            dropDate: DateTime(2025, 8, 1),
                            productImage: 'assets/images/products/listing4.png',
                          ),
                          DynamicNotificationStack(
                            recency: 'Today',
                            canCollapse: true,
                          ),
                          DynamicNotificationStack(
                            recency: 'This Week',
                            canCollapse: true,
                          ),
                        ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DynamicNotificationStack extends StatelessWidget {
  const DynamicNotificationStack({
    super.key,
    required this.recency,
    required this.canCollapse,
  });

  final String recency;
  final bool canCollapse;

  @override
  Widget build(BuildContext context) {
    int count = 3;

    return Column(
      children: [
        NotificationStack(
          recency: this.recency,
          canCollapse: this.canCollapse,
          notifications: [
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
        ),
      ],
    );
  }
}

class NotificationStack extends StatefulWidget {

  final List<NotificationBox> notifications;
  final String recency;
  final bool canCollapse;

  const NotificationStack({
    super.key,
    required this.notifications,
    required this.recency,
    required this.canCollapse,
  });

  @override
  State<NotificationStack> createState() => _NotificationStackState();
}

class _NotificationStackState extends State<NotificationStack> with SingleTickerProviderStateMixin {

  bool isExpandedState = true;
  late AnimationController controller;

  final Duration duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: duration
    );
  }

  void toggleExpanded() {
    setState(() {
      isExpandedState = !isExpandedState;
      isExpandedState ? controller.forward() : controller.reverse();
    });
  }

  @override void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Widget> _buildAnimatedStack() {
    final int count = widget.notifications.length;

    widget.notifications.sort((a, b) => b.dropDate.compareTo(a.dropDate));

    return List.generate(count, (i) {
      final index = count - i - 1;

      final bool isTopItem = index == 0;

      final double collapsedOffset = 10.0 * i - 10;
      final double expandedOffset = 110.0 * index - 10;

      return AnimatedPositioned(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        top: isExpandedState ? expandedOffset : 0,
        left: 0,
        right: 0,
        child: Transform.translate(
          offset: Offset(0, isExpandedState ? 0 : -collapsedOffset),
          child: IgnorePointer(
            ignoring: !isExpandedState && !isTopItem,
            child: GestureDetector(
              onTap: () {
                //TODO: expannd into new tab
              },
              child: widget.notifications[index],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final totalHeight = isExpandedState
        ? widget.notifications.length * 110.0
        : 110.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                this.widget.recency,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: 'Glacial',
                ),
              ),

              if (widget.canCollapse)
              GestureDetector(
                onTap: toggleExpanded,
                child: AnimatedRotation(
                  turns: isExpandedState ? 0.5 : 0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
            left: 30,
          ),
          child: AnimatedContainer(
            duration: duration,
            height: totalHeight,
            width: 370,
            child: Stack(
              clipBehavior: Clip.none,
              children: _buildAnimatedStack(),
            ),
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }
}

class NotificationBox extends StatelessWidget {
  const NotificationBox({
    super.key,
    required this.dropTitle,
    required this.dropDate,
    required this.productImage,
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
            color: Color.fromRGBO(255, 255, 255, 1),
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
                  child: Image.asset(this.productImage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 15),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 25),
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
                          Image.asset('assets/icons/clock.png', height: 15),
                          Padding(
                            padding: EdgeInsets.only(left: 7, bottom: 1),
                            child: Text(
                              "$label $dropMonth/$dropDay/$dropYear",
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

class BannerBox extends StatelessWidget {
  const BannerBox({
    super.key,
    required this.brand,
    required this.dropTitle,
    required this.dropDate,
    required this.productImage,
  });

  final String brand;
  final String dropTitle;
  final DateTime dropDate;

  final String productImage;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: 370,
          height: 150,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.75),
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
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(this.productImage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 15),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 27),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.brand,
                        style: TextStyle(
                          fontFamily: 'Glacial',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
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
                          Image.asset('assets/icons/clock.png', height: 15),
                          Padding(
                            padding: EdgeInsets.only(left: 7, bottom: 1),
                            child: Text(
                              "Live now!",
                              style: TextStyle(
                                fontFamily: 'Glacial',
                                fontSize: 16,
                                color: Color.fromRGBO(0, 138, 71, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  bottom: 100,
                  right: 10,
                ),
                child: Image.asset('assets/icons/exclamation.png', height: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
