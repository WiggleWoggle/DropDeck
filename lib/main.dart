import 'package:clothing_app/pages/AccountPage.dart';
import 'package:clothing_app/pages/HomePage.dart';
import 'package:clothing_app/pages/NotificationsPage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

void main() {
  runApp(
      DevicePreview(
        builder: (context) =>
            MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: BottomTabSwitcher(),
      ),
      routes: {
        '/homepage': (context) => HomePage(),
        '/notificationspage': (context) => NotificationsPage(),
        '/accountpage': (context) => AccountPage(),
      },
    );
  }
}

class BottomTabSwitcher extends StatefulWidget {
  BottomTabSwitcher({Key? key}) : super(key : key);

  @override
  State<BottomTabSwitcher> createState() => _BottomTabSwitcherState();
}

class _BottomTabSwitcherState extends State<BottomTabSwitcher> {

  int _currentIndex = 0;

  final pages = [
    HomePage(),
    NotificationsPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: KeyedSubtree(
              key: ValueKey<int>(_currentIndex),
              child: pages[_currentIndex],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 280,
              height: 70,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.75),
                borderRadius: BorderRadius.all(Radius.circular(60)),
                border: Border.all(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  width: 2.0,
                ),
              ),
              child: Stack(
                children: [
                  //black rounded rectnagular icon background
                  AnimatedAlign(
                    alignment: getIconBackgroundAlignment(_currentIndex),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCirc,
                    child: Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),

                  //padding for icon row
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    //icons
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildNavIcon(index: 0, activePath: 'assets/icons/homeActive.png', inactivePath: 'assets/icons/homeInactive.png', size: 28),
                        buildNavIcon(index: 1, activePath: 'assets/icons/notificationActive.png', inactivePath: 'assets/icons/notificationInactive.png', size: 31),
                        buildNavIcon(index: 2, activePath: 'assets/icons/profileActive.png', inactivePath: 'assets/icons/profileInactive.png', size: 28),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNavIcon({required int index, required String activePath, required String inactivePath, required double size,}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 250),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,

        //scale to swap anim
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        ),
        //TODO: try a little shake animation when selecting new tab?
        //swapping image asset
        child: Image.asset(_currentIndex == index ? activePath : inactivePath, key: ValueKey<bool>(_currentIndex == index), width: size, height: size,),
      ),
    );
  }

  Alignment getIconBackgroundAlignment(int index) {
    switch (index) {
      case 0:
        return Alignment(-0.9, 0);
      case 1:
        return Alignment(0.0, 0);
      case 2:
        return Alignment(0.9, 0);
      default:
        return Alignment.center;
    }
  }
}
