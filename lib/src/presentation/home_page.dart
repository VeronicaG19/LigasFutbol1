import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/league/league_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/qa_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/slider_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/login/view/login_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/sign_up/sign_up.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/top_bar.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/button_share/button_share_widget.dart';

class HomePage extends StatefulWidget {
  static Page page() => const MaterialPage<void>(child: HomePage());
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return _HomePageMobile();
    } else {
      return _HomePageWeb();
    }
  }
}

class _HomePageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              'Ligas Fútbol',
              style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 28,
                  fontWeight: FontWeight.w900),
            ),
          ),
          backgroundColor: Colors.grey[200],
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar.png'),
            fit: BoxFit.fitWidth,
          ),
          actions: [
            const ButtonShareWidget(),
            TextButton(
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => route.isFirst);
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                decoration: const BoxDecoration(
                  color: Color(0xff740408),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ],
          elevation: 0.0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(110),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelColor: Colors.white70,
                        indicatorWeight: 1.0,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white38),
                        tabs: [
                          Tab(
                            height: 25,
                            iconMargin: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Inicio",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ),
                          Tab(
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Ligas",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ),
                          Tab(
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("QA",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )),
        ),
        body: Stack(
          children: [
            TabBarView(children: [
              //  ManageMembersPage(),
              Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 40, top: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '¡Ven y regístrate a Ligas fútbol!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Vive la experiencia como jugador, árbitro, etc, con una proyección profesional, "
                        "estamos convencidos que los mejores jugadores deben ser destacados, por eso creamos "
                        "la plataforma ideal donde podrás visualizar tus resultados, analizar a tu rival y"
                        " conocer tu próxima Sede.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 40),
                        child: SliderPage(),
                      ),
                      TextButton(
                        child: Text(
                          "¡Regístrate 𝐆𝐑𝐀𝐓𝐈𝐒 ahora!",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(
                            SignUpWizard.route(),
                          );
                        },
                      )
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(bottom: 40),
                child: LeaguePage(),
              ),
              const QAPage(),

              //   NotificationPage(),
            ]),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                  height: 40.0,
                  color: Colors.black87,
                  child: Center(
                    child: Text(
                      '¡Compártenos con tus amigos!',
                      style: TextStyle(color: Colors.grey[200], fontSize: 12),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePageWeb extends StatelessWidget {
  final double _scrollPosition = 0;
  double _opacity = 0;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(),
      ),
      //drawer: ExploreDrawer(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: SizedBox(
                    height: screenSize.height * 0.10,
                    width: screenSize.width,
                    child: Image.asset(
                      'assets/images/imageAppBar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          /*FeaturedHeading(
                            screenSize: screenSize,
                          ),
                          FeaturedTiles(screenSize: screenSize)*/
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
                padding: EdgeInsets.only(
                  top: screenSize.height / 20,
                  bottom: screenSize.height / 20,
                ),
                width: 600,
                // color: Colors.black,
                child: Column(
                  children: [
                    Text(
                      '¡Ven y regístrate a Ligas fútbol!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      "Vive la experiencia como jugador, árbitro, etc, con una proyección profesional, "
                      "estamos convencidos que los mejores jugadores deben ser destacados, por eso creamos "
                      "la plataforma ideal donde podrás visualizar tus resultados, analizar a tu rival y"
                      " conocer tu próxima Sede.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                )),
            SizedBox(height: screenSize.height / 55),
            SizedBox(
              width: 900,
              child: SliderPage(),
              height: 400,
            ),
            SizedBox(height: screenSize.height / 10),
          ],
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.white12,
      child: Column(
        children: [
          Divider(
            color: Colors.blueGrey,
          ),
          SizedBox(height: 20),
          Text(
            'Copyright © 2022 | Ligas futbol',
            style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
