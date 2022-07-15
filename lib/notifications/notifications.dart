// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:lastversion/notifications/notification_api.dart';

// class notifications extends StatefulWidget {
//   const notifications({Key? key}) : super(key: key);

//   @override
//   State<notifications> createState() => _notificationsState();
// }

// class _notificationsState extends State<notifications> {
//   @override
//    Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Kindacode.com'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(25),
//           child: Column(children: [
//             ElevatedButton(
//               onPressed: () {
//                 print("hahah");
//                 NotificationApi.showNotification(
//                   title: 'Hala HF',
//                   body: ' Hey! Do we have everything okay?',
//                   payload: 'Hala HF',
//                 );

//               }, 
//             child: const Text('Simple Notifications')
//             ),

//             ElevatedButton(
//               onPressed: () {},
//                child: const Text('Scheduled Notifications')
               
//             ),


//             ElevatedButton(
//               onPressed: () {},
//                child: const Text('Remove Notifications ')
               
//             ),
//             // ElevatedButton.icon(
//             //   onPressed: () {},
//             //   label: const Text('Plus One'),
//             //   icon: const Icon(Icons.plus_one),
//             // )
//           ]),
//         ));
//   }
// }

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lastversion/main.dart';
import 'package:lastversion/notifications/notification_api.dart';
// import 'package:localnotificationflutter/notificationservice.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }

  Future<int> getTime() async{
  final DatabaseReference  db = FirebaseDatabase.instance.ref("2bp6lKoRrbN9C3Vva9OMIwllgXv2").child("rooms").child('room1');
      final DatabaseEvent event = await db.once();
    final Map data = event.snapshot.value as Map;
    return data['scheduled-notifications'];
  }

  @override
  Widget build(BuildContext context) {
  
  

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                NotificationService().cancelAllNotifications();
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Cancel All Notifications",
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async{
                
                  int seconds = await getTime() ;
                print(seconds);
                print("hahaha");
                NotificationService().showNotification(1, "NOORAK",
                 "Warning: Lights are on !  ",seconds  );
                
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.green,
                child: Center(
                  child: Text(
                    "Show Notification"
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}