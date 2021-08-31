import 'package:flutter/material.dart';

class AppShortcut extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final VoidCallback onTap;
  const AppShortcut({
    Key? key,
    required this.title,
    required this.content,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width / 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: width / 33),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTap(),
                  child: Container(
                    height: width / 10,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          left: width / 20,
                          child: Text(
                            content,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          right: width / 20,
                          width: width / 10,
                          height: width / 10,
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: width / 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
