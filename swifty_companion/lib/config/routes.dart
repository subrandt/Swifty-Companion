import 'package:flutter/material.dart';
import 'package:swifty_companion/pages/search_page.dart';
import 'package:swifty_companion/pages/profile_page.dart';

class Routes {
  static const String search = '/';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      search: (context) => const SearchPage(),
      profile: (context) => const ProfilePage(),
    };
  }
}