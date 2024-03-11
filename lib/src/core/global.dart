import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
BuildContext get mainContext {
  if (navigatorKey.currentContext == null) {
    throw ErrorDescription("Navigator key is unused");
  }
  return navigatorKey.currentContext!;
}
