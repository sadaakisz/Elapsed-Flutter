import 'package:carousel_slider/carousel_slider.dart';
import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/models/custom_routine.dart';
import 'package:elapsed_flutter/pages/custom_timer.dart';
import 'package:elapsed_flutter/utils/custom_navigator.dart';
import 'package:elapsed_flutter/widgets/home_custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatefulWidget {
  HomeCarousel({Key? key, required this.customRoutines, required this.onDelete})
      : super(key: key);
  final List<CustomRoutine> customRoutines;
  final Function(int) onDelete;

  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  int _current = 0;
  bool active = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: widget.customRoutines.length,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            aspectRatio: 0.68,
            viewportFraction: 1,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          itemBuilder: (context, index, realIdx) {
            return GestureDetector(
              onTap: () {
                navPush(
                  context,
                  CustomTimerPage(
                    customRoutine: widget.customRoutines[index],
                  ),
                );
              },
              child: Flex(
                direction: Axis.vertical,
                children: [
                  HomeCustomTimer(
                    routine: widget.customRoutines[index],
                    onDelete: widget.onDelete,
                    index: index,
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: height / 30,
          //BUG: When deleting the last routine, the active dot indicator does not show up after a swipe
          //TODO: Validate when there are too many custom routines and the Row of dots is too large
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.customRoutines.asMap().entries.map((entry) {
              active = _current == entry.key;
              return AnimatedContainer(
                width: active ? width / 33 : width / 66,
                height: width / 66,
                margin: EdgeInsets.symmetric(horizontal: width / 133),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width / 133),
                  gradient: active
                      ? LinearGradient(
                          colors: [EColors.light_aqua, EColors.light_purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(colors: [
                          Colors.white.withOpacity(0.4),
                          Colors.white.withOpacity(0.4)
                        ]),
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
