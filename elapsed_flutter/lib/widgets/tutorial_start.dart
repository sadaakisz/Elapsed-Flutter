import 'package:flutter/material.dart';

class TutorialStart extends StatelessWidget {
  const TutorialStart({Key? key, required this.onDismiss}) : super(key: key);

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          right: width * 0.15,
          child: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              onDismiss();
            },
          ),
        ),
        Container(
          height: height * 0.57,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TutorialCard(
                leading: Icon(Icons.bolt, color: Colors.white54),
                title: 'QUICK ROUTINE',
                message:
                    'Want a no-brainer pomodoro timer? Create a quick routine by specifying your productive minutes and your break time.',
              ),
              TutorialDivider(),
              TutorialCard(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Container(
                    width: 35,
                    height: 35,
                    child: Image.asset(
                      'assets/TutorialDarkIcon.png',
                    ),
                  ),
                ),
                title: 'CUSTOM ROUTINE',
                message:
                    'Customizability? Explore all the options for your own pomodoro timer for all your activities!',
              ),
              TutorialDivider(),
              TutorialCard(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Icon(Icons.settings, color: Colors.white54),
                ),
                title: 'APP SETTINGS',
                message:
                    'Tweak ALL the corners of the app, from the background, to timer font size and everything in between.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TutorialCard extends StatelessWidget {
  final Widget leading;
  final String title;
  final String message;
  const TutorialCard(
      {Key? key,
      required this.leading,
      required this.title,
      required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: leading,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
          SizedBox(height: width / 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}

class TutorialDivider extends StatelessWidget {
  const TutorialDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Divider(
          color: Colors.white70,
          thickness: 0.5,
        ),
      ),
    );
  }
}
