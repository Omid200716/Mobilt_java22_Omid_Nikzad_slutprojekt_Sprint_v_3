
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second/views/about/message_screen.dart';
import 'package:second/views/about/profil_screen.dart';
import 'package:second/views/about/viewer_screen.dart';
import 'package:second/views/home/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  // Konstruktor för att ta emot användaren som loggar in
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex =
      1; // Standardindex för BottomNavigationBar (Message-sidan)

  @override
  Widget build(BuildContext context) {
    // Hämta skärmens bredd och höjd med hjälp av MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chattapp'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _handleLogout,
            ),
          ],
        ),
        // Här kan du använda screenWidth och screenHeight för att anpassa din layout om så önskas.
        body: _getBody(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye),
              label: 'Viewer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  // Hantera logga ut funktionen
  Future<void> _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  // Hantera tryck på tillbaka-knappen
  Future<bool> _onBackPressed() async {
    if (_currentIndex != 1) {
      setState(() {
        _currentIndex = (_currentIndex - 1) % 3;
      });
      return false;
    }

    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Bekräfta'),
            content: Text('Vill du logga ut?'),
            actions: <Widget>[
              TextButton(
                child: Text('Nej'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text('Ja'),
                onPressed: () {
                  _handleLogout();
                  Navigator.of(context).pop(true);
                },
              )
            ],
          ),
        )) ??
        false;
  }

  // Returnera en sida baserat på nuvarande index för BottomNavigationBar
  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return ViewerScreen();
      case 1:
        return MessageScreen(user: widget.user);
      case 2:
        return ProfilScreen(user: widget.user);
      default:
        return Container();
    }
  }
}
