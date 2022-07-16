

import 'package:flutter/material.dart';
import 'package:lastversion/signinemail.dart';
import '../bottomnavbar.dart';
import '../main.dart';

class NavigationService
{
  final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName)
  {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> removeandNavigateTo(String routeName)
  {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}


Route<dynamic> generateRoute(RouteSettings settings)
{
  switch(settings.name)
  {
    case '/':
      if(apiServices.isLoggedin())
        return getPageRoute(MyBottomNavigationBar());
      else
        return getPageRoute(Signinmail());
    default:
      return getPageRoute(Text("Page Not found!"));
  }
}


PageRoute getPageRoute(Widget child)
{
  return MaterialPageRoute(builder: (context) => child);
}