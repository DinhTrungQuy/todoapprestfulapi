// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todoapprestfulapi/data_source/api_services.dart';
import 'package:todoapprestfulapi/models/todo.dart';

class AddToDoPage extends StatefulWidget {
  final Todo? item;
  const AddToDoPage({super.key, this.item});

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      isEdit = true;
      _titleController.text = widget.item!.title;
      _descriptionController.text = widget.item!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(isEdit ? 'Edit To Do Page' : 'Add To Do Page')),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Enter your to do here',
            ),
            autofocus: true,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              hintText: 'Enter your description here',
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              isEdit
                  ? {
                      ApiServices().updateTodoById(context, widget.item?.id,
                          _titleController.text, _descriptionController.text),
                    }
                  : {
                      ApiServices().addTodo(context, _titleController.text,
                          _descriptionController.text),
                      _titleController.text = '',
                      _descriptionController.text = ''
                    };
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(isEdit ? 'Upload' : 'Submit'),
          ),
        ],
      ),
    );
  }
}
