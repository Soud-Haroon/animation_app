// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animation_app/main_app/main_an2.dart';
import 'package:flutter/material.dart';

int _counter = 0;

class MainFirstPage extends StatefulWidget {
  const MainFirstPage({Key? key}) : super(key: key);

  @override
  State<MainFirstPage> createState() => _MainFirstPageState();
}

class _MainFirstPageState extends State<MainFirstPage>
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

  // void toggle() {
  //   _animationController!.isDismissed
  //       ? _animationController!.forward()
  //       : _animationController!.reverse();
  // }

  @override
  Widget build(BuildContext context) {
    var behindScreen = _MainBackScreen();
    var myChild = _DrawableScreen(
      animationController: _animationController!,
    );
    return Scaffold(
      backgroundColor: Colors.blue,
      body: AnimatedBuilder(
        animation: _animationController!,
        builder: (context, _) {
          double slide = maxSlide * _animationController!.value;
          double scale = 1 - (_animationController!.value * 0.3);
          return Stack(children: [
            behindScreen,
            Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: myChild),
          ]);
        },
      ),
    );
  }
  //====================Void==========================//

  // void _onDragStart(DragDownDetails details) {
  //   bool isDragOpenFromLeft = _animationController!.isDismissed &&
  //       details.globalPosition.dx < min;
  // }
  // onHorizontalDragStart: _onDragStart,
  //     onHorizontalDragUpdate: _onDragUpdate,
  //     onHorizontalDragEnd: _onDragEnd,

}

//=================================================//
class _MainBackScreen extends StatelessWidget {
  const _MainBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.only(left: 10, top: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Flutter Europe',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: Colors.white)),
          //=========================================//
          menuList('News', Icon(Icons.new_releases_sharp, color: Colors.white)),
          menuList('Favourites', Icon(Icons.star, color: Colors.white)),
          menuList('Map', Icon(Icons.map, color: Colors.white)),
          menuList('Settings', Icon(Icons.settings, color: Colors.white)),
          menuList('Profile', Icon(Icons.person, color: Colors.white)),
        ],
      ),
    );
  }

  Padding menuList(String text, Icon myIcon) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 30, right: 50),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        myIcon,
        Text(text, style: TextStyle(color: Colors.white)),
      ]),
    );
  }
}

//=================================================//
// ignore: must_be_immutable
class _DrawableScreen extends StatelessWidget {
  _DrawableScreen({required this.animationController, Key? key})
      : super(key: key);
  AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              toggle(animationController);
            }),
        centerTitle: true,
        title: Text('Flutter Demo Home Page'),
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
              .push(MaterialPageRoute(builder: (context) => MainSecondPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  static toggle(AnimationController animationController) {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }
}
