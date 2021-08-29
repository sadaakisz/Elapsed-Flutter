import 'package:elapsed_flutter/utils/custom_page_route.dart';
import 'package:flutter/material.dart';

void navPush(BuildContext context, Widget child) {
  Navigator.of(context).push(CustomPageRoute(child));
}

void navPushReplace(BuildContext context, Widget child) {
  Navigator.of(context).pushReplacement(CustomPageRoute(child));
}
