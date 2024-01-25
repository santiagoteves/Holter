import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget{
  const ForgotPasswordScreen({super.key});

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
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
              },
              child: const Text('Enviar link de restablecimiento'),
            )
          ],
        )
      ),
    );
  }
}