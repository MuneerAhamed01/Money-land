import 'package:flutter/material.dart';

mediaQuery(BuildContext context, double heightSize) {
  var height = MediaQuery.of(context).size.height * heightSize;
  return height;
}

mediaQueryWidth(BuildContext context, double widthSize) {
  var width = MediaQuery.of(context).size.width * widthSize;

  return width;
}

class MediaQueryCostom {
  MediaQueryPadding(BuildContext context, double widthSize) {
    var width = MediaQuery.of(context).padding.bottom / widthSize;

    return width;
  }
}
