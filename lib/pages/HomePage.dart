import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;

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

          //scrollable homepage stuff
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                TopBanner(),
                SizedBox(
                  height: 20,
                ),
                Center(
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
                Padding(
                    padding: EdgeInsets.only(
                      top: 25,
                      bottom: 7,
                      left: 25,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Upcoming Drops',
                            style: TextStyle(
                              fontFamily: 'Glacial',
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 180,
                            ),
                            child: TextButton(

                              //TODO: expand into new page
                              onPressed: () {

                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                overlayColor: Colors.transparent,
                              ),
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  fontFamily: 'Glacial',
                                  color: Color.fromRGBO(115, 115, 115, 1),
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                WideSpreadDynamicBanner(
                  bannerItemCount: 3,
                ),
              ],
            ),
          )
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
        height: 60,
        width: 220,
        child: Image.asset('assets/icons/topBanner.png'),
      ),
    );
  }
}

class WideSpreadDynamicBanner extends StatefulWidget {

  final int bannerItemCount;

  const WideSpreadDynamicBanner({Key? key, required this.bannerItemCount}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WideSpreadDynamicBannerState();
}

class _WideSpreadDynamicBannerState extends State<WideSpreadDynamicBanner> {

  int _currentIndex = 0;
  final CarouselSliderController _swipeableCarousel = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          CarouselSlider.builder(
            itemCount: widget.bannerItemCount,
            carouselController: _swipeableCarousel,
            options: CarouselOptions(
              height: 170,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            //image handler
            //TODO: move the images to a list and do the dynamic size somewhere else
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/banners/banner${index + 1}.png',
                  fit: BoxFit.fill,
                  width: 380,
                ),
              );
            },
          ),

          SizedBox(height: 10),
          //dynamic banner count indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.bannerItemCount, (index) {
              bool activeIndicator = index == _currentIndex;
              return AnimatedContainer(
                duration: Duration(
                    milliseconds: 250
                ),
                margin: EdgeInsets.symmetric(horizontal: 6),
                width: getIndicatorWidth(index, _currentIndex),
                height: 4,
                decoration: BoxDecoration(
                  //change color based on selected or not
                  color: activeIndicator ? Colors.black : Color.fromRGBO(166, 166, 166, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  double getIndicatorWidth(int index, int currentPage) {

    if (index == currentPage) {
      return 40;
    }
    return 20;
  }
}