import 'package:flutter/material.dart';
import 'package:holter_app/screens/profile.dart';

class HealtMonitoringPage extends StatelessWidget {
  const HealtMonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Monitor De Salud',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade400,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(image: AssetImage('lib/images/Heart_holter.png')),
        ),
        actions: [
          Row(
            children: [
              const Text('Perfil', style: TextStyle(color: Colors.white,fontSize: 20)),
              IconButton(
                icon: const Icon(Icons.account_circle,size: 40,color: Colors.white,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade900],
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hola Santiago',
                style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Mientras estás siendo monitoreado por un Holter, es importante mantener un seguimiento preciso de tus actividades y síntomas durante la prueba. Si experimentas síntomas como dolor en el pecho, dificultad para respirar, látidos irregulares o mareos, anota en tu diario la hora en que comenzaron y lo que estabas haciendo. Tu diario se comparará con los cambios en tu electrocardiograma (ECG) registrado por el monitor Holter.\n\nRecuerda que tu médico necesita una imagen completa de tus actividades. Si tienes dudas, anótalas. Utiliza el siguiente diario para registrar todas tus actividades diarias:',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.white,fontSize: 20),
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 10,
                    horizontalMargin: 0,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Actividades',
                          style: TextStyle(fontStyle: FontStyle.italic, color:Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Sintomas',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Dia',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Hora',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      dataRow(),
                      dataRow(),
                      dataRow(),
                      dataRow(),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade900,
                  ),
                  child: const Text('Guardar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow dataRow() {
    return DataRow(
      cells: <DataCell>[
        dataCell(100),
        dataCell(150),
        dataCell(80),
        dataCell(80),
      ],
    );
  }

  DataCell dataCell(double width) {
    return DataCell(
      SizedBox(
        width: width,
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}