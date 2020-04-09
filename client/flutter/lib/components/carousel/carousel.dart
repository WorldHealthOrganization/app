import 'package:WHOFlutter/components/carousel/carousel_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class CarouselView extends StatelessWidget {
  final List<CarouselSlide> items;

  CarouselView({@required this.items});

  final pageIndexNotifier = ValueNotifier<int>(0);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
                begin: Alignment(0.0, 0.0),
                end: Alignment(0.0, 1.0),
                colors: <Color>[Colors.white, Colors.white, Colors.transparent],
                stops: [0.0, 0.5, 0.6]).createShader(bounds);
          },
          child: PageView(
            controller: pageController,
            onPageChanged: (i) => pageIndexNotifier.value = i,
            children: this.items,
          ),
        ),
        Positioned(
          bottom: 30,
          right: 20,
          child: SafeArea(
                      child: FlatButton(
              child: Text("Next fact", style: TextStyle(color: Color(0xff008DC9), fontSize: 18, fontWeight: FontWeight.w600)),
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical:14, horizontal:29),
              shape: StadiumBorder(),
              onPressed: ()=>(this.pageController.hasClients ?this.pageController.page:0) < this.items.length-1?pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut):pageController.animateToPage(0,duration: Duration(milliseconds: 500), curve: Curves.easeInOut),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: SafeArea(
            child: Container(
                padding: EdgeInsets.only(bottom: 8),
                child: _buildPageViewIndicator(context)),
          ),
        ),
      ],
    );
  }

  Widget _buildPageViewIndicator(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: width * 0.5),
          child: FittedBox(
            child: PageViewIndicator(
              pageIndexNotifier: pageIndexNotifier,
              length: this.items.length,
              normalBuilder: (animationController, index) => Circle(
                size: 20.0,
                color: Color(0x99FFFFFF),
              ),
              highlightedBuilder: (animationController, index) =>
                  ScaleTransition(
                scale: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.ease,
                ),
                child: Circle(
                  size: 28.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
