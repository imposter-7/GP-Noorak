// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lastversion/Firsthome.dart';

import 'Home.dart';
import 'Smart.dart';
import 'profile.dart';
import 'package:lastversion/provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBar createState() => _MyBottomNavigationBar();
}

class _MyBottomNavigationBar extends State<MyBottomNavigationBar> {
  int _index = 0;
  List<Widget> _widgetOptions = <Widget>[
    
    HomePage(),
    SmartPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_index],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: (newIndex) => setState(() => _index = newIndex),
          currentIndex: _index,
          items: [
            
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: (AppLocalizations.of(context)!.myhome),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.light,
                  color: Colors.white,
                ),
                label: (AppLocalizations.of(context)!.smart)),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.image_aspect_ratio,
                  color: Colors.white,
                ),
                label: (AppLocalizations.of(context)!.profile)),
          ]),
    );
  }
}