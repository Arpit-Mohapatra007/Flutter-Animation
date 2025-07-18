import 'package:flutter/material.dart';

void main() {
 runApp(
  const App()
 );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const HomePage(),
    );
  }
}
class AnimatedPrompt extends StatefulWidget {
  final String title;
  final String subTitle;
  final Widget child;

  const AnimatedPrompt({super.key, required this.title, required this.subTitle, required this.child});

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _containerScaleAnimation;
  late Animation<Offset> _yDisplacementAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 1));
    _yDisplacementAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset(0, -0.23),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _iconScaleAnimation = Tween<double>(
      begin: 7,
      end: 6
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _containerScaleAnimation = Tween<double>(
      begin: 2.0,
      end: 0.4, 
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _controller..reset()..forward();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow (
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )]
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 100,
            minWidth: 100,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            maxHeight: MediaQuery.of(context).size.height * 0.8,),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height:160,
                      ),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.subTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Positioned.fill(
                  child: SlideTransition(
                    position: _yDisplacementAnimation,
                    child: ScaleTransition(
                      scale: _containerScaleAnimation,
                      child: Container(
                        decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        ),
                        child: ScaleTransition(
                          scale: _iconScaleAnimation,
                          child: widget.child,
                          ),
                      ),
                    ),
                  )
                )
              ],
            ),
            )
      ),
    );
  }
}
class HomePage extends StatelessWidget {
 const HomePage({super.key});

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: const Text('ICONS'),
   ),
   body: const Center(
    child: AnimatedPrompt(
      title: 'Thank you for your order!', 
      subTitle: 'Your order will be delivered in 2 days. Enjoy!', 
      child: Icon(
        Icons.check,
      )
      ),
   ),
  );
 }
}