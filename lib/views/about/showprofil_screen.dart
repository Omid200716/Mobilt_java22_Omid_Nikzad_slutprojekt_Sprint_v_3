import 'package:flutter/material.dart';

class ShowProfileScreen extends StatelessWidget {
  final String imageUrl;
  final String firstName;
  final String lastName;
  final int age;
  final String city;
  final String phoneNumber;

  const ShowProfileScreen({
    Key? key,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.city,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profildata")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(height: 16),
            Text("Förnamn: $firstName"),
            Text("Efternamn: $lastName"),
            Text("Ålder: $age"),
            Text("Stad: $city"),
            Text("Telefonnummer: $phoneNumber"),
          ],
        ),
      ),
    );
  }
}



