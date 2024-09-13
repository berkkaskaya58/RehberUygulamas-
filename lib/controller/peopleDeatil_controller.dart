import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telefon_rehberi/future.dart';
import 'package:url_launcher/url_launcher.dart';

class PeopledeatilController extends GetxController{
    final List<TextEditingController> phoneNumberControllers = [
    TextEditingController()
  ];
    File? imagePath;
    void _addPhoneNumberField() {
   
      phoneNumberControllers.add(TextEditingController());
    
  }

  Future<void> _selectImage() async {
    final pickedImage = await FutureVoid.pickImageFromGallery();
    
      imagePath = pickedImage;
  
  }

   Future<void> message() async {
   

    final Uri launchUri = Uri(
      scheme: 'sms',
      path: '+904445553525', // Boşluk olmadan
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print("Could not launch $launchUri");
    }
  }
   Future<void> eMail() async {
    final Uri launchUri = Uri(scheme: 'mailto', path:'berkkaskaya01@gmail.com' );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print("Could not launch $launchUri");
    }
  }
     Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path:'+904445553525' );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print("Could not launch $launchUri");
    }
  }



}