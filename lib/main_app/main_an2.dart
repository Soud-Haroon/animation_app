// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:animation_app/main_app/main_an3.dart';
import 'package:flutter/material.dart';

int _counter = 0;

class MainSecondPage extends StatefulWidget {
  const MainSecondPage({Key? key}) : super(key: key);

  @override
  State<MainSecondPage> createState() => _MainSecondPageState();
}

class _MainSecondPageState extends State<MainSecondPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  final double maxSlide = 225.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void toggle() {
    _animationController!.isDismissed
        ? _animationController!.forward()
        : _animationController!.reverse();
  }

  void toggleDrawable() {}

  @override
  Widget build(BuildContext context) {
    var behindScreen = _MainBackScreen();
    var myChild = _DrawableScreen();
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        // onTap: toggle,
        child: AnimatedBuilder(
          animation: _animationController!,
          builder: (context, _) {
            double slide = maxSlide * _animationController!.value;
            double scale = 1 - (_animationController!.value * 0.3);
            return Stack(children: [
              // myChild,
              Transform.translate(
                offset: Offset(maxSlide * _animationController!.value, 0),
                child: Transform(
                  origin: Offset(-5,-15),
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-pi  * _animationController!.value / 2),
                    alignment: Alignment.centerLeft,
                    child: myChild),
              ),
              Transform.translate(
                offset: Offset(maxSlide * (_animationController!.value - 1), 0),
                child: Transform(
                  origin: Offset(-190,20),
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(pi / 2 * (1 - _animationController!.value)),
                    alignment: Alignment.centerRight,
                    child: behindScreen),
              ),
            ]);
          },
        ),
      ),
    );
  }

  //====================Void==========================//
  bool _canBeDragged = true;
  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft =
        _animationController!.isDismissed && details.globalPosition.dx < 200;
    bool isDragOpenFromRight =
        _animationController!.isCompleted && details.globalPosition.dx > 0;
    //============================================================//
    _canBeDragged = isDragOpenFromLeft || isDragOpenFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController!.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController!.isDismissed ||
        _animationController!.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController!.fling(velocity: visualVelocity);
    } else if (_animationController!.value < 0.5) {
      Icons.close;
    } else {
      Icons.star;
    }
  }
  // onHorizontalDragStart: _onDragStart,
  //     onHorizontalDragUpdate: _onDragUpdate,
  //     onHorizontalDragEnd: _onDragEnd,

}

//=================================================//
class _MainBackScreen extends StatelessWidget {
  const _MainBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.only(left: 10, top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 215,
              child: Text('Flutter Europe',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: Colors.white)),
            ),
            //=========================================//
            menuList('News', Icon(Icons.new_releases_sharp, color: Colors.white)),
            menuList('Favourites', Icon(Icons.star, color: Colors.white)),
            menuList('Map', Icon(Icons.map, color: Colors.white)),
            menuList('Settings', Icon(Icons.settings, color: Colors.white)),
            menuList('Profile', Icon(Icons.person, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Padding menuList(String text, Icon myIcon) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        myIcon,
        SizedBox(width: 5),
        Text(text, style: TextStyle(color: Colors.white)),
      ]),
    );
  }
}

//=================================================//
class _DrawableScreen extends StatelessWidget {
  _DrawableScreen({Key? key}) : super(key: key);
  // AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // toggle(animationController);
            }),
        centerTitle: true,
        title: Text('Flutter Demo 2 Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                    Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MainThirdPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // static toggle(AnimationController animationController) {
  //   animationController.isDismissed
  //       ? animationController.forward()
  //       : animationController.reverse();
  // }
}
