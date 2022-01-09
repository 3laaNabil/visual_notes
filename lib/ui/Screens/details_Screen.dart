import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes/business%20_logic/add_visual_cubit.dart';
import 'package:visual_notes/constants/Colors.dart';
import 'package:visual_notes/constants/helper.dart';
import 'package:visual_notes/constants/navigator.dart';
import 'package:visual_notes/data/model/noteModel.dart';
import 'package:visual_notes/ui/Screens/edit_Screen.dart';

class DetailsScreen extends StatelessWidget {
  int itemIndex;

  DetailsScreen({Key? key, required this.itemIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddVisualCubit, AddVisualState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AddVisualCubit.get(context);
        return Scaffold(
          backgroundColor: AppColor.purple,
          appBar: AppBar(
            backgroundColor: AppColor.purple,
            elevation: 0,
            title:
                Text("${AddVisualCubit.get(context).notes[itemIndex].title}"),
            actions: [
              InkWell(
                onTap: () {
                  navigatTo(
                      context,
                      EditScreen(
                        index: itemIndex,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: const [
                      Icon(Icons.edit),
                      Text("Edit"),
                    ],
                  ),
                ),
              )
            ],
          ),
          body: buildDetailsScreen(cubit.notes[itemIndex], context),
        );
      },
    );
  }
}

Widget buildDetailsScreen(NoteModel model, context) {
  return SingleChildScrollView(
    child: SizedBox(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                      image: model.Image_url != null
                          ? NetworkImage('${model.Image_url}')
                          : const NetworkImage(
                              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngegg.com%2Far%2Fpng-zeqbl&psig=AOvVaw2TenmUR9lPk49756orILoo&ust=1641835240377000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCOCwzoaXpfUCFQAAAAAdAAAAABAD"),
                      fit: BoxFit.cover,
                    ),
                  )),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  color: Colors.black38,
                  width: double.infinity,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${model.title}",
                            style: const TextStyle(
                              fontSize: 18,
                              color:AppColor.white,
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Stauts :  ${model.status}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColor.white,
                      fontFamily: 'Asma',
                    )),
                const SizedBox(
                  height: 15,
                ),
                Text("Desc :  ${model.desc}",
                    style: const TextStyle(
                      fontSize: 18,
                      color:  AppColor.white,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ),
  );
}
