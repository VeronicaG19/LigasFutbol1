import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.grey[200],
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0),
        children: [
          Card(
            color: Colors.grey[100],
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                    'https://e7.pngegg.com/pngimages/703/646/png-clipart-bar-chart-computer-icons-pie-chart-graphics-growth-icon-text-logo.png',
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50),
                Text(
                  '66.67%',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  'Goles',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 11,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  '1 de 6',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
          ),
          Card(
            color: Colors.grey[100],
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                    'https://e7.pngegg.com/pngimages/703/646/png-clipart-bar-chart-computer-icons-pie-chart-graphics-growth-icon-text-logo.png',
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50),
                Text(
                  '41%',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  'Tarjetas amarillas',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 11,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  '1 de 3',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
          ),
          Card(
            color: Colors.grey[100],
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                    'https://e7.pngegg.com/pngimages/703/646/png-clipart-bar-chart-computer-icons-pie-chart-graphics-growth-icon-text-logo.png',
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50),
                Text(
                  '12%',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  'Tarjetas Rojas',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 11,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  '0 de 1',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
