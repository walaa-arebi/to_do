import 'package:flutter/material.dart';
import 'package:to_do/features/tasks/view_model/database_service.dart';
import '../model/task_model.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget(
      {super.key, required this.task, required this.dataBaseService});

  final DataBaseService dataBaseService;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  await dataBaseService.updateTodoStatus(
                      task.id, !task.isChecked);
                },
                child: task.isChecked
                    ? const Icon(
                        Icons.check_box,
                        color: Colors.indigo,
                      )
                    : const Icon(Icons.check_box_outline_blank_outlined),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  task.taskContent,
                  style: TextStyle(
                      decoration:
                          task.isChecked ? TextDecoration.lineThrough : null,
                      color: task.isChecked ? Colors.grey : Colors.black),
                ),
              ),
              const Spacer(),
              InkWell(
                  onTap: () async {
                    await dataBaseService.deleteTodo(task.id);
                  },
                  child: const Icon(Icons.delete))
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
