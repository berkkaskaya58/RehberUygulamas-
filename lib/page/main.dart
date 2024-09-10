import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';  // Easy Localization paketini dahil edin
import 'package:telefon_rehberi/page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();  // Yerelleştirme başlatma

  runApp(
    
    EasyLocalization(

      
      supportedLocales: [ Locale('en', 'US'), Locale('tr', 'TR')],  // Desteklenen diller
      path: 'assets/translations',  // Çeviri dosyalarının konumu
      fallbackLocale:const Locale('en', 'US'),  // Varsayılan dil
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: "/",
      // routes: {"/":(context)=>LoginPage(),
      // "/Second":(context)=>SignPage(),
      // },


      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,  // Yerelleştirme delegeleri
      supportedLocales: context.supportedLocales,  // Desteklenen diller
      locale: context.locale,  // Şu anki dil
      home: const LoginPage(),
    );
  }
}
