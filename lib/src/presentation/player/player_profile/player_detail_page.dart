import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ProfilePage1 extends StatefulWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  _ProfilePage1 createState() => _ProfilePage1();
}

class _ProfilePage1 extends State<ProfilePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar ficha", textAlign: TextAlign.center,),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          /*const Expanded(
              flex: 2,
              child: _TopPortion()
          ),*/
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                      child: MyCustomForm()
                  ),
                  Container(
                      child: Container(
                        margin: new EdgeInsets.all(30.0),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          gradient: const LinearGradient(colors: [
                            Color(0xFF0EDED2),
                            Color(0xFF03A0FE),
                          ],
                              begin: Alignment.topLeft, end: Alignment.bottomRight),
                        ),
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: const Text("Guardar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.topCenter,//Alignment.bottomCenter,
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blueAccent, Colors.blueGrey]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 170.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 100.0,
                        icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 300.0,
                              child: Icon(
                                Icons.add_a_photo,
                                size: 80.0,
                                color: Colors.blueAccent,
                              ),
                            ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
          ),
        ),
      ],
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    var items = [
      'Portero',
      'Delantero',
      'Defensa',
      'Medio Centro',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nombre',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Edad',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Estatura',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: DropdownButtonFormField(
            isExpanded: true,
            hint: const Text('Selecciona una posición'),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (value) {  },
          ),
        )
      ],
    );
  }
}