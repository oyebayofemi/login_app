import 'package:flutter/material.dart';
import 'package:login_app/services/database.dart';

class DialogContainer extends StatefulWidget {
  DialogContainer({required this.uid});
  String uid;

  @override
  State<DialogContainer> createState() => _DialogContainerState();
}

class _DialogContainerState extends State<DialogContainer> {
  String? uids;
  void initState() {
    super.initState();
    uids = widget.uid;
  }

  final titleController = TextEditingController();
  String? task;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        child: Column(
          children: [
            Text('Add Task'),
            TextField(
              //controller: titleController,
              onChanged: (value) => task = value,
              decoration: InputDecoration(hintText: 'Task'),
            ),
            FlatButton(
                onPressed: () {
                  DatabaseService(uid: uids!).insertTask(task!);
                  Navigator.pop(context);
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
