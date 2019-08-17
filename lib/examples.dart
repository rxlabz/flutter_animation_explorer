import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

const curve_example_code = '''
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: SafeArea(child: CurveExample()),
    ),
  ));
}

class CurveExample extends StatefulWidget {
  @override
  _CurveExampleState createState() => _CurveExampleState();
}

class _CurveExampleState extends State<CurveExample>
    with SingleTickerProviderStateMixin {
  final _durationMs = 600;

  final double _leftFrom = 0;
  final double _leftTo = 200;
  final double _topFrom = 0;
  final double _topTo = 100;
  final double _widthFrom = 20;
  final double _widthTo = 200;
  final double _heightFrom = 20;
  final double _heightTo = 50;

  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;
  Animation<double> _leftTween;
  Animation<double> _topTween;
  Animation<double> _widthTween;
  Animation<double> _heightTween;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: _durationMs), vsync: this);
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);
    _leftTween =
        Tween(begin: _leftFrom, end: _leftTo).animate(_curvedAnimation);
    _topTween = Tween(begin: _topFrom, end: _topTo).animate(_curvedAnimation);
    _widthTween =
        Tween(begin: _widthFrom, end: _widthTo).animate(_curvedAnimation);
    _heightTween =
        Tween(begin: _heightFrom, end: _heightTo).animate(_curvedAnimation);
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) {
        final currentLeft = _leftTween.value;
        final currentTop = _topTween.value;
        final currentWidth = _widthTween.value;
        final currentHeight = _heightTween.value;
        return Stack(
          children: <Widget>[
            Positioned(
              left: currentLeft,
              top: currentTop,
              child: Container(
                width: currentWidth,
                height: currentHeight,
                color: Colors.red,
              ),
            )
          ],
        );
      },
    );
  }
}''';

const animatedContainerExampleCode = '''
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: SafeArea(child: CurveExample()),
    ),
  ));
}

class CurveExample extends StatefulWidget {
  @override
  _CurveExampleState createState() => _CurveExampleState();
}

class _CurveExampleState extends State<CurveExample> {
  final _durationMs = 600;
  final _curve = Curves.bounceIn;
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final color = expanded ? Colors.green : Colors.blue;
    final double currentWidth = expanded ? 200 : 80;
    final double currentHeight = expanded ? 100 : 40;
    return Center(
      child: InkWell(
        onTap: () => setState(() => expanded = !expanded),
        child: AnimatedContainer(
          duration: aMillisecond * _durationMs,
          curve: _curve,
          color: color,
          width: currentWidth,
          height: currentHeight,
          child: Center(
              child: Text(
            'Click me',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          )),
        ),
      ),
    );
  }
}''';

const positionnedExample = '''
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: SafeArea(child: AlignExample()),
    ),
  ));
}

class AlignExample extends StatefulWidget {
  @override
  _AlignExampleState createState() => _AlignExampleState();
}

class _AlignExampleState extends State<AlignExample> {
  final _durationMs = 600;
  final _curve = Curves.bounceIn;
  bool on = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double currentLeft = on ? size.width - 100 : 0;

    final double currentTop = on ? size.height - 200 : 0;
    return Center(
      child: InkWell(
        onTap: () => setState(() => on = !on),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: aMillisecond * _durationMs,
              curve: _curve,
              left: currentLeft,
              top: currentTop,
              child: Container(
                color: Colors.purple,
                child: Text(
                  'Click me',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}''';

const alignExample = '''
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: SafeArea(child: AlignExample()),
    ),
  ));
}

class AlignExample extends StatefulWidget {
  @override
  _AlignExampleState createState() => _AlignExampleState();
}

class _AlignExampleState extends State<AlignExample> {
  final _durationMs = 600;
  final _curve = Curves.bounceIn;
  bool on = false;

  @override
  Widget build(BuildContext context) {
    final currentAlign = on ? Alignment.bottomCenter : Alignment.topLeft;

    return Center(
      child: InkWell(
        onTap: () => setState(() => on = !on),
        child: Stack(
          children: <Widget>[
            AnimatedAlign(
              duration: aMillisecond * _durationMs,
              curve: _curve,
              alignment: currentAlign,
              child: Container(
                color: Colors.deepOrangeAccent,
                child: Text(
                  'Click me',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}''';

const animatedTextExample = '''
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

void main() {
  runApp(MaterialApp(
    key: Key('AnimatedTextExample'),
    home: Scaffold(
      body: SafeArea(child: TextExample()),
    ),
  ));
}

class TextExample extends StatefulWidget {
  @override
  _AnimatedTextExampleState createState() => _AnimatedTextExampleState();
}

class _AnimatedTextExampleState extends State<TextExample>
    with SingleTickerProviderStateMixin {
  final _durationMs = 600;
  final _curve = Curves.linear;
  bool on = false;

  final TextStyle style1 = TextStyle(color: Colors.red, fontSize: 32);

  final TextStyle style2 =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final currentStyle = on ? style1 : style2;

    return Center(
      child: InkWell(
        onTap: () => setState(() => on = !on),
        child: Stack(
          children: <Widget>[
            AnimatedDefaultTextStyle(
              duration: aMillisecond * _durationMs,
              curve: _curve,
              style: currentStyle,
              child: Container(
                child: Text(
                  'Click me',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const animatedOpacityExample = '''
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

void main() {
  runApp(MaterialApp(
    key: Key('AnimatedOpacity'),
    home: Scaffold(
      body: SafeArea(child: TextExample()),
    ),
  ));
}

class TextExample extends StatefulWidget {
  @override
  _AnimatedTextExampleState createState() => _AnimatedTextExampleState();
}

class _AnimatedTextExampleState extends State<TextExample>
    with SingleTickerProviderStateMixin {
  final _durationMs = 600;
  final _curve = Curves.linear;
  bool on = false;

  @override
  Widget build(BuildContext context) {
    final currentOpacity = on ? 1.0 : .2;

    return Center(
      child: InkWell(
        onTap: () => setState(() => on = !on),
        child: AnimatedOpacity(
          duration: aMillisecond * _durationMs,
          curve: _curve,
          opacity: currentOpacity,
          child: Container(
            color: Colors.cyan.shade300,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Click me',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''';

const staggeredExample = '''
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

void main() {
  runApp(MaterialApp(
    key: Key('staggeredAnim'),
    home: Scaffold(
      body: SafeArea(child: TextExample()),
    ),
  ));
}

class TextExample extends StatefulWidget {
  @override
  _AnimatedTextExampleState createState() => _AnimatedTextExampleState();
}

class _AnimatedTextExampleState extends State<TextExample>
    with SingleTickerProviderStateMixin {
  final _curve = Curves.bounceIn;

  AnimationController animationController;

  Animation<double> widthTween;
  Animation<double> heightTween;
  Animation<Color> colorTween;

  @override
  void initState() {
    animationController = AnimationController(duration: aSecond, vsync: this);

    widthTween = Tween<double>(begin: 100, end: 240).animate(
      CurvedAnimation(
          parent: animationController, curve: Interval(0, .5, curve: _curve)),
    );

    heightTween = Tween<double>(begin: 50, end: 240).animate(
      CurvedAnimation(
          parent: animationController, curve: Interval(0.5, 1, curve: _curve)),
    );

    colorTween = ColorTween(begin: Colors.cyan, end: Colors.orange).animate(
      CurvedAnimation(
          parent: animationController, curve: Interval(1, 1, curve: _curve)),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => setState(() =>
            animationController.status == AnimationStatus.dismissed
                ? animationController.forward()
                : animationController.reverse()),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, widget) => Container(
            color: colorTween.value,
            width: widthTween.value,
            height: heightTween.value,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Click me',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''';
