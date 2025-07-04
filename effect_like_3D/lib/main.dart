import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

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

const widthAndHeigth = 100.0;

class HomePage extends StatefulWidget {
 const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
    late AnimationController _xController;
    late AnimationController _yController;
    late AnimationController _zController;
    late Tween<double> _animation;

    @override
  void initState() {
    super.initState();
    _xController = AnimationController(vsync: this,duration: const Duration(seconds: 20));
    _yController = AnimationController(vsync: this,duration: const Duration(seconds: 30));
    _zController = AnimationController(vsync: this,duration: const Duration(seconds: 40));
    _animation = Tween<double>(begin: 0,end: pi*2,);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

 @override
 Widget build(BuildContext context) {
    _xController..reset()..repeat();
    _yController..reset()..repeat();
    _zController..reset()..repeat();

  return Scaffold(
   body: SafeArea(
     child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         const SizedBox(
          height: 100,
          width: double.infinity,
         ), 
         AnimatedBuilder(
            animation: Listenable.merge([_xController,_yController,_zController]),
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                ..rotateY(_animation.evaluate(_yController))
                ..rotateX(_animation.evaluate(_xController))
                ..rotateZ(_animation.evaluate(_zController)),
                child: Stack(children: [
                    //back
                Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..translate(Vector3(0,0, -widthAndHeigth)),
                  child: Container(
                      color: Colors.purple,
                      width: widthAndHeigth,
                      height: widthAndHeigth,
                  ),
                ),
                //left side
                Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()..rotateY(pi/2.0),
                  child: Container(
                      color: Colors.red,
                      width: widthAndHeigth,
                      height: widthAndHeigth,
                  ),
                ),
                //right side
                Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()..rotateY(-pi/2.0),
                  child: Container(
                      color: Colors.blue,
                      width: widthAndHeigth,
                      height: widthAndHeigth,
                  ),
                ),
                    //front
                Container(
                    color: Colors.green,
                    width: widthAndHeigth,
                    height: widthAndHeigth,
                ),
                //top
                Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()..rotateX(-pi/2.0),
                  child: Container(
                      color: Colors.orange,
                      width: widthAndHeigth,
                      height: widthAndHeigth,
                  ),
                ),
                //bottom
                Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..rotateX(pi/2.0),
                  child: Container(
                      color: Colors.brown,
                      width: widthAndHeigth,
                      height: widthAndHeigth,
                  ),
                ),
            ],
                    ),
              );
            },
         ),
       ],
     ),
   )
   );
 }
}