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
                  height: 10,
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
                    child: SectionDivideSeeAll(
                      sectionTitle: 'Upcoming Drops',
                      seeAllPadding: 180,
                    )
                ),
                WideSpreadDynamicBanner(
                  bannerItemCount: 3,
                  bannerWidth: 380,
                  bannerHeight: 170,
                  showBannerIndicator: true,
                  viewportFraction: 1.0,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: 40,
                      bottom: 7,
                      left: 25,
                    ),
                    child: SectionDivideSeeAll(
                      sectionTitle: 'New Drops',
                      seeAllPadding: 230,
                    )
                ),
                //TODO: add more sample images to mess with fit
                WideSpreadDynamicBanner(
                  bannerItemCount: 3,
                  bannerWidth: 270,
                  bannerHeight: 230,
                  showBannerIndicator: false,
                  viewportFraction: 0.7,
                ),
                Container(
                    width: 230,
                    height: 50,
                    child: Column(
                      children: [
                        Text(
                          'Air Jordan \'07',
                          style: TextStyle(
                            fontFamily: 'Glacial',
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Red White Green',
                          style: TextStyle(
                            fontFamily: 'Glacial',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: 40,
                      left: 25,
                    ),
                    child: SectionDivideSeeAll(
                      sectionTitle: 'Deals',
                      seeAllPadding: 280,
                    )
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20
                  ),
                  child: DynamicImageGrid(
                      rows: 3,
                      columns: 3,
                      imagePath: 'assets/banners/banner1.png',
                      spacing: 16.0
                  ),
                )
              ],
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
        height: 60,
        width: 220,
        child: Image.asset('assets/icons/topBanner.png'),
      ),
    );
  }
}

class WideSpreadDynamicBanner extends StatefulWidget {

  final int bannerItemCount;
  final double bannerWidth;
  final double bannerHeight;
  final double viewportFraction;
  final bool showBannerIndicator;

  const WideSpreadDynamicBanner({Key? key,
    required this.bannerItemCount,
    required this.bannerWidth,
    required this.bannerHeight,
    required this.viewportFraction,
    required this.showBannerIndicator
  }) : super(key: key);

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
              height: widget.bannerHeight,
              viewportFraction: widget.viewportFraction,
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
              return Container(
                width: widget.bannerWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/banners/banner${index + 1}.png',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 10),
          //dynamic banner count indicator
          if (widget.showBannerIndicator)
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

class SectionDivideSeeAll extends StatelessWidget {

  final String sectionTitle;
  final double seeAllPadding;
  //TODO: add the onpress as a parameter(?)

  const SectionDivideSeeAll({Key? key, required this.sectionTitle, required this.seeAllPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            this.sectionTitle,
            style: TextStyle(
              fontFamily: 'Glacial',
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: this.seeAllPadding,
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
    );
  }
}

class DynamicImageGrid extends StatelessWidget {

  final int rows;
  final int columns;
  final String imagePath;
  final double spacing;

  const DynamicImageGrid({
    Key? key,
    required this.rows,
    required this.columns,
    required this.imagePath,
    required this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int itemCount = rows * columns;

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1, // Makes each item square
      ),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              width: 100,  // Or whatever square size you want
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('80% off nike'),
          ],
        );
      },
    );
  }
}