import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: EColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 14),
          child: Stack(
            children: [
              ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Text(
                      'APP SETTINGS',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(height: 8),
                  _Subtitle(subtitleText: 'General'),
                  _ColorOption(
                    colorText: 'Background Color',
                    displayColor: EColors.black,
                    hexText: '#1A1A1A',
                  ),
                  _ImageSelector(),
                  _Subtitle(subtitleText: 'Timer'),
                  _ColorOption(
                    colorText: 'Timer Font Color',
                    displayColor: Colors.white,
                    hexText: '#EEEEEE',
                  ),
                  _FontOption(selectedFont: 'Aldrich'),
                  _FontSizeOption(fontSize: '120'),
                  _ColorOption(
                    colorText: 'Quick Routine Accent Color',
                    displayColor: Colors.tealAccent.shade400,
                    hexText: '#2DDEBE',
                  ),
                  _Subtitle(subtitleText: 'Home page'),
                  _ColorOption(
                    colorText: 'Home Page Accent Color',
                    displayColor: EColors.green,
                    hexText: '#C0E8A1',
                  ),
                  SizedBox(height: 100),
                ],
              ),
              Positioned(
                width: width,
                height: 100,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [EColors.black, EColors.black.withOpacity(0)]),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                width: width * 6 / 7,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      transform: Matrix4.translationValues(-0.5, 0.0, 0.0),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: GestureDetector(
                        child: Icon(
                          Icons.delete_outline_outlined,
                          color: EColors.green,
                          size: 25,
                        ),
                        //TODO: Implement discard changes
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Center(
                            child: Text('SAVE',
                                style: Theme.of(context).textTheme.button),
                          ),
                        ),
                        //TODO: Implement Save changes
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  final String subtitleText;
  const _Subtitle({
    Key? key,
    required this.subtitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            subtitleText,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final String colorText;
  final Color displayColor;
  final String hexText;
  const _ColorOption({
    Key? key,
    required this.colorText,
    required this.displayColor,
    required this.hexText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            colorText,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              Flexible(
                flex: 9,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: displayColor,
                    border: Border.all(color: Colors.white38, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(width: 18),
              Flexible(
                flex: 5,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Text(
                      //TODO: Change text according to color selected
                      hexText,
                      style: Theme.of(context).textTheme.overline,
                    )
                  ],
                ),
              ),
              SizedBox(width: 18),
              GestureDetector(
                child: Icon(Icons.restart_alt),
                //TODO: Pass an event or VoidCallback
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageSelector extends StatelessWidget {
  const _ImageSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Background Image',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 12.0),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Positioned(
                left: 20,
                child: Text(
                  'Select photo from library',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.white),
                ),
              ),
              Positioned(
                right: 20,
                child: Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FontOption extends StatelessWidget {
  final String selectedFont;
  const _FontOption({
    Key? key,
    required this.selectedFont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Timer Font Family',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 12.0),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Positioned(
                left: 20,
                child: Text(
                  selectedFont,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                        fontFamily:
                            GoogleFonts.getFont(selectedFont).fontFamily,
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

class _FontSizeOption extends StatelessWidget {
  final String fontSize;
  const _FontSizeOption({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Timer Font Size',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              Expanded(
                flex: 9,
                child: Container(
                  padding: EdgeInsets.only(left: 3.0),
                  height: 40,
                  child: Text(
                    fontSize,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),
              SizedBox(width: 18),
              GestureDetector(
                child: Icon(Icons.restart_alt),
                //TODO: Pass an event or VoidCallback
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
