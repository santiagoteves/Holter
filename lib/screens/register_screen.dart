import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen>{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  bool _isEmail(String string){
    const Pattern pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final RegExp regex = RegExp(pattern as String);
    return(!regex.hasMatch(string)) ? false : true;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key : _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre'
              ),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Ingresa tu nombre';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _surnameController,
              decoration: const InputDecoration(
                labelText: 'Apellido'
              ),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Ingresa tu apellido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email'
              ),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Ingrese su correo electronico';
                } else if(!_isEmail(value)){
                  return 'Ingrese un correo electronico valido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña'
              ),
              validator:(value){
                if (value == null || value.isEmpty){
                  return 'Ingrese su contraseña';
                }else if(value.length < 4){
                  return 'La contraseña debe tener al menos 4 caracteres';
                }
                return null;
              },
              obscureText: true,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirmar contraseña'
              ),
              validator:(value){
                if(value != _passwordController.text){
                  return 'Las contraseñas no coinciden';
                }
                return null;
              },
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var messenger = ScaffoldMessenger.of(context);
                if (_formKey.currentState!.validate()){
                  try{
                    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim()
                    );

                    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                      'name': _nameController.text,
                      'surname': _surnameController.text,
                      'email': _emailController.text,
                    });
                    messenger.showSnackBar(const SnackBar (content: Text('Usuario registrado con exito')));
                  } on FirebaseAuthException catch (e){
                    messenger.showSnackBar(SnackBar(content: Text(e.message ?? 'Error desconocido')));
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
              child: const Text('Sign up'),
            )
          ],
        ),
      ),
      )
    );
  }
    @override 
  void dispose(){
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

