import 'package:flutter/material.dart';
import 'package:todoapprestfulapi/data_source/api_services.dart';
import 'package:todoapprestfulapi/models/todo.dart';
import 'package:todoapprestfulapi/screens/add_page.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Todo>? todoList;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: todoList == null
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: refreshTodos,
                child: ListView.builder(
                  itemCount: todoList!.length,
                  itemBuilder: (context, index) {
                    Todo todo = todoList![index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'edit') {
                            navigateToEditPage(todo);
                          } else if (value == 'delete') {
                            deleteTodo(todo);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ];
                        },
                      ),
                    );
                  },
                ),
              ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> refreshTodos() async {
    setState(() => isLoading = true);
    todoList = await ApiServices().getTodos();
    setState(() => isLoading = false);
  }

  void deleteTodo(Todo todo) async {
    setState(() => isLoading = true);
    await ApiServices().deleteTodoById(context, todo.id!);
    await refreshTodos();
  }

  void navigateToEditPage(Todo item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddToDoPage(item: item)),
    ).then((_) => refreshTodos());
  }

  void navigateToAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddToDoPage()),
    ).then((_) => refreshTodos());
  }
}
