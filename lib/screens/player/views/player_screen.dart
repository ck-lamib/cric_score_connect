import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  static const String routeName = "/player-screen";
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(),
      ),
    );
  }
}
