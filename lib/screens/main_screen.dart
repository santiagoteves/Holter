import 'package:flutter/material.dart';
import 'package:holter_app/screens/profile.dart';

class HealtMonitoringPage extends StatelessWidget{
  const HealtMonitoringPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor De Salud'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('lib/images/Heart_holter.png'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hola Santiago',
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Mientras estás siendo monitoreado por un Holter, es importante mantener un seguimiento preciso de tus actividades y síntomas durante la prueba. Si experimentas síntomas como dolor en el pecho, dificultad para respirar, látidos irregulares o mareos, anota en tu diario la hora en que comenzaron y lo que estabas haciendo. Tu diario se comparará con los cambios en tu electrocardiograma (ECG) registrado por el monitor Holter.\n\nRecuerda que tu médico necesita una imagen completa de tus actividades. Si tienes dudas, anótalas. Utiliza el siguiente diario para registrar todas tus actividades diarias:',
                textAlign: TextAlign.justify,
              ),
            ),
            DataTable(
              columns : const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Actividades',
                    style: TextStyle(fontStyle: FontStyle.italic ),
                    ),
                ),
                DataColumn(
                  label: Text(
                    'Sintomas',
                    style: TextStyle(fontStyle: FontStyle.italic ),
                    ),
                ),
                DataColumn(
                  label:Text(
                    'Dia',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Hora',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                ),
              ],
              rows: const <DataRow>[
                DataRow(cells: [
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                ]),
                DataRow(cells: [
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                ]),
                DataRow(cells: [
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                ]),
                DataRow(cells: [
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                ]),
                DataRow(cells: [
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                  DataCell(TextField()),
                ]),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: const Text('Guardar'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}