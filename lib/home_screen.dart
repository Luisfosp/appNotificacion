import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notificaion/notification_services.dart';
import "package:http/http.dart" as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final title=TextEditingController();
  final body=TextEditingController();
  NotificationServices notificationServices=NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value){
      print("Device token");
      print(value);
    });
    
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
        child: Center(
        child: TextButton(onPressed:(){
          notificationServices.getDeviceToken().then((value) async{
            var cel='e0bNLmcYRiyyvEc5-P4s16:APA91bHatBj0IBMlXho1E5H1Sr4ug00fZlbCApQzZj34fabK5jstrmRFa8wgK3mhRR53jsARdbHtSIeZznK2OlSnSUR-kOU1AubPk8-zNuXqt7vloXM2DcEh7oMIq49m5k7mSoECR2IG';
            var reloj='e4thGwpFQXOhg_VFb6AQXs:APA91bH2HQo3iW4sWEsIOFyALUrS5GjSvu4KpN_PvnikH74IzgxMLhsPGDjR4YfSMcwxtPy-8Aml3pafNkdXawaeX2ZRFYQerZw0tEnkyu6RUo5zZfapBgW094WXgM-yv1cdrYj4QxIP';
            
            var data = {
              'to': cel/*value.toString()*/,
              'priority': 'high',
              'notification': {
                'title': 'Hola',
                'body': 'Es una prueba de notificación', // Cuerpo ingresado en el formulario
              },
              'data': {
                'type': 'msj',
                'id': '1234'
              }

            };



            await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
             body: jsonEncode(data),
            headers:{
               'Content-Type': 'application/json; charset=UTF-8',
               'Authorization': 'key=AAAAaALo59I:APA91bF1UfiO7WMT183hB4ZdDNUNqElRN0PhLyZSZxFShbLL54dnFIZM_5C0A5vfN23Z3UamHYLBP1bJzAFCYUtg0h1ejlv1JeF9jnfDC4Rmo7PqvRmrnPfm7VoXgANKXTMK9AduC73L'
              }
            );
          });
        },
        child: const Text(
           'Envíar notificación',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
         ),
        ),
      ),
      ),
      )
      );
     
    
  }
}