import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? userName;

  @override
  void initState(){
    super.initState();
    setData();
  }

  setData() async {
  User? user = FirebaseAuth.instance.currentUser;

  bool done = false;

  while (!done) {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      final data = snapshot.data() as Map<String, dynamic>;

      setState(() {
        userName = data['name'];
      });

      done = true;
    } catch (e) {
      if (e is FirebaseException && e.code == 'unavailable') {
        await Future.delayed(const Duration(seconds: 2));
      } else {
        rethrow;
      }
    } 
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade400,
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacementNamed('/login_screen');
            },
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade900,
            ]
          )
        ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _imageFile = selectedImage;
                });
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content:   Text('Imagen de perfil actualizada')),
                );
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
                child: _imageFile == null ?  Text('JD',style: TextStyle(fontSize: 24.0, color:Colors.blue.shade900),) : null,
              ),
            ),
          ),
          userName == null ? const CircularProgressIndicator() : Text('Welcome $userName!',style: const TextStyle(color: Colors.white, fontSize: 20)),
          Expanded(
            child: GridView.builder(
              itemCount: 10, 
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: const TextStyle(color: Colors.white,fontSize: 20),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfilePage()));
        },
        child: Icon(Icons.edit,color: Colors.blue.shade900),
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Edit Profile',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade400,
      ),
      body: Container(
        decoration:BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade900,
            ]
          ),
        ),
        child: const Center(
        child: Text('Here is where we can edit our profile',style: TextStyle(color: Colors.white,fontSize: 20),),
      ),
      ),
    );
  }
}