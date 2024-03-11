import 'package:flutter/material.dart';

extension ContextExtensionon on BuildContext {
  NavigatorState get navigator {
    return Navigator.of(this);
  }

  Future<void> pushReplacement(Widget widget) async {
    final route = MaterialPageRoute(builder: (context) => widget);
    await navigator.pushReplacement(route);
  }

  Future<void> push(Widget widget) async {
    final route = MaterialPageRoute(builder: (context) => widget);
    await navigator.push(route);
  }

  void pop() {
    navigator.pop();
  }

  void unFocus() {
    FocusScope.of(this).unfocus();
  }

  ThemeData get theme {
    return Theme.of(this);
  }

  MediaQueryData get mediaQuery {
    return MediaQuery.of(this);
  }

  ScaffoldState get scaffold {
    return Scaffold.of(this);
  }
}
