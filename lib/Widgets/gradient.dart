import 'package:flutter/material.dart';
import 'package:roll_dice_app/Widgets/roll_dice.dart';

class MyGradient extends StatelessWidget {
  const MyGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.pink],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: const RollDice(),
    );
  }
}
