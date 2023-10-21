import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoachmarkDesc extends StatefulWidget {
  const CoachmarkDesc(
      {super.key,
      required this.container,
      this.next = "Siguiente",
      this.onNext,
      this.skip = "Finalizar",
      this.onSkip});

  final Widget container;
  final String next;
  final String skip;
  final void Function()? onNext;
  final void Function()? onSkip;

  @override
  State<CoachmarkDesc> createState() => _CoachmarkDescState();
}

class _CoachmarkDescState extends State<CoachmarkDesc>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 20,
      duration: const Duration(milliseconds: 800),
    )..repeat(min: 0, max: 20, reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animationController.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.container,
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: widget.onSkip,
                  child: Text(widget.skip),
                ),
                ElevatedButton(
                  onPressed: widget.onNext,
                  child: Text(widget.next),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
