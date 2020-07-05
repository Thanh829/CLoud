#include <ESP8266WiFi.h>                                                      // esp8266 library
#include <FirebaseArduino.h>                                                // firebase library
#include <DHT.h>                                                            // dht11 temperature and humidity sensor library
//#include <WiFi.h>
#include <NTPClient.h>
#include <WiFiUdp.h>
#include <ArduinoJson.h>

#define FIREBASE_HOST "myproject-41598.firebaseio.com"                          // the project name address from firebase id
#define FIREBASE_AUTH "rQkTco1OSLgOVF3tOE1wFqrYmlyePU96GEcEbeVa"            // the secret key generated from firebase

#define WIFI_SSID "FY"                                             // input your home or public wifi name 
#define WIFI_PASSWORD "01101001"                                    //password of wifi ssid
 
#define DHTPIN D4                                                           // what digital pin we're connected to
#define DHTTYPE DHT11                                                       // select dht type as DHT 11 or DHT22
DHT dht(DHTPIN, DHTTYPE);  

// Define NTP Client to get time
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP);

// Variables to save date and time
String formattedDate;
String dayStamp;
String timeStamp;                                                   

void setup() {
  Serial.begin(9600);
  delay(1000);                
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);                                     //try to connect with wifi
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("Connected to ");
  Serial.println(WIFI_SSID);
  Serial.print("IP Address is : ");
  Serial.println(WiFi.localIP());                                            //print local IP address
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);                              // connect to firebase
  dht.begin();                                                               //Start reading dht sensor
  // Initialize a NTPClient to get time
timeClient.begin();
// Set offset time in seconds to adjust for your timezone, for example:
// GMT +1 = 3600
// GMT +8 = 28800
// GMT -1 = -3600
// GMT 0 = 0
timeClient.setTimeOffset(25200); //Thailand +7 = 25200
delay(5000);

}

void loop() { 
 while(!timeClient.update()) {
timeClient.forceUpdate();
 }
  float h = dht.readHumidity();                                              // Reading temperature or humidity takes about 250 milliseconds!
  float t = dht.readTemperature();                                           // Read temperature as Celsius (the default)
   StaticJsonBuffer<200> jsonBuffer;
   JsonObject& data = jsonBuffer.createObject();
    
  
  // The formattedDate comes with the following format:
// 2018-05-28T16:00:13Z
// We need to extract date and time
formattedDate = timeClient.getFormattedDate();
Serial.println(formattedDate);

// Extract date
int splitT = formattedDate.indexOf("T");
dayStamp = formattedDate.substring(0, splitT);
Serial.print("DATE: ");
Serial.println(dayStamp);
// Extract time
timeStamp = formattedDate.substring(splitT+1, formattedDate.length()-1);
Serial.print("HOUR: ");
Serial.println(timeStamp);

 
  Serial.print("Humidity: ");  Serial.print(h);
  String fireHumid = String(h);                                         //convert integer humidity to string humidity 
  Serial.print("%  Temperature: ");  Serial.print(t);  Serial.println("Â°C ");
  String fireTemp = String(t) ;                                                     //convert integer temperature to string temperature
  
  data["Day"]=dayStamp;
  data["Time"]=timeStamp;
  data["Humidity"]=fireHumid;
  data["Temperature"]= fireTemp;
  Firebase.push("/DHT11/Data", data);
 delay(10000);
  
   
}
