// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, unused_field, must_be_immutable
import 'package:flutter/material.dart';

int _counter = 0;
int num = 1;
String question = 'What is your name?';
List<String> myList = ['Hello', 'World'];

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
      body: Container(
        decoration: backgroundDecoration(),
        child: SafeArea(
          child: Stack(children: [
            ArrowIcons(),
            Plane(),
            Line(),
            Page(number: num,question: question,answer: [myList.toString()],),
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
  const Plane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 60,
      top: 10,
      child: RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.airplanemode_active,
            size: 64,
            color: Colors.white,
          )),
    );
  }
}

//--------------------------------------------------//
class Line extends StatelessWidget {
  const Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 60 + 32,
      top: 20,
      bottom: 30,
      width: 1,
      child: Container(color: Colors.white.withOpacity(0.5)),
    );
  }
}

//--------------------------------------------------//
class Page extends StatefulWidget {
  const Page(
      {this.number,
      this.answer,
      this.question,
      this.onOptionSelected,
      Key? key})
      : super(key: key);
  final int? number;
  final String? question;
  final List<String>? answer;
  final VoidCallback? onOptionSelected;
  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  List<GlobalKey<_ItemFaderState>>? keys;

  @override
  void initState() {
    super.initState();
    keys = List.generate(5, (_) => GlobalKey<_ItemFaderState>());
    onInit();
  }

  void onInit() async {
    for (GlobalKey<_ItemFaderState> key in keys!) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState!.show();
    }
  }

  void onTap() async {
    for (GlobalKey<_ItemFaderState> key in keys!) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState!.hide();
    }
    widget.onOptionSelected!();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 32),
        ItemFader(key: keys![0], child: StepNumber(number: widget.number)),
        ItemFader(
            key: keys![1], child: StepQuestion(question: widget.question)),
        Spacer(),
        ...widget.answer!.map((String answer) {
          return ItemFader(
              key: keys![2],
              child: OptionItem(
                name: answer,
                onTap: widget.onOptionSelected,
              ));
        }),
        SizedBox(height: 64),
      ],
    );
  }
}

class StepNumber extends StatelessWidget {
  StepNumber({Key? key, this.number}) : super(key: key);
  int? number;
  @override
  Widget build(BuildContext context) {
    return Text(number!.toString(), style: TextStyle(fontSize: 50, color: Colors.white));
  }
}

class StepQuestion extends StatelessWidget {
  StepQuestion({Key? key, this.question}) : super(key: key);
  String? question;
  @override
  Widget build(BuildContext context) {
    return Text(question!.toString(), style: TextStyle(fontSize: 15, color: Colors.white));
  }
}

//------------------------------------------------------//
class OptionItem extends StatefulWidget {
  const OptionItem({this.name, this.onTap, Key? key}) : super(key: key);
  final String? name;
  final VoidCallback? onTap;

  @override
  State<OptionItem> createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            SizedBox(width: 26),
            Dot(),
            SizedBox(width: 26),
            Expanded(child: Text(widget.name!))
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
      ),
    );
  }
}

//--------------------------------------------------//
class ItemFader extends StatefulWidget {
  const ItemFader({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  _ItemFaderState createState() => _ItemFaderState();
}

class _ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  double position = 1;
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation!,
        child: widget.child,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0.0, 64 * position * (1 - _animation!.value)),
            child: Opacity(
              opacity: _animation!.value,
              child: child,
            ),
          );
        });
  }

  void show() {
    setState(() {
      position = 1;
      _animationController!.forward();
    });
  }

  void hide() {
    setState(() {
      position = -1;
      _animationController!.reverse();
    });
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
