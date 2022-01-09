import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes/business%20_logic/add_visual_cubit.dart';
import 'package:visual_notes/constants/Colors.dart';
import 'package:visual_notes/constants/helper.dart';
import 'package:visual_notes/constants/navigator.dart';
import 'package:visual_notes/ui/Screens/add_note_screen.dart';
import 'package:visual_notes/ui/Widgets/note_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.purple,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatTo(context, AddNoteScreen());
        },
        backgroundColor: AppColor.purple2,
        elevation: 5,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.purple,
        title: const Center(child: Text("Visual notes")),
      ),
      body: BlocConsumer<AddVisualCubit, AddVisualState>(
        listener: (context, state) {

          if(state is DeleteNoteSuccessState){


            AddVisualCubit.get(context).notes.clear();
            AddVisualCubit.get(context).notesId.clear();
            AddVisualCubit.get(context).getNotes();
          }


        },
        builder: (context, state) {
          var cubit = AddVisualCubit.get(context);

          return Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 60,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cubit.notes.length} notes ",
                  style: const TextStyle(color: AppColor.white, fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),

                if(state is GetNoteLoadingState)

                  const   Center(child:  CircularProgressIndicator(color: AppColor.purple,),),

                Expanded(
                  child: Container(
                    height: Helper.getScreenHeight(context),
                    width: Helper.getScreenWidth(context),
                    decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child:
                    ListView.builder(
                      itemBuilder: (context, index) => noteItem(
                        cubit.notes[index],
                        context,
                        index,

                      ),
                      itemCount: cubit.notes.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
