import 'package:flutter/material.dart';

class AppTheme {
  // Fournir une méthode pour construire le BoxDecoration avec l'image de fond
  static BoxDecoration get backgroundDecoration {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/background.jpg'),
        fit: BoxFit.cover, // Pour couvrir tout l'espace
        alignment: Alignment.center, // Pour centrer l'image
      ),
    );
  }

  // AppBar theme avec transparence
  static AppBarTheme get transparentAppBarTheme {
    return AppBarTheme(
      backgroundColor: Colors.black.withAlpha(77), // ~30% d'opacité
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            color: Color.fromARGB(150, 0, 0, 0),
          ),
        ],
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      // Scheme de couleurs de base
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(
            0xFF00BABC), // Couleur verdâtre comme sur votre screenshot
        brightness: Brightness.light,
      ),
      useMaterial3: true,

      // Appliquer notre AppBar transparente
      appBarTheme: transparentAppBarTheme,

      // Thème de card avec élévation et contraste sur fond d'image
      cardTheme: CardTheme(
        elevation: 3,
        color: Colors.white.withAlpha(230), // ~90% d'opacité
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Thème de champ de texte amélioré
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withAlpha(230), // ~90% d'opacité
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xFF00BABC).withAlpha(77), // ~30% d'opacité
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF00BABC), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      // Style de bouton adapté pour contraster avec le fond
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color(0xFF2196F3), // Bleu comme sur votre screenshot
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 3,
              color: Color.fromARGB(150, 0, 0, 0),
            ),
          ],
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              color: Color.fromARGB(150, 0, 0, 0),
            ),
          ],
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF00BABC),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      appBarTheme: transparentAppBarTheme,
      cardTheme: CardTheme(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.grey[850],
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xFF00BABC).withAlpha(77), // ~30% d'opacité
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF00BABC), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
