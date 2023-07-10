
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:u_todo/pages/todo/to_do_cubit.dart';
import 'package:u_todo/utils/app_style.dart';
import 'package:u_todo/widgets/w_keyboard_dismiss.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  //#region Properties
  //----------------
  final TextEditingController addTaskTextController = TextEditingController();

  //#region Build
  //-----------------
  @override
  Widget build(BuildContext context) {
    return WKeyboardDismiss(child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('   To-do task', style: boldTextStyle(15.sp),),
                          Row(
                            children: [
                              Text('Total: ${context.watch<TodoBloc>().state.todoList?.length ?? 0}', style: boldTextStyle(15.sp),),
                              SizedBox(width: 20.w,)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        children: [
                          SizedBox(width: 10.w,),
                          InkWell(
                            onTap: () {
                              context.read<TodoBloc>().sortTodoList();
                            },
                            child: Container(
                              height: 48.h,
                              width: 80.w,
                              margin: EdgeInsets.only(right: 10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                                  color: Colors.grey.shade200
                              ),
                              child: Center(
                                child: Text('Sort', style: boldTextStyle(8.sp)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: context.watch<TodoBloc>().state.todoList?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final todo = context.read<TodoBloc>().state.todoList![index];
                            return SwipeActionCell(
                              key: ObjectKey(todo),
                              trailingActions: [
                                SwipeAction(
                                  title: "Delete",

                                  color: Colors.red, onTap: (Future<void> Function(bool) handler) {
                                    context.read<TodoBloc>().removeTodo(index);
                                },
                                ),
                                SwipeAction(
                                  title: "Priority",

                                  color: Colors.orangeAccent, onTap: (Future<void> Function(bool) handler) {
                                  context.read<TodoBloc>().setPriorityForTask(index);
                                },
                                ),
                              ],
                              child: Container(
                                margin: EdgeInsets.only(top: 10.h),
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                                  color: Colors.lightBlue
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text(
                                      todo,
                                      style: normalTextStyle(8.sp, color: Colors.white),
                                    ),
                                    Checkbox(value: false, onChanged: (bool? newValue) {
                                      context.read<TodoBloc>().updateCompletedTodo(index);
                                    })
                                  ],
                                ),
                              ),
                            );
                          })

                    ],
                  ),
                  SizedBox(height: 30.h,),
                  if (context.watch<TodoBloc>().state.doneList?.isNotEmpty ?? false ) Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('   Completed task', style: boldTextStyle(15.sp),),
                          Row(
                            children: [
                              Text('${context.watch<TodoBloc>().state.doneList?.length ?? 0}', style: boldTextStyle(15.sp),),
                              SizedBox(width: 20.w,)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: context.watch<TodoBloc>().state.doneList?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final todo = context.read<TodoBloc>().state.doneList![index];
                            return Container(
                              margin: EdgeInsets.only(top: 10.h),
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              height: 48.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                                  color: Colors.orangeAccent
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    todo,
                                    style: normalTextStyle(8.sp, color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          })

                    ],
                  ) else Container(),
                  SizedBox(height: 100.h,)
                ],
              ),
            ),
            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100.h,
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      SizedBox(width: 10.w,),
                      Expanded(
                        child: TextField(
                          controller: addTaskTextController,
                          decoration: const InputDecoration(
                            hintText: 'Add a task',

                          ),

                        ),
                      ),
                      SizedBox(width: 10.w,),
                      InkWell(
                        onTap: () {
                          context.read<TodoBloc>().addTodo(addTaskTextController.text);
                          addTaskTextController.text = '';
                        },
                        child: Container(
                          height: 48.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                            color: Colors.white
                          ),
                          child: Center(
                            child: Text('Add', style: boldTextStyle(8.sp)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w,)
                    ]
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
