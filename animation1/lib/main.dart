import 'package:flutter/material.dart';
import 'dart:math' show pi;
void main() {
 runApp(MaterialApp(
  title: 'Flutter Demo',
  theme: ThemeData(
   colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 0, 13)),
   useMaterial3: true,
  ),
  home: const HomePage(),
 ));
}

class HomePage extends StatefulWidget {
 const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 0.0, end: 2*pi).animate(_controller);
    _controller.repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
 @override
 Widget build(BuildContext context) {
  return Scaffold(
    body: Center(child: AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(_animation.value),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]
            ),
            ),
      );
      },
    ),
        ),
  );
 }
}