import 'package:flutter/material.dart';
import 'package:flutter_crud/home/todos_controller.dart';
import 'package:provider/provider.dart';

import 'remove_todo_modal.dart';
import 'remove_todo_snackbar.dart';

class RemainingAndClearToDosWidget extends StatelessWidget {
  const RemainingAndClearToDosWidget({Key? key}) : super(key: key);

  void _buildDialog(BuildContext context, ToDosController controller) {
    showDialog<AlertDialog>(
      context: context,
      builder: (context) => RemoveToDoDialogWidget(
        context,
        title: 'Remove all Presence?',
        content: 'Are you sure that you want to remove all Presence?',
        onAccepted: () {
          Navigator.of(context).pop();
          controller.removeAllToDos(() => _buildSnackbar(context, controller));
        },
      ).alertDialog,
      barrierDismissible: false,
    );
  }

  void _buildSnackbar(BuildContext context, ToDosController controller) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      RemoveToDoSnackbarWidget(
        context,
        text: 'You have removed ${controller.removedToDoList.length} Presence',
        onPressed: () => controller.undoRemoveAllToDos(),
      ).snackBar,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ToDosController controller = context.watch<ToDosController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'You have presence ${controller.toDos.length} time',
          style: TextStyle(color: Colors.grey),
        ),
        ElevatedButton(
          onPressed: controller.toDos.isNotEmpty
              ? () => controller.showRemoveAllToDosDialog(
                  () => _buildDialog(context, controller))
              : null,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0)),
          ),
          child: const Text('Remove Presence'),
        ),
      ],
    );
  }
}
