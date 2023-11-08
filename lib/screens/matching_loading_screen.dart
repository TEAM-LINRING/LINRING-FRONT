import 'package:flutter/material.dart';

class MatchingLoadingScreen extends StatefulWidget {
  const MatchingLoadingScreen({super.key});

  @override
  State<MatchingLoadingScreen> createState() => _MatchingLoadingScreenState();
}

class _MatchingLoadingScreenState extends State<MatchingLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loading_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loading.gif'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
