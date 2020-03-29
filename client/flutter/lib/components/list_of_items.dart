import 'package:WHOFlutter/components/back_arrow.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ListOfItems extends StatelessWidget {
  final String title;

  final List<Widget> listOfItems;

  ListOfItems(this.listOfItems, {this.title = 'Provide Title'});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                leading: SizedBox(),
                flexibleSpace: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          bottom: 20,
                          top: 20,
                        ),
                        child: BackArrow(),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: const Color(0xFF3D8BCC),
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            S
                                .of(context)
                                .commonWorldHealthOrganizationCoronavirusApp,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF050C1D),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                expandedHeight: 200,
              ),
              SliverList(
                delegate: SliverChildListDelegate(this.listOfItems),
              ),

              /// Pad by the Positioned container at the bottom so we can scroll
              /// past it. Plus some padding.
              SliverToBoxAdapter(
                child: SizedBox(height: 70),
              )
            ],
          ),
          Positioned(
              bottom: 0.0,
              child: Center(
                  child: Container(
                color: Color(0xF8ffffff),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: IconButton(
                          onPressed: () => Share.share(S.of(context).commonWhoAppShareIconButtonDescription),
                          icon: Icon(
                            Icons.share,
                            size: 22,
                          )),
                    )),
              ))),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Widget titleWidget;
  final String message;

  ListItem({this.titleWidget, this.message = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          this.titleWidget ?? Divider(),
          Text(
            this.message,
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class EmojiHeader extends StatelessWidget {
  EmojiHeader(this.emoji);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        this.emoji,
        textScaleFactor: 6,
      ),
    );
  }
}
