import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // Check if user has active session and navigate to app
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Row()),
    body: SingleChildScrollView(),
  );
}
