import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';

// add page view to move between list of post and addPost
class AddOrUpdatePostSheet extends ConsumerWidget {
  AddOrUpdatePostSheet({
    this.currentPost,
    this.createPost,
    this.updatePost,
    super.key,
  });

  InputDecoration _decoration(String value) {
    return InputDecoration(
        labelText: value, border: const OutlineInputBorder());
  }

  final _formKey = GlobalKey<FormState>();

  final AsyncCallback? createPost;
  final AsyncValueSetter<String>? updatePost;

  final Post? currentPost;

  String? _emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  bool _isUpdating() {
    return updatePost != null && currentPost != null;
  }

  String _extractImageID(String imageUrl) {
    const String start = 'id/';
    const String end = '/300';
    final startIndex = imageUrl.indexOf(start);
    final endIndex = imageUrl.indexOf(end, startIndex + start.length);
    return imageUrl.substring(startIndex + start.length, endIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditTitle = _isUpdating()
        ? TextEditingController(text: currentPost!.title)
        : TextEditingController();
    final textEditNumber = _isUpdating()
        ? TextEditingController(text: _extractImageID(currentPost!.imageUrl))
        : TextEditingController();
    final textEditText = _isUpdating()
        ? TextEditingController(text: currentPost!.text)
        : TextEditingController();

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
                    !_isUpdating() ? 'New Post' : 'Update Post',
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
                controller: textEditTitle,
                validator: _emptyValidator,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _decoration('number 1 to 1085'),
                controller: textEditNumber,
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
                controller: textEditText,
                validator: _emptyValidator,
                maxLines: 5,
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_isUpdating()) {
                      await updatePost!(currentPost!.id);
                    } else {
                      await createPost!();
                    }

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
