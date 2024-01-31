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
        title: const Text('Profile'),
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
      body: Column(
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
                backgroundImage: _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
                child: _imageFile == null ? const Text('JD') : null,
              ),
            ),
          ),
          const Text('John Doe'),
          Expanded(
            child: GridView.builder(
              itemCount: 10, 
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfilePage()));
        },
        child: const Icon(Icons.edit),
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
        title:const Text('Edit Profile'),
      ),
      body: const Center(
        child: Text('Here is where we can edit our profile'),
      ),
    );
  }
}