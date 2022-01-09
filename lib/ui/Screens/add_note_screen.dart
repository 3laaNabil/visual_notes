import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes/business%20_logic/add_visual_cubit.dart';
import 'package:visual_notes/constants/Colors.dart';
import 'package:visual_notes/constants/helper.dart';
import 'package:visual_notes/ui/Widgets/Button.dart';
import 'package:visual_notes/ui/Widgets/form_field.dart';

class AddNoteScreen extends StatelessWidget {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddVisualCubit, AddVisualState>(
      listener: (context, state) {

        if(state is CreateNoteSuccessState  ){

          AddVisualCubit.get(context).notes.clear();

          AddVisualCubit.get(context).getNotes();




        }


      },
      builder: (context, state) {
        var cubit = AddVisualCubit.get(context);

        return Scaffold(
          backgroundColor: AppColor.purple,
          appBar: AppBar(
            backgroundColor: AppColor.purple,
            elevation: 0,
            title: const Text("Add Visual notes"),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 60,
              left: 10,
              right: 10,
            ),
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is CreateNoteLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: titleController,
                        type: TextInputType.text,
                        validate: () {},
                        label: "Title",
                        prefix: Icons.title,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: descriptionController,
                          type: TextInputType.text,
                          validate: () {},
                          label: "Description",
                          prefix: Icons.description,
                          maxLines: 4),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          elevation: 5,
                          hint: const Text("Status"),
                          items: <String>[
                            'Open',
                            'Closed',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            cubit.status = value.toString();
                          },
                        ),
                      ),
                      Text(
                        "Status :  ${cubit.status.toString()}",
                        style: const TextStyle(color: AppColor.purple),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: defaultButton(
                          text: "Add Image",
                          onTap: () {
                            cubit.getImage();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: defaultButton(
                            text: "Add Note",
                            onTap: () {
                              cubit.uploadNoteImage(
                                  dateTime: DateTime.now().toString(),
                                  title: titleController.text,
                                  desc: descriptionController.text,
                                  status: cubit.status.toString());
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
