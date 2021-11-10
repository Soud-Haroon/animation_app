// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

int _counter = 0;

class MainThirdPage extends StatefulWidget {
  const MainThirdPage({Key? key}) : super(key: key);

  @override
  State<MainThirdPage> createState() => _MainThirdPageState();
}

class _MainThirdPageState extends State<MainThirdPage>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        // centerTitle: true,
        // title: Text('Flutter Third Page'),
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: SafeArea(
          child: Stack(children: [
            ArrowIcons(),
            Plane(),
            Line(),
          ]),
        ),
      ),
    );
  }

//=======================================//
  BoxDecoration backgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(colors: [
        Colors.blue.shade800,
        Colors.deepPurple.shade700,
        Colors.deepPurple
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    );
  }
}

//==================================================//
class ArrowIcons extends StatelessWidget {
  const ArrowIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 15,
      child: Column(children: [
        Icon(Icons.arrow_upward, size: 30, color: Colors.white),
        SizedBox(height: 15),
        Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: Icon(
              Icons.arrow_downward,
              size: 30,
              color: Colors.deepPurple,
            )),
      ]),
    );
  }
}
//-------------------------------------------------//
class Plane extends StatelessWidget {
  const Plane({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      left: 65,
      top: 5,
      child: RotatedBox(
        quarterTurns: 2,
        child: Icon(Icons.airplanemode_active, size: 64,color: Colors.white,)),
    );
  }
}
//--------------------------------------------------//
class Line extends StatelessWidget {
  const Line({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      left: 65 + 32,
      top: 20,
      bottom: 30,
      width: 1,
      child: Container(color: Colors.white.withOpacity(0.5)),
    );
  }
}
//--------------------------------------------------//
class Page extends StatelessWidget {
  const Page({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      left: 65 + 32,
      top: 20,
      bottom: 30,
      width: 1,
      child: Container(color: Colors.white.withOpacity(0.2)),
    );
  }
}
//====================Void==========================//

// AnimatedBuilder(
//         animation: _animationController!,
//         builder: (context, _) {
//           double slide = maxSlide * _animationController!.value;
//           double scale = 1 - (_animationController!.value * 0.3);
//           return Stack(children: [
//             behindScreen,
//             Transform(
//                 transform: Matrix4.identity()
//                   ..translate(slide)
//                   ..scale(scale),
//                 alignment: Alignment.centerLeft,
//                 child: myChild),
//           ]);
//         },
//       ),
//=================================================//
