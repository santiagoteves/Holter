import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
                title: const Text('Registro', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blue.shade400,
                elevation: 0,
            ),
            body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                            Colors.blue.shade400,
                            Colors.blue.shade900,
                        ],
                    ),
                ),
                child:Center(
                    child : Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        child: SingleChildScrollView(
                            child: Form(
                                key : _formKey,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        TextFormField(
                                            controller: _nameController,
                                            decoration: const InputDecoration(
                                                labelText: 'Nombre',
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                ),
                                                hintStyle: TextStyle(color: Colors.white),
                                                labelStyle: TextStyle(color: Colors.white),
                                      ),
                                      validator: (value){
                                        if (value == null || value.isEmpty){
                                          return 'Ingresa tu nombre';
                                        }
                                        return null;
                                      },
                                      style:const TextStyle(color: Colors.white),
                                    ),
                                    TextFormField(
                                      controller: _surnameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Apellido',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintStyle: TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(color: Colors.white),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingresa tu apellido';
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintStyle: TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(color: Colors.white),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingrese su correo electronico';
                                        } else if (!_isEmail(value)) {
                                          return 'Ingrese un correo electronico valido';
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    TextFormField(
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        labelText: 'Contraseña',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintStyle: TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(color: Colors.white),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingrese su contraseña';
                                        } else if (value.length < 4) {
                                          return 'La contraseña debe tener al menos 4 caracteres';
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    TextFormField(
                                      controller: _confirmPasswordController,
                                      decoration: const InputDecoration(
                                        labelText: 'Confirmar contraseña',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:BorderSide(color: Colors.white),
                                        ),
                                        hintStyle: TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(color: Colors.white),
                                      ),
                                      validator: (value) {
                                        if (value != _passwordController.text) {
                                          return 'Las contraseñas no coinciden';
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()){
                                          try{
                                              ((await _auth.createUserWithEmailAndPassword( //It was necessary to add parentheses to ensure correct assignment
                                                email: _emailController.text.trim(),
                                                password: _passwordController.text.trim()
                                              )).user as User).updateDisplayName("${_nameController.text.trim()} ${_surnameController.text.trim()}");
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuario registrado exitosamente')));
                                          }catch(e){
                                            // ignore: avoid_print
                                            print(e.toString());
                                            String errorMessage;
                                            if (e is FirebaseAuthException && e.code == 'weak-password'){
                                              errorMessage = 'La contraseña proporcionada es muy débil.';
                                            }else if (e is FirebaseAuthException && e.code == 'email-already-in-use'){
                                              errorMessage = 'La cuenta ya existe para ese correo.';
                                            }else{
                                              errorMessage = 'Error desconocido';
                                            }
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
                                          }
                                        }
                                      },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.blue.shade900,
                                    ),
                                      child: const Text('Sign up'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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