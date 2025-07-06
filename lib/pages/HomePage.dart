import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //nbackground gradient top to search
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

          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: TopBanner(),
          ),

          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 350,
                height: 50,
                child: SearchBar(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),

                  //TODO: search inquiries HERE, mayube implement onsubmit too idk
                  onChanged: null,

                  leading: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Image.asset(
                      'assets/icons/search.png',
                      height: 20,
                    ),
                  ),

                  side: WidgetStateProperty.all(
                    BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 1),
                      width: 2.0,
                    ),
                  ),

                  hintText: 'Search',
                  hintStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: Color.fromRGBO(115, 115, 115, 1),
                      fontSize: 18.0,
                      fontFamily: 'Glacial',),
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: Color.fromRGBO(115, 115, 115, 1),
                      fontSize: 18.0,
                      fontFamily: 'Glacial',),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopBanner extends StatelessWidget {

  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 220,
        child: Image.asset('assets/icons/topBanner.png'),
      ),
    );
  }
}