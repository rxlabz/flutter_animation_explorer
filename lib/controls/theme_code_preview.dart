import 'package:flutter/material.dart';

import '../utils/syntax_highlighter_style.dart';

class ThemeCodePreview extends StatelessWidget {
  final String code;

  const ThemeCodePreview(this.code, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SyntaxHighlighterStyle style =
        SyntaxHighlighterStyle.panacheThemeStyle();
    /*Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();*/

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.blueGrey.shade800)),
          color: Colors.blueGrey.shade900),
      padding: EdgeInsets.only(top: 24, left: 24),
      child: SingleChildScrollView(
        child: RichText(
          text: TextSpan(
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
              children: <TextSpan>[DartSyntaxHighlighter(style).format(code)]),
        ),
      ),
    );
  }
}
