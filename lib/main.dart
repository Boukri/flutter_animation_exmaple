import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var isSelected = false;
  var alignSelected = false;
  var opacitySelected = false;
  var posistionedSelected = false;
  var decorationSelected = false;

  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(style: BorderStyle.none),
      borderRadius: BorderRadius.circular(60.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66666666),
          blurRadius: 10.0,
          spreadRadius: 3.0,
          offset: Offset(0, 6.0),
        ),
      ],
    ),
    end: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.zero,
    ),
  );
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: AnimatedContainer(
                decoration: BoxDecoration(
                    color: isSelected ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.circular(isSelected ? 0 : 100)),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInCubic,
                width: isSelected ? 200 : 90,
                height: isSelected ? 300 : 90,
              ),
            ),
            MaterialButton(
              child: Text('Animated conatainer'),
              onPressed: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
            ),
            Center(
              child: Container(
                width: 250.0,
                height: 250.0,
                color: Colors.red,
                child: AnimatedAlign(
                  alignment: alignSelected
                      ? Alignment.topRight
                      : Alignment.bottomRight,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: const FlutterLogo(size: 50.0),
                ),
              ),
            ),
            MaterialButton(
              child: Text('Animated Align'),
              onPressed: () {
                setState(() {
                  alignSelected = !alignSelected;
                });
              },
            ),
            AnimatedOpacity(
              opacity: opacitySelected ? 1 : 0,
              duration: const Duration(seconds: 3),
              child: const FlutterLogo(
                size: 100,
              ),
            ),
            MaterialButton(
              child: Text('Animated Opacity'),
              onPressed: () {
                setState(() {
                  opacitySelected = !opacitySelected;
                });
              },
            ),
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    width: 50.0,
                    height: 50.0,
                    right: posistionedSelected ? 50.0 : 250.0,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: const ColoredBox(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              child: Text('Animated Positioned'),
              onPressed: () {
                setState(() {
                  posistionedSelected = !posistionedSelected;
                });
              },
            ),
            ColoredBox(
              color: Colors.white,
              child: Center(
                child: DecoratedBoxTransition(
                  decoration: decorationTween.animate(_controller),
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(10),
                    child: const FlutterLogo(),
                  ),
                ),
              ),
            ),
            MaterialButton(
              child: Text('Animated Decoration'),
              onPressed: () {
                setState(() {
                  decorationSelected = !decorationSelected;
                  if (decorationSelected) {
                    _controller.forward();
                  } else {
                    _controller.animateBack(0);
                  }
                });
              },
            ),
            Hero(
              tag: 'logo',
              child: FlutterLogo(
                size: 50,
              ),
            ),
            MaterialButton(
              child: Text('Hero Animation'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecoundScreen(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecoundScreen extends StatelessWidget {
  const SecoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
            tag: 'logo',
            child: FlutterLogo(
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
