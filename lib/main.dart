import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    controller.forward();
    return MaterialApp(
        title: 'GameList', theme: ThemeData(primarySwatch: Colors.blue,),
        home: MyHomePage(title: 'GameList', animation: animation,)
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title, this.animation}): super(key: key);
  final String title;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Game Listing")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            FadeTransition(
                child: ProductBox(
                    name: "DOOM Eternal",
                    description: "Doom Eternal is a first-person shooter video game developed by id Software and published by Bethesda Softworks. The sequel to Doom",
                    price: 1000,
                    image: "doom.jpg"
                ),
                opacity: animation
            ),
            MyAnimatedWidget(
                child: ProductBox(
                    name: "Resident Evil 3",
                    description: "Resident Evil 3 is a survival horror game developed and published by Capcom. It is a remake of Resident Evil 3: Nemesis and follows Jill Valentine and Carlos",
                    price: 800,
                    image: "residentevil.jpg"
                ),
                animation: animation
            ),
            ProductBox(
                name: "Marvel's Avengers",
                description: "Marvel's Avengers is an upcoming action-adventure video game developed by Crystal Dynamics and Eidos Montréal and published by Square Enix",
                price: 2000,
                image: "avenger.jpg"
            ),
            ProductBox(
                name: "Cyberpunk 2077",
                description: "Cyberpunk 2077 is an upcoming role-playing video game developed and published by CD Projekt.",
                price: 1500,
                image: "cyberpunk.jpg"
            ),
            ProductBox(
                name: "Cloudpunk",
                description: "A neon-noir story in a rain-drenched cyberpunk metropolis. It's your first night on the job working for the Cloudpunk delivery service",
                price: 100,
                image: "cloudpunk.jpg"
            ),
            ProductBox(
                name: "DOOM Eternal",
                description: "Doom Eternal is a first-person shooter video game developed by id Software and published by Bethesda Softworks.",
                price: 1000,
                image: "doom.jpg"
            ),
          ],
        )
    );
  }
}
class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.name, this.description, this.price, this.image}) :
        super(key: key);
  final String name;
  final String description;
  final int price;
  final String image;
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset("assets/" + image, height: 100,width: 100),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                  this.name, style: TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                              ),
                              Text(this.description), Text(
                                  "Price: " + this.price.toString()
                              ),
                            ],
                          )
                      )
                  )
                ]
            )
        )
    );
  }
}
class MyAnimatedWidget extends StatelessWidget {
  MyAnimatedWidget({this.child, this.animation});
  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
    child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Container(
          child: Opacity(opacity: animation.value, child: child),
        ),
        child: child
    ),
  );
}
