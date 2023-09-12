import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// add page view to move between list of post and addPost
class AddPostSheet extends ConsumerWidget {
  AddPostSheet({
    required this.createPost,
    super.key,
  });

  InputDecoration _decoration(String value) {
    return InputDecoration(
        labelText: value, border: const OutlineInputBorder());
  }

  final _textEditTitle = TextEditingController();
  final _textEditNumber = TextEditingController();
  final _textEditText = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AsyncCallback createPost;

  String? _emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'New Post',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.cancel),
                  )
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _decoration('title'),
                controller: _textEditTitle,
                validator: _emptyValidator,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _decoration('number 1 to 1085'),
                controller: _textEditNumber,
                validator: (value) {
                  int? number = int.tryParse(value!);
                  if (number == null || value.isEmpty) {
                    return 'Please enter a number';
                  }

                  if (number < 1 || number > 1085) {
                    return 'Please enter a number of 1 to 1085';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _decoration('text'),
                controller: _textEditText,
                validator: _emptyValidator,
                maxLines: 5,
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await createPost();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Done'),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
            ],
          ),
        ),
      ),
    );
  }
}
