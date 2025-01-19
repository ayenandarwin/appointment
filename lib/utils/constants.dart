import 'package:flutter/material.dart';

class Constant{

 static const primaryColor =  Color.fromARGB(255, 16, 21, 30);

  
    static const secondaryColor = Color.fromARGB(255, 36, 42, 53);

  static const elevatedButtonColor = Color.fromARGB(255, 11, 99, 110);

  static const textColor = Color.fromARGB(255, 5, 156, 145);

   static const defaultColor = Color(0xFFC3C4C4);
  static const carrot = Color(0xFFe67e22);
  static const alizarin = Color(0xFFe74c3c);
  static const wetAsphalt = Color(0xFF34495e);

  // static get subTitleGradient =>const LinearGradient(
  //                           colors: <Color>[Color.fromARGB(255, 33, 3, 182), Color.fromARGB(255, 3, 100, 25)],
  //                         ).createShader(Rect.fromLTRB(0.5, 0, 0.5, 0));

  static const firstColor = Color.fromARGB(255, 3, 111, 200);
  static const secondColor = Color.fromARGB(255, 5, 156, 145);
  static const thirdColor = Color.fromARGB(255, 3, 111, 200);

  static get subTitleGradient =>const [
    firstColor,
    secondColor
  ];

  // static get mainGradient => LinearGradient(colors: const[Color.fromARGB(255, 47, 60, 135),Color.fromARGB(255, 14, 107, 119), ]);
  static get mainGradient => LinearGradient(colors: const[primaryColor,primaryColor, ]);
  static get buttonGradient => LinearGradient(colors: const[firstColor,secondColor, ]);

  static get textStyle => const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    );

  static get titleStyle => const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white
    );
  
  //static get bodyStyle =>  GoogleFonts.roboto(color: Colors.white,letterSpacing: 0.5,height: 1.5);
}


//fontsize
const double fieldDataFontSize = 18.0;
const double smallFieldDataFontSize = 16.0;

//padding
const double kPaddingS = 8.0;
const double kPaddingM = 16.0;
const double kPaddingL = 32.0;

//App Color 
// Define a custom MaterialColor
MaterialColor kPrimaryColor = const MaterialColor(0xFF6200EE, {
  50: Color(0xFFEDE7F6),
  100: Color(0xFFD1C4E9),
  200: Color(0xFFB39DDB),
  300: Color(0xFF9575CD),
  400: Color(0xFF7E57C2),
  500: Color(0xFF6200EE),
  600: Color(0xFF5E35B1),
  700: Color(0xFF512DA8),
  800: Color(0xFF4527A0),
  900: Color(0xFF311B92),
});

