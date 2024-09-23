import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: const Color(0xFF1C64EF), // Metin rengi
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Köşe yuvarlama
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // İç boşluk
    );
  }}