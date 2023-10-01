// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:second/views/home/home_screen.dart'; // Om du väljer att navigera direkt till HomeScreen efter registrering.

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registrera dig'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'E-post',
//                 border: OutlineInputBorder(), // Adding a border
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Lösenord',
//                 border: OutlineInputBorder(), // Adding a border
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _registerWithEmailAndPassword,
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepPurple,
//                 onPrimary: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
//               ),
//               child: Text('Registrera dig'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _registerWithEmailAndPassword() async {
//     final String email = _emailController.text.trim();
//     final String password = _passwordController.text.trim();

//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Framgångsrik registrering
//       // Använd pushReplacement för att navigera till HomeScreen och samtidigt ta bort RegisterScreen från stacken
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(user: userCredential.user!),
//         ),
//       );
//     } catch (e) {
//       // Hantera registreringsfel
//       print('Fel vid registrering: $e');
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:second/views/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _error = ""; // För att visa felmeddelanden för användaren.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrera dig'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-post',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Lösenord',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _registerWithEmailAndPassword,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              ),
              child: Text('Registrera dig'),
            ),
            // Visa felmeddelanden om det finns något
            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _error,
                  style: TextStyle(color: Colors.red),
                ),
              )
          ],
        ),
      ),
    );
  }

  void _registerWithEmailAndPassword() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(user: userCredential.user!),
        ),
      );
    } catch (e) {
      setState(() {
        _error = "Registrering misslyckades. Försök igen.";
      });
      print('Fel vid registrering: $e');
    }
  }
}
