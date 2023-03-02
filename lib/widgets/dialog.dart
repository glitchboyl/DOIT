import 'package:flutter/material.dart';

class DialogBuilder extends StatelessWidget {
  const DialogBuilder({Key? key, }) : super(key: key);
  @override
  Widget build(BuildContext context) => Dialog(
        elevation: 0,
        shadowColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('This is a typical dialog.'),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      );
}
