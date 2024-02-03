import 'dart:io';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade400,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Acción para cerrar sesión
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
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
                child: _imageFile == null ?  Text('JD',style: TextStyle(fontSize: 24.0, color:Colors.blue.shade900),) : null,
              ),
            ),
          ),
          const Text('John Doe',style: TextStyle(color: Colors.white,fontSize: 20)),
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