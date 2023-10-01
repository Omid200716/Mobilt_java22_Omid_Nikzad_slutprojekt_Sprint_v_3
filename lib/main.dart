// import 'package:flutter/material.dart';
// import 'package:second/firebase_options.dart';
// import 'package:second/views/home/login_screen.dart';
// import 'package:firebase_core/firebase_core.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);


//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(

//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }



// Importera nödvändiga paket.
import 'package:flutter/material.dart';
import 'package:second/firebase_options.dart';
import 'package:second/views/home/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Se till att Flutter-widgets initieras innan appen startar.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisera Firebase med plattformsspecifika inställningar.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Starta appen.
  runApp(const MyApp());
}

// MyApp är root-widgeten för hela applikationen.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Använd ett färgschema baserat på en startfärg.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // Använd Material 3-tema.
        useMaterial3: true,
      ),
      // Startsidan för appen är inloggningsskärmen.
      home: LoginScreen(),
    );
  }
}
