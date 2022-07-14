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
        title:  Text(
          AppLocalizations.of(context)!.myhome
          ,style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 183, 173, 58),
                              blurRadius: 3,
                            ),
                            Shadow(
                             color: Color.fromARGB(255, 183, 173, 58),
                              blurRadius: 6,
                            ),
                            Shadow(
                            color:  Color.fromARGB(255, 183, 173, 58),
                              blurRadius: 9,
                            ),
                          ]
                          ),
          ),
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
                 boxShadow: [
                            // isPressed?
                            BoxShadow(
                              color: Color.fromARGB(255, 152, 92, 174).withAlpha(255),
                               blurRadius: 15,
                               spreadRadius: 1,
                               offset: Offset(0,0)                               
                               )
                              //  :
                              //  BoxShadow()
                          ],
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 37, 219, 152),
                            Color.fromARGB(255, 107, 208, 45),
                            
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft
                          
                          )
                // image: DecorationImage(
                //   image:
                //       AssetImage("images/2855009bf094635e8cb1d32c65b7c99b.png"),
                //   fit: BoxFit.cover,
                // ),
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
                      color: Colors.white
                      , shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 26, 86, 57),
                              blurRadius: 5,
                            ),
                            Shadow(
                              color: Color.fromARGB(255, 26, 86, 57),
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Color.fromARGB(255, 26, 86, 57),
                              blurRadius: 9,
                            ),
                          ]
                      ),
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
                  color: Color.fromARGB(171, 28, 44, 67),
                   boxShadow: [
                            // isPressed?
                            BoxShadow(
                              color: Color.fromARGB(255, 152, 92, 174).withAlpha(255),
                               blurRadius: 10,
                               spreadRadius: 1,
                               offset: Offset(0,0)                               
                               )
                              //  :
                              //  BoxShadow()
                          ],
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 23, 0, 201),
                            Color.fromARGB(255, 163, 30, 150),
                            
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft
                          
                          )
                  // image: DecorationImage(
                  //   image: AssetImage(
                  //       "images/2855009bf094635e8cb1d32c65b7c99b.png"),
                  //   fit: BoxFit.cover,
                  // ),
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
