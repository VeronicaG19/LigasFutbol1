import 'dart:convert';

import 'package:flutter/material.dart';

class CardSelection extends StatelessWidget {
  final String teamName;
  final String imageTeam;
  final bool isSelected;

  const CardSelection(
      {super.key,
      required this.teamName,
      required this.imageTeam,
      required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 3.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[100],
              backgroundImage: (imageTeam != '')
                  ? Image.memory(base64Decode(imageTeam)).image
                  : const AssetImage('assets/images/equipo2.png')),
          Text(
            teamName,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 12,
                fontWeight: FontWeight.w900),
          ),
          isSelected
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.circle,
                      color: Colors.grey,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
