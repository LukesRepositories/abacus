import 'package:flutter/material.dart';

class AlertDialogues {
  static void showSavedAlertDialogue(context) {
    showDialog<String>(
      context:  context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Puzzle Session Saved'),
        content: const Text('You did it in Nms'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}