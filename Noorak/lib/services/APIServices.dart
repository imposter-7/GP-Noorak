import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class APIServices
{
  Stream<DatabaseEvent> rooms()
  {
    
    final FirebaseDatabase db = FirebaseDatabase.instance;
    return db.ref(get_UID()).child("rooms").onValue.asBroadcastStream();
  }

   Stream<DatabaseEvent> roomDetails(String roomID)
  {
    final FirebaseDatabase db = FirebaseDatabase.instance;
    return db.ref(get_UID()).child("rooms").child(roomID).onValue.asBroadcastStream();
  }

  Stream<DatabaseEvent> lights(String roomID)
  {
    final FirebaseDatabase db = FirebaseDatabase.instance;
    return db.ref(get_UID()).child("rooms").child(roomID).child("lights").onValue.asBroadcastStream();
  }

  Future toggleLight(String roomID, String lightID) async
  {
    final DatabaseReference  db = FirebaseDatabase.instance.ref(get_UID()).child("rooms").child(roomID).child("lights").child(lightID);
    final DatabaseEvent event = await db.once();
    final Map data = event.snapshot.value as Map;
    if(data['led_status'] == 1)
    {
      await db.update({'led_status': 0});
    }
    else
    {
      await db.update({'led_status': 1});
    }
  }

  Future addLight(String alias, String roomID) async
  {
    

    final DatabaseReference  db = FirebaseDatabase.instance.ref(get_UID()).child("rooms").child(roomID).child("lights");
    
    final DatabaseEvent event = await db.once();
    late Map data;
    final List exitsingRooms;
    const Uuid uuid = Uuid();
    late String newUUID;
    try
    {
      data = event.snapshot.value as Map;
      exitsingRooms = data.keys.toList();
      while(true)
      {
        newUUID = uuid.v1().toString();
        if(!exitsingRooms.contains(newUUID)) 
        {
          await db.update( {newUUID: {"alias" : alias}});
          await db.child(newUUID).child("led_status").set(0);
          break;
        }
      }
      }
    catch(_)
    {
      newUUID = uuid.v1().toString();
      await db.update( {newUUID: {"alias" : alias}});
      await db.child(newUUID).child("led_status").set(0);
    }
    
   
  }
  
  Future setFeature(String feature, String value, String roomID) async{
   final DatabaseReference db =  FirebaseDatabase.instance.ref(get_UID()).child("rooms").child(roomID);
   await db.update({feature:value});
  }

  Future setSunsFeature(String feature, bool value, String roomID) async{
   final DatabaseReference db =  FirebaseDatabase.instance.ref(get_UID()).child("rooms").child(roomID);
   await db.update({feature:value});
  }

  String get_UID(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return user!.uid;
  }

   String? get_email(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return user!.email;
  }

  Future<String> get_Username() async {
      final DatabaseReference db =  FirebaseDatabase.instance.ref(get_UID());
      final DatabaseEvent event = await db.once();
      final Map data = event.snapshot.value as Map;
      print(data['alias']);
      String username = data['alias'].toString();
      return username;
  }

  void removeFeature(String roomID, String feature) async{
   await FirebaseDatabase.instance.ref(get_UID()).child("rooms").child(roomID).child(feature).remove();
  }

  void removeLight(String roomID, String lightID) async{
   await FirebaseDatabase.instance.ref(get_UID()).child("rooms").child(roomID).child("lights").child(lightID).remove();
  }

  void removeRoom(String roomID) async{
    await FirebaseDatabase.instance.ref(get_UID()).child("rooms").child(roomID).remove();
  }

}