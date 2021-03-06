import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/widgets/success_delete_custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DeleteCustomTimer extends StatefulWidget {
  const DeleteCustomTimer(
      {Key? key, required this.onDelete, required this.index})
      : super(key: key);

  final Function(int) onDelete;
  final int index;

  @override
  _DeleteCustomTimerState createState() => _DeleteCustomTimerState();
}

class _DeleteCustomTimerState extends State<DeleteCustomTimer> {
  Function(int) get onDelete => widget.onDelete;
  int get index => widget.index;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: EColors.black,
      child: Container(
        height: height * 0.3,
        width: width * 0.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
              Text(
                'Delete Routine',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
              Text(
                'This action will permanently delete this routine.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Container(
                height: 45,
                width: double.maxFinite,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          height: 45,
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(fontSize: width / 33),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(7)),
                        ),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          child: Center(
                            child: Text(
                              'Delete',
                              style:
                                  Theme.of(context).textTheme.button!.copyWith(
                                        fontSize: width / 33,
                                        color: Colors.white,
                                      ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: EColors.red,
                              borderRadius: BorderRadius.circular(7)),
                        ),
                        onTap: () {
                          setState(() {
                            onDelete(index);
                          });
                          Navigator.of(context).pop();
                          showAnimatedDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return SuccessDeleteCustomTimer();
                            },
                            animationType: DialogTransitionType.sizeFade,
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 500),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
