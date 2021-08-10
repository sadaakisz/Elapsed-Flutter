import 'package:elapsed_flutter/colors/elapsed_colors.dart';
import 'package:elapsed_flutter/widgets/success_delete_custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DeleteCustomTimer extends StatefulWidget {
  const DeleteCustomTimer({Key? key, required this.onDelete}) : super(key: key);

  final VoidCallback onDelete;

  @override
  _DeleteCustomTimerState createState() => _DeleteCustomTimerState();
}

class _DeleteCustomTimerState extends State<DeleteCustomTimer> {
  VoidCallback get onDelete => widget.onDelete;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: EColors.black,
      insetPadding: EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      child: FractionallySizedBox(
        widthFactor: 0.78,
        heightFactor: 0.34,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25),
            Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
            SizedBox(height: 15),
            Text(
              'Delete Routine',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: 15),
            Text(
              'This action will permanently delete this routine.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 15),
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
                                .copyWith(fontSize: 12),
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
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  fontSize: 12,
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
                          onDelete();
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
    );
  }
}
