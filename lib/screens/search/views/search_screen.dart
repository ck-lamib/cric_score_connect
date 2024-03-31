import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "/search-screen";
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(),
      ),
    );
  }
}
