import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sprites/flutter_sprites.dart';
import 'package:flutter/services.dart';

AssetBundle _initBundle() {
  if (rootBundle != null)
    return rootBundle;
  return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
}

final AssetBundle _bundle = _initBundle();

ImageMap _images;

Future _loadAssets(AssetBundle bundle) async {
  _images = new ImageMap(bundle);
  await _images.load(<String>[
    'assets/line.png',
  ]);
}

main() async {
  await _loadAssets(_bundle);

  runApp(
    new MaterialApp(
      title: 'Flutter Demo',
      routes: <String, RouteBuilder>{
        '/': (RouteArguments args) => new FlutterDemo()
      }
    )
  );
}

class FlutterDemo extends StatefulComponent {
  _FlutterDemoState createState() => new _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text('Flutter Demo')
      ),
      body: new SpriteWidget(new MyLineNode(), SpriteBoxTransformMode.nativePoints)
    );
  }
}

class MyLineNode extends NodeWithSize {
  EffectLine _line;

  MyLineNode() : super(Size.zero) {
    Texture lineTexture = new Texture(_images['assets/line.png']);

    _line = new EffectLine(texture: lineTexture, points: [const Point(5.0, 5.0)]);

    // _line = new EffectLine(
    //   texture: new Texture(_images['assets/line.png']),
    //   fadeDuration: 1.0,
    //   fadeAfterDelay: 1.0,
    //   colorSequence: new ColorSequence.fromStartAndEndColor(Colors.red[500], Colors.green[500])
    // );
    // addChild(_line);

    addChild(new CustomDraw());
  }
}

class CustomDraw extends Node {
  void paint(Canvas canvas) {
    canvas.drawCircle(Point.origin, 50.0, new Paint()..color = new Color(0xffff0000));
  }
}
