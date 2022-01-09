import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:visual_notes/data/model/noteModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'add_visual_state.dart';

class AddVisualCubit extends Cubit<AddVisualState> {
  AddVisualCubit() : super(AddVisualInitial());

  static AddVisualCubit get(context) => BlocProvider.of(context);
  String? status;
  String? eStatus;
  File? image;
  CollectionReference reference =
      FirebaseFirestore.instance.collection("VisualNote");
  NoteModel? noteModel;
  var picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);

      emit(ImagePickedSuccessState());
    } else {
      emit(ImagePickedErrorState());
    }
  }

  void uploadNoteImage(
      {String? dateTime, required String title, required desc, status}) {
    emit(UploadImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Note/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        addNote(
            title: title,
            date: dateTime,
            description: desc,
            image: value,
            status: status);
      }).catchError((error) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  addNote({
    required title,
    required date,
    required description,
    required image,
    String? status,
  }) {
    emit(CreateNoteLoadingState());

    NoteModel model = NoteModel(
        title: title,
        dateTime: date,
        desc: description,
        Image_url: image,
        status: status);

    var docRef = reference.add(model.toMap());

    docRef.then((value) {
      emit(CreateNoteSuccessState());
    }).catchError((e) {
      emit(CreateNoteErrorState());
    });
  }

  List<NoteModel> notes = [];
  List<String> notesId = [];

  void getNotes() {
    emit(GetNoteLoadingState());
    FirebaseFirestore.instance.collection('VisualNote').get().then((value) {
      value.docs.forEach((element) {
        notes.add(NoteModel.fromJson(element.data()));
        notesId.add(element.id);
      });

      emit(GetNoteSuccessState());
    }).catchError((error) {
      emit(GetNoteSuccessState());
    });
  }

  void deleteNote(index) async {
await    reference.doc(notesId[index]).delete().then((value) {
      emit(DeleteNoteSuccessState());
    }).catchError((error) {
      emit(DeleteNoteErrorState());
    });
  }

  void updateNote(
      {required String title,
      required String desc,
      String? stutas,
      String? image,
        date,
      index}) async {
    emit(EditNoteLoadingState());

    noteModel = NoteModel(
      title: title,
      desc: desc,
      Image_url: image,
      status: eStatus,
      dateTime:date
    );

    await reference
        .doc(notesId[index].toString())
        .update(noteModel!.toMap())
        .then((value) {
      emit(EditNoteSuccessState());

      // getNotes();
    }).catchError((error) {
      emit(EditNoteErrorState());
    });
  }

  void updateNoteImage(
      {String? dateTime, required String title, required desc, status, index}) {
    emit(UpdateImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Note/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateNote(
            title: title,
            desc: desc,
            date: dateTime,
            index: index,
            stutas: eStatus,
            image: value);

        emit(UpdateImageSuccessState());
      }).catchError((error) {
        emit(UpdateImageErrorState());
      });
    }).catchError((error) {
      emit(UpdateImageErrorState());
    });
  }
}
