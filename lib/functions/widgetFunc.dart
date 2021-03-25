import 'package:flutter/material.dart';

Text appbarTitle(String title) {
  return Text("$title", style: TextStyle(color: Colors.white));
}

SizedBox buildSizedBoxHeight(int value) {
  return SizedBox(
    height: value.toDouble(),
  );
}

SizedBox buildSizedBoxWidth(int value) {
  return SizedBox(
    width: value.toDouble(),
  );
}

SizedBox buildSizedBoxMedia(double height, double value) {
  return SizedBox(
    height: height * value,
  );
}

SizedBox buildSizedBoxWidthMedia(double width, double value) {
  return SizedBox(
    width: width * value,
  );
}

AppBar buildAppBar(String title) {
  return AppBar(
    title: Text("$title"),
    centerTitle: true,
  );
}

double buildWidth(BuildContext context) => MediaQuery.of(context).size.width;

double buildHeight(BuildContext context) => MediaQuery.of(context).size.height;

void showSnack(
    BuildContext context, stringList, GlobalKey<ScaffoldState> _scaffoldkey) {
  // final states = Provider.of<AppStates>(context);
  _scaffoldkey.currentState.showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(width: 1, color: Colors.black)),
    content: Text(
      stringList,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.black,
  ));
}
