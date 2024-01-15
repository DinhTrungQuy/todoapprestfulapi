import 'dart:convert';
import 'package:todoapprestfulapi/component/message.dart';
import 'package:todoapprestfulapi/models/todo.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Todo>> getTodos() async {
    // await Future.delayed(const Duration(seconds: 2));
    return http
        .get(Uri.parse('http://10.0.2.2:3000/api/v1/todos'))
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw Exception('Error while fetching data');
      }
      final useListContainer = jsonDecode(jsonBody);
      return useListContainer.map<Todo>((json) => Todo.fromJson(json)).toList();
    });
  }

  Future<List<Todo>> getTodoById(String id) async {
    return http
        .get(Uri.parse('http://10.0.2.2:3000/api/v1/todos/$id'))
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw Exception('Error while fetching data');
      }
      final useListContainer = jsonDecode(jsonBody);
      return useListContainer.map<Todo>((json) => Todo.fromJson(json)).toList();
    });
  }

  Future<void> addTodo(context, String title, String description) async {
    final body = {
      'title': title,
      'description': description,
      'isDone': false,
    };
    final uri = Uri.parse('http://10.0.2.2:3000/api/v1/todos');
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 201) {
      ShowMessageDialog().showCompleted(context, 'To Do has been added');
    } else {
      ShowMessageDialog().showFailed(context, 'Failed to add To Do');
    }
  }

  Future<void> deleteTodoById(context, String id) async {
    final respond =
        await http.delete(Uri.parse('http://10.0.2.2:3000/api/v1/todos/$id'));
    if (respond.statusCode == 200) {
      ShowMessageDialog().showCompleted(context, 'To Do has been deleted');
    } else {
      ShowMessageDialog().showFailed(context, 'To Do has not been deleted');
    }
  }

  Future<void> updateTodoById(
      context, String? id, String? title, String? description) async {
    final Todo todo =
        Todo(id: id, title: title!, description: description!, isDone: true);
    final body = todo.toJson();
    final respond = await http.put(
        Uri.parse('http://10.0.2.2:3000/api/v1/todos/$id'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        });
    if (respond.statusCode == 200) {
      ShowMessageDialog().showCompleted(context, 'To Do has been updated');
    } else {
      ShowMessageDialog().showFailed(context, 'To Do has not been updated');
    }
  }
}
