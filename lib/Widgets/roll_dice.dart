import 'dart:math';

import 'package:flutter/material.dart';

class RollDice extends StatefulWidget {
  const RollDice({super.key});

  @override
  State<RollDice> createState() => _RollDiceState();
}

class _RollDiceState extends State<RollDice> with TickerProviderStateMixin {
  late AnimationController animated; // Controller for animations
  late Animation<double> gridFadeTransition; // Fade animation
  late Animation<Offset> gridSlideAnimate; // Slide animation
  late Animation<double>
      rotationAnimation; // Rotation animation // Rotation animation
  int _diceNumber = 1;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    animated = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Fade animation
    gridFadeTransition = Tween(begin: 0.0, end: 1.0).animate(animated);

    // Slide animation
    gridSlideAnimate = Tween<Offset>(
      begin: const Offset(0, -1), // Start from off-screen (top)
      end: Offset.zero, // Slide into place
    ).animate(CurvedAnimation(
      parent: animated,
      curve: Curves.easeInOut,
    ));

    // Rotation animation
    rotationAnimation = Tween(begin: 0.0, end: 2 * pi).animate(animated);

    animated.forward();
  }

  @override
  void dispose() {
    animated.dispose();
    super.dispose();
  }

  void _rollDice() {
    setState(() {
      _diceNumber = Random().nextInt(6) + 1;
      animated.reset();
      animated.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FadeTransition(
                opacity: gridFadeTransition,
                child: SlideTransition(
                  position: gridSlideAnimate,
                  child: RotationTransition(
                    turns: rotationAnimation,
                    child: Container(
                      height: screenHeight * 0.2,
                      width: screenWidth * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/images/dice-$_diceNumber.png",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _rollDice();
              },
              child: const Text("Dice Roll"),
            ),
          ],
        ),
      ],
    );
  }
}
