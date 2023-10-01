import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:second/views/about/showprofil_screen.dart';

class ProfilScreen extends StatefulWidget {
  final User user;

  const ProfilScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  bool _dataSaved = false;

  @override
  Widget build(BuildContext context) {
    // Använder MediaQuery för att hämta skärmens bredd och höjd
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: _dataSaved ? _showSavedData() : _buildForm(),
      ),
    );
  }

   // Bygger formuläret för profilinformation
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildProfileImage(),
          SizedBox(height: 20),  // Konstant höjd för avstånd
          _buildTextField(_firstNameController, 'Förnamn', 'Ange ditt förnamn'),
          SizedBox(height: 20),  // Konstant höjd för avstånd
          _buildTextField(_lastNameController, 'Efternamn', 'Ange ditt efternamn'),
          SizedBox(height: 20),  // Konstant höjd för avstånd
          _buildTextField(_ageController, 'Ålder', 'Ange din ålder', isNumeric: true),
          SizedBox(height: 20),  // Konstant höjd för avstånd
          _buildTextField(_cityController, 'Stad', 'Ange din stad'),
          SizedBox(height: 20),  // Konstant höjd för avstånd
          _buildTextField(_phoneNumberController, 'Telefonnummer', 'Ange ditt telefonnummer', isNumeric: true),
          SizedBox(height: 20),  // Konstant höjd för avstånd
          ElevatedButton(child: Text('Ladda upp bild'), onPressed: _uploadImage),
          ElevatedButton(child: Text('Spara'), onPressed: _saveProfileDataIfValid)
        ],
      ),
    );
  }


  // Bygger profilbild-widgeten
  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 50,
      child: Icon(Icons.person, size: 50),
      backgroundImage: _imageUrl != null ? NetworkImage(_imageUrl!) : null,
    );
  }

  // Bygger en textfält-widget med gemensam stil
  Widget _buildTextField(TextEditingController controller, String label, String validationMsg, {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMsg;
        }
        return null;
      },
    );
  }

  // Visar den sparade profilinformationen
  Widget _showSavedData() {
    return Column(
      children: [
        _buildProfileImage(),
        SizedBox(height: 16),
        Text("Förnamn: ${_firstNameController.text}"),
        Text("Efternamn: ${_lastNameController.text}"),
        Text("Ålder: ${_ageController.text}"),
        Text("Stad: ${_cityController.text}"),
        Text("Telefonnummer: ${_phoneNumberController.text}")
      ],
    );
  }

  // Validerar och sparar profilinformation
  void _saveProfileDataIfValid() {
    if (_formKey.currentState!.validate()) {
      _saveProfileData();
    }
  }

  Future<void> _uploadImage() async {
    // Dialog för att välja antingen kamera eller galleri
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Välj en metod'),
        actions: [
          TextButton(child: Text('Kamera'), onPressed: () => _selectImage(ctx, ImageSource.camera)),
          TextButton(child: Text('Galleri'), onPressed: () => _selectImage(ctx, ImageSource.gallery))
        ],
      ),
    );
  }

  void _selectImage(BuildContext ctx, ImageSource source) {
    Navigator.of(ctx).pop();
    _getImageAndUpload(source);
  }

  Future<void> _getImageAndUpload(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        final ref = FirebaseStorage.instance.ref().child('user_images').child(widget.user.uid + '.jpg');
        await ref.putFile(file);
        _imageUrl = await ref.getDownloadURL();
        setState(() {});
      }
    } catch (e) {
      print("Error when trying to get image: $e");
    }
  }

  void _saveProfileData() async {
    await FirebaseFirestore.instance.collection('users').doc(widget.user.uid).set({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'age': _ageController.text,
      'city': _cityController.text,
      'phoneNumber': _phoneNumberController.text,
      'imageUrl': _imageUrl ?? "",
    });
    // Här kan du navigera till nästa sida eller visa någon bekräftelse till användaren
  }
}
