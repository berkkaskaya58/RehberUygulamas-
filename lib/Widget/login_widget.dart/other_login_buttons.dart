import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telefon_rehberi/widget/widget_button.dart';
import 'package:telefon_rehberi/generated/locale_keys.g.dart';
import 'package:telefon_rehberi/ui/ui_color.dart';
import 'package:telefon_rehberi/ui/ui_image.dart';

class OtherLoginButtons extends StatelessWidget {
  OtherLoginButtons({super.key});

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        // Kullanıcı Google oturumunu iptal etti
        print('Google oturumu iptal edildi');
        return;
      }
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Başarılı giriş sonrası yapılacak işlemler
      print('Google ile giriş başarılı');
    } catch (e) {
      print('Hata: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;

    return Column(
      children: [
        GestureDetector(
         
          child: ButtonBasic(
            prefixPath: ImagePath.google,
            textColor: Colors.black,
            color: UIColors.white,
            text: LocaleKeys.loginWithGoogle,
            titleColor: UIColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            func: ()async {
              
          
            await signInWithGoogle();
          },
            
          ),
        ),
        SizedBox(
          height: paddingHorizontal / 1.5,
        ),
        ButtonBasic(
          prefixPath: ImagePath.facebook,
          textColor: Colors.black,
          color: UIColors.white,
          text: LocaleKeys.loginWithFacebook,
          titleColor: UIColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          func: () {},
        ),
      ],
    );
  }
}
