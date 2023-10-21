import 'dart:convert';

import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  final String teamName;
  final String categoryName;
  final String representanName;
  final String imageTeam;
  final VoidCallback? onTap;

  const TeamCard(
      {super.key,
      required this.teamName,
      required this.categoryName,
      required this.representanName,
      required this.imageTeam,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: Colors.grey[100],
        elevation: 3.0,
        child: SizedBox(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[100],
                backgroundImage: (imageTeam != '')
                    ? Image.memory(base64Decode(imageTeam)).image
                    : Image.asset('assets/images/equipo2.png').image),
            Text(
              teamName,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12,
                  fontWeight: FontWeight.w900),
            ),
            Divider(),
            Text(
              categoryName,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            Text(
              representanName,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            Divider()
          ],
        )),
      ),
      onTap: () => onTap!(),
    );
  }
}
