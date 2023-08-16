import 'package:flutter/material.dart';

// add page view to move between list of post and addPost
class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  InputDecoration _decoration(String value) {
    return InputDecoration(hintText: value, border: const OutlineInputBorder());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: _decoration('title'),
        ),
        TextFormField(
          decoration: _decoration('number 1 to 1085'),
          validator: (value) {
            int? number = int.tryParse(value!);
            if(number == null){
              return 'Please enter a number';
            }

            if ( number > 0 && number < 1085 ) {
              return 'Please enter a number of 1 to 1085';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: _decoration('paragraph'),
          controller: TextEditingController(text: 'somevariable...'),
        ),
        OutlinedButton(onPressed: () {}, child: const Text('Add Post'))
      ],
    );
  }
}
