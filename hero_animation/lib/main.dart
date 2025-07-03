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

@immutable
class Person{
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const people = [
  Person(name: 'John', age: 30, emoji: '🫨'),
  Person(name: 'Bob', age: 28, emoji: '🤗'),
  Person(name: 'Alice', age: 25, emoji: '😉'),
];

class HomePage extends StatelessWidget {
 const HomePage({super.key});

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: const Text('People',),
   ),
   body: ListView.builder(
    itemCount: people.length,
    itemBuilder: (context, index) {
      final person = people[index];
     return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context)=>DetailsPage(
              person: person
              )
              )
        );
      },
      leading: Hero(
        tag: person.name,
        child: Text(
          person.emoji,
          style: const TextStyle(
            fontSize: 40),
            ),
      ),
      title: Text(person.name),
      subtitle: Text('${person.age} years old'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
   );
   }
  )
  );
 }
}

class DetailsPage extends StatelessWidget {

  final Person person;

  const DetailsPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
            switch(flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent, 
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                        ).chain(
                          CurveTween(
                            curve: Curves.fastOutSlowIn
                            )
                        ),
                    ),
                    child: toHeroContext.widget
                    )
                    );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: fromHeroContext.widget
                  );
            }
          },
          tag: person.name,
          child: Text(
            person.emoji,
            style: TextStyle(fontSize: 50),
            ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(person.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              ),
                ),
                const SizedBox(height: 20),
                Text('${person.age} years old',
              style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              ),
                ),
          ],
        ),
      )
    );
  }
}