import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      /*appBar: AppBar(
        title: Text('Flutter animation explorer'),
      ),*/
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Flutter animations guide',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
              _buildCard(
                  label: 'Curves',
                  description:
                      'Visualize Flutter acceleration/deceleration curves',
                  asset: 'assets/curves_thumb.png',
                  textTheme: textTheme,
                  onTap: () => Navigator.of(context).pushNamed('curves')),
              _buildCard(
                  label: 'Animated widgets',
                  description: 'Discover the implicitly animated widgets',
                  asset: 'assets/animateds_thumb.png',
                  textTheme: textTheme,
                  onTap: () => Navigator.of(context).pushNamed('animateds')),
              _buildCard(
                  label: 'Staggered animations',
                  description: 'Explore a Flutter staggered animation',
                  asset: 'assets/staggered_thumb.png',
                  textTheme: textTheme,
                  onTap: () => Navigator.of(context).pushNamed('staggered')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    String label,
    String description,
    String asset,
    VoidCallback onTap,
    TextTheme textTheme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 300,
            /*height: 160,*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  asset,
                  width: 300,
                  /*height: 120,*/
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text.rich(
                    TextSpan(
                        text: '$label\n\n',
                        style: textTheme.subtitle,
                        children: [
                          TextSpan(text: description, style: textTheme.body1)
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
