import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget{
  ForgotPasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Olvide mi contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Restablece tu contraseña',
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Por favor ingrese su correo electronico';
                }
                if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                  return 'Por favor ingrese un correo electronico valido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                if (_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing data')),
                  );
                }
              },
              child: const Text('Enviar link de restablecimiento'),
            )
          ],
        )
      ),
    );
  }
}