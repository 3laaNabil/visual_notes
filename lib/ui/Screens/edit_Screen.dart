
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes/business%20_logic/add_visual_cubit.dart';
import 'package:visual_notes/constants/Colors.dart';
import 'package:visual_notes/constants/helper.dart';
import 'package:visual_notes/constants/navigator.dart';
import 'package:visual_notes/ui/Screens/home_screen.dart';
import 'package:visual_notes/ui/Widgets/Button.dart';
import 'package:visual_notes/ui/Widgets/form_field.dart';

class EditScreen extends StatelessWidget {
  int index;

  EditScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController editTitleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    var cubit = AddVisualCubit.get(context);
    var note = cubit.notes[index];
    var image = cubit.image;

    editTitleController.text = note.title!;
    descriptionController.text = note.desc!;
    return BlocConsumer<AddVisualCubit, AddVisualState>(
      listener: (context, state) {
        if (state is EditNoteSuccessState) {
          cubit.notes.clear();

          cubit.getNotes();

          navigatToFinish(context, const HomeScreen());
        }
      },
      builder: (context, state) {
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
                        if (state is EditNoteLoadingState)
                          const Center(
                              child: CircularProgressIndicator(
                            color: AppColor.purple,
                          )),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: 200,
                            child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Align(
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: image == null
                                                          ? NetworkImage(
                                                                  "${note.Image_url}")
                                                              as ImageProvider
                                                          : FileImage(image),
                                                      fit: BoxFit.cover)),
                                            )),
                                        IconButton(
                                          icon: const CircleAvatar(
                                            backgroundColor: AppColor.purple,
                                            radius: 20.0,
                                            child: Icon(
                                              Icons.camera,
                                              size: 16.0,
                                              color: AppColor.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            cubit.getImage();
                                          },
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.topCenter,
                                  )
                                ])),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: editTitleController,
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
                              cubit.eStatus = value!.toString();

                            },
                          ),
                        ),
                        Text(
                          cubit.eStatus != null
                              ? "Status :    ${cubit.eStatus.toString()}"
                              : "Status :    ${note.status}",
                          style: const TextStyle(color: AppColor.purple),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: defaultButton(
                              text: "Edit Note",
                              onTap: () {
                                if (image == null) {
                                  cubit.updateNote(
                                      image: cubit.notes[index].Image_url,
                                      title: editTitleController.text,
                                      desc: descriptionController.text,
                                      index: index,
                                      date: DateTime.now().toString());
                                } else {
                                  cubit.updateNoteImage(
                                      dateTime: DateTime.now().toString(),
                                      title: editTitleController.text,
                                      desc: descriptionController.text,
                                      index: index);
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
