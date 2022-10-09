#include <Arduino.h>
#include <FirebaseESP8266.h>
#include <ESP8266WiFi.h>
#include <ESPAsyncTCP.h>
#include <ESPAsyncWebServer.h>
#include <ArduinoJson.h>
#include <PubSubClient.h>
#include <FS.h>
#include <NTPClient.h>
#include <WiFiUdp.h>
#include "ESP8266TrueRandom.h"
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"
#define API_KEY "AIzaSyCdrQzBlbljlRRrOX4oL5lU8-dxcKpzgR0"
#define FIREBASE_HOST "homeautomation-6d999-default-rtdb.firebaseio.com"                     //Your Firebase Project URL goes here without "http:" , "\" and "/"
#define FIREBASE_AUTH "1rknUEZTjXVlUz6avz3mx9nnHlC9zxYu1PHjBiPy"

const int pins[4] = {D5,D6,D7,D8};


FirebaseJson json;
FirebaseJson json2;
StaticJsonDocument<512> doc;
    
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");
String currentTime;

byte uuidNumber[8]; // UUIDs in binary form are 8 bytes long

const int photoresistor = A0;
const int ledPin = D5;
const int pirPin = D1;
const int buttonPin = D2; 
//const int sensorIn = A0;
bool lightsOn = true;


int buttonState = 0; 
int pirStat = 0;
int currentStat=0;
int mVperAmp = 185;           // this the 5A version of the ACS712 -use 100 for 20A Module and 66 for 30A Module
int Watt = 0;
double Voltage = 0;
double VRMS = 0;
double AmpsRMS = 0;



//^^^^ Variables used for DB^^^^^^^^

int photo_value;
int led_status;
String sunset_value;
String sunrise_value;
String power_on_value;
String power_off_value;
String timmme;

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig fbconfig;
String uid;
String roomID;

AsyncWebServer server(80);
byte Connection_Iteration = 0;

StaticJsonDocument<512> Config;

String processor(const String& var)
{
  if(var == "email")
    return Config["email"];
  else if (var == "userPassword")
    return Config["userPassword"];
  else if (var == "ssid")
    return Config["ssid"];
  else if (var == "password")
    return Config["password"];

   return String();
}


void loadConfig()
{
  File configfile = SPIFFS.open("/config.json", "r");
  deserializeJson(Config, configfile);
  configfile.close();
}

void saveConfig()
{
  File configfile = SPIFFS.open("/config.json", "w");
  serializeJson(Config, configfile);
  configfile.close();
}


//----sunset feature------------------------------------

String get_sunsetValue(String path)
{
  path+="sunset";
  if (Firebase.getString(fbdo, path)) {                          

       Serial.println("get_sunsetValue is called");                 

       return fbdo.stringData();
     

      }
      else{
        Serial.println("No light found");
        return "N/A";
      }
}

void sunset(String path){
    path+="/led_status";
   photo_value = analogRead(photoresistor);
    Serial.println(photo_value);
    if (photo_value<=500) // 3etmeh -- sunset
    {
      Firebase.RTDB.setInt(&fbdo,path,1);
//       digitalWrite(D0,HIGH);
      delay(1000);
    }
//    else{
//       Firebase.RTDB.setInt(&fbdo,path,0);
////       led_status=0;
////        digitalWrite(D0,LOW);
//       delay(2000);
//    }
}
//---------------------------------------------------

//*********** sunrise feature ***********************

String get_sunriseValue(String path)
{
  path+="sunrise";
  if (Firebase.getString(fbdo, path)) {                          

//       Serial.println("get_sunriseValue is called");                 

       return fbdo.stringData();
     

      }
      else{
        Serial.println("No light found");
        return "N/A";
      }
}

void sunrise(String path){
    path+="/led_status";
   photo_value = analogRead(photoresistor);
   Serial.println(photo_value);
    if (photo_value > 700) // mnawreh -- sunrise
    {
      Firebase.RTDB.setInt(&fbdo,path,0);
      delay(1000);
    }
//    else{
//       Firebase.RTDB.setInt(&fbdo,path,0);
////       led_status=0;
////        digitalWrite(D0,LOW);
//       delay(2000);
//    }
}

//*************************************************

//^^^^^^^^^^^^^ Power-on / Power-off^^^^^^^^^^^^^^^^^^

String get_power_on(String path)
{
  path+="power-on";
    if (Firebase.getString(fbdo, path)) {                          

//       Serial.println("get_power_on is called");                 

       return fbdo.stringData();
     

      }
      else{
        Serial.println("No light found");
        return "N/A";
      }
  
}

void power_on(String path)
{
  path+="/led_status";
   Firebase.RTDB.setInt(&fbdo,path,1);

}

String get_power_off(String path)
{
  path+="power-off";
    if (Firebase.getString(fbdo, path)) {                          

//       Serial.println("get_power_off is called");                 

       return fbdo.stringData();
     

      }
      else{
        Serial.println("No light found");
        return "N/A";
      }
  
}

void power_off(String path)
{
   path+="/led_status";
   Firebase.RTDB.setInt(&fbdo,path,0);

}

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//$$$$$$$$$$$$$$$$$$ Time $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

String get_time()
{
  timeClient.update();
  String timee="\"";
  int currentHour = timeClient.getHours();
  
  if(currentHour > 12)
  {
   currentHour-=12;
   
  }
  if(currentHour == 0)
  {
    currentHour = 12;
  }
//  Serial.println(currentHour);  
  timee+=String (currentHour);
  timee+=":";

  int currentMinute = timeClient.getMinutes();
  if(currentMinute<10){
    timee+="0";
  }
//  Serial.print("Minutes: ");
//  Serial.println(currentMinute);
  timee+=currentMinute;

  return timee;
}

String set_AM_PM(){
  timeClient.update();
  String am_pm="";  
  int currentHour = timeClient.getHours(); 
  Serial.print("This is the current hour from AM_PM funtion:");
  Serial.println(currentHour);
  if(currentHour>=12)
  {
    am_pm=" PM";
  }
  else if(currentHour == 0)
  {
    am_pm=" AM";
  }
  else
    am_pm=" AM";

    Serial.println(am_pm);

   return am_pm+"\"";
}
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

//........ Read PIR Value ...................
int read_pir()
{
  int pirStat = digitalRead(pirPin); 
  return pirStat;
  delay(2000);
}
//...........................................

//<<<<<<<<<<< Set PIR value in DB >>>>>>>>>>>>

void set_pir_value(String path){
  path+="pir-sensor";
  int value = read_pir();
  Firebase.RTDB.setInt(&fbdo,path,value);
//  Serial.println("This is set_pir_value");
    
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//$$$$$$$$$$$$ Create new room when button is pushed $$$$$$$$$

String randomID_generator(){

  ESP8266TrueRandom.uuid(uuidNumber);
  String uuidStr = ESP8266TrueRandom.uuidToString(uuidNumber);
  Serial.println("The UUID number is " + uuidStr);
  return uuidStr;
}

void create_new_room(String path){
   Serial.println(" Button state: HIGH");
     Serial.println("HIGH");
     FirebaseJson json;
      String roomID = randomID_generator();
      
        json.set(roomID+"/alias",roomID);
    if (Firebase.updateNode(fbdo,path,json)){
        Serial.print("A new room is added to:");
       Serial.println(fbdo.dataPath());
       randomID_generator();
       Config["roomID"] = roomID;
       saveConfig();
      }
      json.set(roomID+"/pins/p0",false);
      Firebase.updateNode(fbdo,path,json);
      
      json.set(roomID+"/pins/p1",false);
      Firebase.updateNode(fbdo,path,json);
      
      json.set(roomID+"/pins/p2",false);
      Firebase.updateNode(fbdo,path,json);
      
      json.set(roomID+"/pins/p3",false);
      Firebase.updateNode(fbdo,path,json);
       
      
}

//************ Current Sensor**************
//
//float getVPP()
//{
//  float result;
//  int readValue;                // value read from the sensor
//  int maxValue = 0;             // store max value here
//  int minValue = 1024;          // store min value here
//  
//   uint32_t start_time = millis();
//   while((millis()-start_time) < 1000) //sample for 1 Sec
//   {
//       readValue = analogRead(sensorIn);
//       // see if you have a new maxValue
//       if (readValue > maxValue) 
//       {
//           //record the maximum sensor value/
//           maxValue = readValue;
//       }
//       if (readValue < minValue) 
//       {
//           //record the minimum sensor value/
//           minValue = readValue;
//       }
//   }
//   
//   // Subtract min from max
//   result = ((maxValue - minValue) * 5.0)/1024.0;
//      
//   return result;
// }
//
//int Calculate_Watt()
//{
//   Voltage = getVPP();
//  VRMS = (Voltage/2.0) *0.707;   //root 2 is 0.707
//  AmpsRMS = (VRMS * 1000)/mVperAmp;
// 
//  Serial.print(AmpsRMS);
//  Serial.print(" Amps RMS  ---  ");
//  Watt = (AmpsRMS*240/1.3);      // 1.3 is an empirical calibration factor
//  Serial.print(Watt);
//  Serial.println(" W");
//
//  return Watt;
//}

bool sunlight()
{
  photo_value = analogRead(photoresistor);
  Serial.println("Photo resistor value: " );
  Serial.println(photo_value);
  return photo_value > 650;  
}

void check_lights(String path)
{
  String roomPath = path;
  path+="lights/";
//  String lightPath = path;
  if(Firebase.getJSON(fbdo,path)){
//    Serial.println(fbdo.jsonString());
      String jsonn = fbdo.jsonString();
      int sizee = jsonn.length()+1;
      char lightsDatajson[sizee];
      jsonn.toCharArray(lightsDatajson,sizee);
//      Serial.println(lightsDatajson);
      DeserializationError error = deserializeJson(doc,(char*) lightsDatajson);
      if (error) {
        Serial.print(F("deserializeJson() failed: "));
        Serial.println(error.f_str());
        return;
      }

      JsonObject object = doc.as<JsonObject>();
      for (JsonPair keyValue : object) {    
            String lightPath = path;
//          Serial.println(keyValue.key().c_str());
            int index = keyValue.value()["pin"];
            int pin = pins[index];
            lightPath += keyValue.key().c_str();
//            Serial.print("Light path:");
//            Serial.println(lightPath);
        
              if(keyValue.value()["led_status"] == 0)
            { 
//              Serial.println(" Switched off the room");
              digitalWrite(pin,LOW);
            }
            else{
//              Serial.println(" Switched off the room");
              digitalWrite(pin,HIGH);
            }

 
             if (power_on_value == timmme)
             {
                power_on(lightPath);
             }

             if (power_off_value == timmme)
             {
                power_off(lightPath);
             }


          
             if (sunlight())
             {
                Serial.println(sunlight());
                Serial.println(lightsOn);
                if(lightsOn)
                  if(sunrise_value == "true")
                     power_off(lightPath);
                lightsOn = false;
             }
             else
             {
                Serial.println(sunlight());
                Serial.println(lightsOn);
                if (!lightsOn)
                  if(sunset_value == "true")
                     power_on(lightPath);
                lightsOn = true;
             }
             
           
             
      }

  }
  
}


void setup() {
  
    Serial.begin(115200);
    timeClient.begin();
    timeClient.setTimeOffset(10800);
    pinMode(D5, OUTPUT);
    pinMode(D6, OUTPUT);
    pinMode(D7, OUTPUT);
    pinMode(D8, OUTPUT);     
    pinMode(pirPin, INPUT);
    pinMode(photoresistor,INPUT);
    pinMode(buttonPin, INPUT);
    pinMode(LED_BUILTIN, OUTPUT);

    if (!SPIFFS.begin()){
      ESP.restart();
    }

 // Brings data from config.json and deserialize the file to json 
   loadConfig();
   String ssid = Config["ssid"];
   String password = Config["password"];
   String email = Config["email"];
   String userPassword = Config["userPassword"];
   String APssid = Config["APssid"];
   String APpassword = Config["APpassword"];
   String rID = Config["roomID"];
   roomID = rID;
//-----------------------------------------------------------------

  
  
   WiFi.mode(WIFI_AP_STA); // defines that WiFi mode could be either Access Point or Station(it can connect to local network)
   WiFi.softAP("ESP8266","",2);

    Serial.print("ssid: ");
    Serial.println(ssid);
    Serial.print("ssid password: ");
    Serial.println(password);
    Serial.print("email: ");
    Serial.println(email);
    Serial.print("pass: ");
    Serial.println(userPassword);
    Serial.print("roomID:");
    Serial.println(roomID);

    server.begin();

//------ Brings html and css files when the server is begun--------

   server.on("/", [](AsyncWebServerRequest *request){
    String email_temp = Config["email"];
    request->send(SPIFFS, "/index.html",  String(), false, processor);
  });

  server.on("/index.css", [](AsyncWebServerRequest *request){
    
    request->send(SPIFFS, "/index.css", "text/css");
  });
  
//-----------------------------------------------------------------


//*************What actions to do when the buttons in the webpage forms are pressed********************

  server.on("/saveapconfig", HTTP_POST, [](AsyncWebServerRequest *request){
    String email_temp = request->getParam("email", true)->value();
    String userPassword_temp = request->getParam("userPassword", true)->value();
    Config["email"] = email_temp;
    Config["userPassword"] = userPassword_temp;
    saveConfig();
    request->redirect("/");    
  });
  server.on("/savewificonfig", HTTP_POST, [](AsyncWebServerRequest *request){
    String ssid_temp = request->getParam("ssid", true)->value();
    String password_temp = request->getParam("password", true)->value();
    Config["ssid"] = ssid_temp;
    Config["password"] = password_temp;
    saveConfig();
    request->redirect("/");
  });
  server.on("/restart", [](AsyncWebServerRequest *request){
    ESP.reset();
  });
  
//**************************************************************************************


  WiFi.begin(ssid, password);
   for(int i = 0 ; i < 10; i++)
    {
      if(WiFi.status() == WL_CONNECTED)
      {
        Serial.println("WiFi connected");
        Serial.println("IP address :");
        // this local ip can be accessed from other networks 
        Serial.println(WiFi.localIP());  //192.168.1.29
        goto skip;
      }
      delay(500);
    }

    // this WiFi mode changes to access point if NODEMCU could not connect to local network  
    WiFi.mode(WIFI_AP);


    skip:

    fbconfig.api_key = API_KEY;
    auth.user.email = email;
    auth.user.password = userPassword;

    fbdo.setResponseSize(4096);
    fbconfig.token_status_callback = tokenStatusCallback;
    fbconfig.max_token_generation_retry = 5;
    Firebase.begin(&fbconfig, &auth);
    for(int i = 0 ; i < 10; i++)
    {
      if((auth.token.uid) != ""){
         uid = auth.token.uid.c_str();
         Serial.print("User UID: ");
         Serial.print(uid);
         break;
      }     
      delay(500);
    }
}

void loop() {
   
  if(WiFi.status() == WL_CONNECTED ){

    // This gives a feedback to the user about the wifi status
    // if the builtin led blinks, then connected to wifi successfully
    digitalWrite(LED_BUILTIN, HIGH);   
    delay(1000);                     
    digitalWrite(LED_BUILTIN, LOW);   
    delay(1000);

    
    Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);   // connect to firebase
    Serial.println("Connected to firebase");
    Serial.println("Connected to wifi and got the uid");
    String path="";
    path+=uid; // dynamic
    path+="/rooms/";
//  path+="room1/";   //static 
    path += roomID;  //dynamic
    path+="/"  ;
    buttonState = digitalRead(buttonPin);
    Serial.println(buttonPin);

if(roomID != NULL){

  
    if (buttonState == HIGH){
        String pathh="";
        pathh+=uid;
        pathh+="/rooms/";
        Serial.println(pathh);
        create_new_room(pathh);

    }
    else{
    Serial.println("Button state: LOW");
   }
    
    
    Serial.println(path);
    


    sunset_value = get_sunsetValue(path); 
    Serial.print("Sunset value:" );
    Serial.println(sunset_value);


    sunrise_value = get_sunriseValue(path); 
    Serial.print("sunrise value:" );
    Serial.println(sunrise_value);


    timmme="\"";
    timmme=get_time()+set_AM_PM();
  
    power_on_value= get_power_on(path);
    Serial.print("power-on value:" );
    Serial.println(power_on_value);


    power_off_value= get_power_off(path);
    Serial.print("power-off value:" );
    Serial.println(power_off_value);
    
    Serial.println("timme :");
    Serial.println(timmme);




       check_lights(path);
       
   }

}

  
  else{
    Firebase.reconnectWiFi(true);
  }
//  delay(1000);
}
