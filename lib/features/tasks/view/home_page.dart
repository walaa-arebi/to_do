import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/features/tasks/view/task_widget.dart';
import 'package:to_do/features/tasks/view_model/database_service.dart';
import 'package:to_do/widgets/app_bar.dart';
import '../../auth/view_model/auth_service.dart';
import '../model/task_model.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController newTaskController = TextEditingController();
  final AuthServices _auth = AuthServices();
  bool addTaskIsLoading = false;
  final DataBaseService _dataBaseService = DataBaseService();
  User? user = FirebaseAuth.instance.currentUser;
  late String uid;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar:CustomAppBar(
          context,
          titleText: "toDoListOf".tr() + widget.user.displayName.toString(),
          actionWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: buildLogoutButton(context),
          ) ,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder<List<Task>>(
                        stream: _dataBaseService.todos,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Task> tasks = snapshot.data!;
                            if (tasks.isNotEmpty) {
                              return ListView.builder(
                                  itemCount: tasks.length,
                                  itemBuilder: (context, index) {
                                    return TaskWidget(
                                      task: tasks[index],
                                      dataBaseService: _dataBaseService,
                                    );
                                  });
                            } else {
                              return Center(
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      "noData".tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey[500]),
                                    )),
                              );
                            }
                          } else if (snapshot.hasError){
                            return Center(
                              child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "something went wrong".tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey[500]),
                                  )),
                            );
                          }
                          else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        }))
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            addNewTaskWidget(context);
          },
          child: const Icon(Icons.add),
        ),

      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    return InkWell(
              onTap: () async {
                await _auth.signOut();
                context.go('/startPage');
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ));
  }

  void addNewTaskWidget(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      builder: (_context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontSize: 12),
                    hintText: "addTask".tr(),
                  ),
                  // maxLines: null,
                  controller: newTaskController,
                ),
              ),
              addTaskIsLoading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: () async {
                        setModalState(() {
                          addTaskIsLoading = true;
                        });
                        await _dataBaseService
                            .addTodoTask(newTaskController.text);
                        setModalState(() {
                          addTaskIsLoading = false;
                          newTaskController.clear();
                        });
                        Navigator.pop(_context);
                      },
                      child: Container(
                        height: 35,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.indigo,
                        ),
                        child: Center(
                            child: Text(
                          "addTask".tr(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
            ],
          );
        });
      },
    );
  }
}
