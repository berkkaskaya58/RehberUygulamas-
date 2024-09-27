import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // Easy Localization paketini dahil edin
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:telefon_rehberi/firebase_options.dart';
import 'package:telefon_rehberi/storage/app_storage.dart';
import 'package:telefon_rehberi/view/view_login/login_page.dart';

void main() async {

  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase'i başlatın
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  // Firebase App Check'i aktif hale getirin
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,  // Geliştirme ortamı için debug modunu kullanın
    
  );

  // Diğer başlatma işlemleri
  await AppStorage.appStorageInitialize();
  await EasyLocalization.ensureInitialized(); // Yerelleştirme başlatma

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('tr', 'TR'),
      ], // Desteklenen diller
      path: 'assets/translations', // Çeviri dosyalarının konumu
      fallbackLocale: const Locale('en', 'US'), // Varsayılan dil
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates:
          context.localizationDelegates, // Yerelleştirme delegeleri
      supportedLocales: context.supportedLocales, // Desteklenen diller
      locale: context.locale, // Şu anki dil
      home:  LoginPage(),
    );
  }
}
