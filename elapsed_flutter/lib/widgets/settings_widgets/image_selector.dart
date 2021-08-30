import 'dart:io';

import 'package:flutter/material.dart';

class ImageSelector extends StatelessWidget {
  final String? imagePath;
  final Function onTap;
  final VoidCallback? onReset;
  final bool enableReset;
  const ImageSelector({
    Key? key,
    this.imagePath,
    required this.onTap,
    this.onReset,
    this.enableReset = true,
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
            'Background Image',
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
                            'Select photo from library',
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
                          child: imagePath != ''
                              ? Image.file(File(imagePath!), fit: BoxFit.cover)
                              : Icon(
                                  Icons.image_outlined,
                                  color: Colors.white,
                                  size: width / 16,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              enableReset ? SizedBox(width: width / 22) : SizedBox(),
              enableReset
                  ? GestureDetector(
                      onTap: () => onReset!(),
                      child: Icon(Icons.restart_alt),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
