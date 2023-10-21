import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/only_mobile_app/only_mobile_app.dart';

class ButtonAlertOnlyWeb extends StatefulWidget {
  const ButtonAlertOnlyWeb({super.key});

  @override
  State<ButtonAlertOnlyWeb> createState() => _ButtonAlertOnlyWebState();
}

class _ButtonAlertOnlyWebState extends State<ButtonAlertOnlyWeb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 3,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 2,
      ),
    ]).animate(_controller);

    _opacityAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Libera los recursos del controlador cuando no se necesite
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FadeTransition(
        opacity: _opacityAnimation,
        child: const Icon(
          Icons.warning_sharp,
          color: Colors.orange,
        ),
      ),
      tooltip: "Información importante",
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const OnlyMobileApp();
          },
        );
      },
    );
  }
}
