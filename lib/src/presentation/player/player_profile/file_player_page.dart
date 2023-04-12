import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/player_profile/player_detail_page.dart';
import 'package:share_plus/share_plus.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ficha de jugador", textAlign: TextAlign.center,),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white24,
                child: Icon(
                  Icons.share,
                  size: 18,
                  color: Colors.white,
                )),
            onPressed: () async {
              final box = context.findRenderObject() as RenderBox?;
              await Share.share(
                  '¡Ven y regístrate a Ligas fútbol!\n'
                      'Vive la experiencia como jugador, árbitro, etc, con una proyección profesional.'
                      ' En ligas fútbol tenemos las mejores ligas de la zona, no te quedes'
                      ' afuera y vive la experiencia.\n\n'
                      '¡Regístrate 𝐆𝐑𝐀𝐓𝐈𝐒 ahora!',
                  subject: '¡Regístrate 𝐆𝐑𝐀𝐓𝐈𝐒 ahora!',
                  sharePositionOrigin:
                  box!.localToGlobal(Offset.zero) & box.size);
            },
          ),
        ],
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blueAccent, Colors.blueGrey]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 260.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 100.0,
                          icon: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://s3.amazonaws.com/lmxwebsite/media/wpagephotos/73/1/69018/69018.jpg",
                            ),
                            radius: 50.0,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12.0,
                                child: Icon(
                                  Icons.edit,
                                  size: 15.0,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage1()),
                          );
                        },
                      ),
                      const Text(
                        "Angel Ucan",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    const Text(
                                      "Edad",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    const Text(
                                      "26 Años",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.blueGrey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    const Text(
                                      "Estatura",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    const Text(
                                      "1.62 Cm",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.blueGrey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: const <Widget>[
                                    Text(
                                      "Posición",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      "Delantero",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.blueGrey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Equipos",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.normal,
                        fontSize: 25.0
                    ),
                  ),
                  const SizedBox(
                    height: 0.0,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: 350.00,
            child: Row(
              children: [
                Column(
                  children: [
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzdCFkv0SI2S0HXYtDJHdyH4LSeboF_GAKwU7pEprDPPubnkYuKimKD7FXtZF59_rFhd0&usqp=CAU',
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                    const Text(
                      'México',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Liga de fútbol rapido',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Categoria Juvenil Mixta',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Fecha de inscripción: 19/10/22',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Status: ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        const Text(
                          'Activo',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 13,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}