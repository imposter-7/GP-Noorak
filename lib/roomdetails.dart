// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lastversion/addlight.dart';
import 'package:lastversion/automationDetails.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:lastversion/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';

class RoomDetail extends StatefulWidget {
  final String roomID;

  const RoomDetail({Key? key, required this.roomID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoomDetail();
}

class _RoomDetail extends State<RoomDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.myhome),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton<Locale>(
              underline: SizedBox(),
              icon: Icon(
                Icons.language_rounded,
                color: Colors.white,
              ),
              items: List.generate(
                  L10n.all.length,
                  (index) => DropdownMenuItem<Locale>(
                        value: L10n.all[index],
                        child: Text(L10n.all[index].languageCode),
                      )),
              onChanged: (value) {
                final provider =
                    Provider.of<LocalProvider>(context, listen: false);
                provider.setLocale(value);
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 127, left: 70),
            child: Container(
              width: 280,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(171, 236, 117, 147),
                image: DecorationImage(
                  image:
                      AssetImage("images/2855009bf094635e8cb1d32c65b7c99b.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 170, horizontal: 108),
                child: Text(
                  AppLocalizations.of(context)!.manual,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddLight(roomID: widget.roomID)),
                );
              }),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AutoDetails(roomID: widget.roomID)),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(top: 280, left: 70),
              child: Container(
                width: 280,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(171, 32, 88, 170),
                  image: DecorationImage(
                    image: AssetImage(
                        "images/2855009bf094635e8cb1d32c65b7c99b.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 330, left: 95),
            child: Text(
              AppLocalizations.of(context)!.autodetails,
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
