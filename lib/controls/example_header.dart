import 'package:flutter/material.dart';

class ExampleHeader extends StatelessWidget {
  final String title;

  final String description;

  const ExampleHeader({Key key, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onMobile = MediaQuery.of(context).size.shortestSide <= 640;
    final textTheme = Theme.of(context).textTheme;
    final double padding = onMobile ? 8 : 16;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Text.rich(TextSpan(
          text: '$title\n',
          style: onMobile ? textTheme.headline : textTheme.display1,
          children: [TextSpan(text: description, style: textTheme.body1)])),
    );
  }
}
