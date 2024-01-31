import 'package:flutter/material.dart';
import 'package:holter_app/screens/main_screen.dart';
import 'package:holter_app/screens/forgot_password.dart';
import 'package:holter_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  

@override
LoginSCreenState createState() => LoginSCreenState();
}

class LoginSCreenState extends State<LoginScreen>{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void iniciarSesion(){
      String email = emailController.text;
      String password = passwordController.text;

      if(email.isEmpty || password.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:   Text('Por favor complete los campos.'))
        );
      }else if (email == 'admin' && password == 'admin') {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const HealtMonitoringPage()),
        );
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:   Text('Email o contraseña no valida.'))
        );
      }

  }
  
  void forgotPassword(){
    Navigator.push(
      context,MaterialPageRoute(builder:(context) => ForgotPasswordScreen()),
    );
  }

  void register(){
    Navigator.push(
      context,
      MaterialPageRoute(builder:(context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container (
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin:Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade900,
            ],
          ),
        ),
        child:Center(
          child:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('lib/images/Heart_holter.png',height: 150,),
          const SizedBox(height: 20.0,),
          const Text(
            'Iniciar Sesion',
            style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold,color:Colors.white,),
          ),
          const SizedBox(height: 20.0,),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration:  InputDecoration(
              labelText: 'Email',
              hintText: 'Ejemplo@gmail.com',
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15.0,),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30.0,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: iniciarSesion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Iniciar Sesion'),
          ),
        ),
        const SizedBox(height: 10.0),
        TextButton(
          onPressed: forgotPassword,
          child: const Text('Olvidaste la constraseña?',
            style: TextStyle(color:Colors.white)
          ),
        ),
        const SizedBox(height: 10.0),
        TextButton(
          onPressed: register,
          child: const Text('Registrate',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton.icon(
          onPressed: (){},
            icon: const Icon(Icons.login_rounded),
            label: const Text('Iniciar Sesion con Google'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              )
            ),
        )
        ],
      ),
    ),
  ),
  ),
  );
  }
}