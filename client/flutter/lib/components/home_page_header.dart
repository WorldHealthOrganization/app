import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

class HomePageHeader extends StatelessWidget {
  final HeaderType headerType;

  HomePageHeader(this.headerType);

  String title(BuildContext context) {
    switch (this.headerType) {
      case HeaderType.CheckYourSymptoms:
        return "Check your symptoms";
      case HeaderType.ProtectYourself:
        return "Protect Yourself";
      default:
        return "Check your symptoms";
    }
  }

  String buttonText(BuildContext context) {
    switch (this.headerType) {
      case HeaderType.CheckYourSymptoms:
        return "Check now";
      case HeaderType.ProtectYourself:
        return "Learn more";
      default:
        return "Check now";
    }
  }

  String get svgAssetName {
    switch (this.headerType) {
      // case HeaderType.CheckYourSymptoms:
      //   return "assets/svg/home_page_header/check_your_symptoms.svg";
      // case HeaderType.ProtectYourself:
      //   return "assets/svg/home_page_header/protect_yourself.svg";
      default:
        return null;
    }
  }

  Color get backgroundColor {
    switch (this.headerType) {
      case HeaderType.CheckYourSymptoms:
        return Constants.primaryDarkColor;
      case HeaderType.ProtectYourself:
        return Color(0xff4ACA8C);
      default:
        return Constants.primaryDarkColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ClipPath(
        clipper: HeaderClipper(),
        child: Container(
          padding: EdgeInsets.all(24),
          color: this.backgroundColor,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: CupertinoColors.white,
                        width: 48,
                        margin: EdgeInsets.only(right: 8),
                      ),
                      Flexible(
                        child: AutoSizeText(
                          S.of(context).commonWorldHealthOrganization,
                          maxLines: 2,
                          maxFontSize: 18,
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        color: Color.fromARGB(127, 250, 232, 169),
                        width: 1,
                      ),
                      Text(
                        "COVID-19 Response",
                        style: TextStyle(
                          color: Color(0xffFAE8A9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                ThemedText(
                  this.title(context),
                  variant: TypographyVariant.title,
                  style: TextStyle(
                    color: CupertinoColors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                ThemedText(
                  "See what your symptoms could mean and what you can do to move forward.",
                  variant: TypographyVariant.body,
                  style: TextStyle(
                    color: CupertinoColors.white,
                  ),
                ),
                Container(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    this.svgAssetName != null
                        ? SvgPicture.asset(this.svgAssetName)
                        : Container(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(50),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 8,
                        ),
                        color: CupertinoColors.white,
                        child: ThemedText(
                          this.buttonText(context),
                          variant: TypographyVariant.button,
                          style: TextStyle(color: Constants.primaryColor),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                if (this.svgAssetName == null)
                  Container(
                    height: 40,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height - 20),
        radius: Radius.elliptical(size.width, 240));
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> path) {
    return true;
  }
}

enum HeaderType {
  CheckYourSymptoms,
  ProtectYourself,
}
