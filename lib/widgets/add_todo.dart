import 'package:flutter/material.dart';
import 'package:flutter_crud/home/todos_controller.dart';
import 'package:provider/provider.dart';

class AddToDoWidget extends StatelessWidget {
  const AddToDoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ToDosController controller = context.watch<ToDosController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Form(
            key: controller.addToDosFormKey,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: controller.addToDosInputController,
              focusNode: controller.addToDosInputFocus,
              keyboardType: TextInputType.text,
              maxLength: 50,
              decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  hintText: 'Masukkan Hari',
                  hintStyle: TextStyle(color: Colors.white)),
              onEditingComplete: controller.validateToDoForm,
              validator: controller.addToDosValidator,
              onSaved: controller.addToDo,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: controller.validateToDoForm,
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFB58D00),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            ),
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
