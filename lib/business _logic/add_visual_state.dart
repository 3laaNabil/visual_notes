part of 'add_visual_cubit.dart';

@immutable
abstract class AddVisualState {}

class AddVisualInitial extends AddVisualState {}

class ImagePickedSuccessState extends AddVisualState {}

class ImagePickedErrorState extends AddVisualState {}

class CreateNoteLoadingState extends AddVisualState {}

class CreateNoteSuccessState extends AddVisualState {}

class CreateNoteErrorState extends AddVisualState {}

class GetNoteLoadingState extends AddVisualState {}

class GetNoteSuccessState extends AddVisualState {}

class GetNoteErrorState extends AddVisualState {}

class DeleteNoteSuccessState extends AddVisualState {}

class DeleteNoteErrorState extends AddVisualState {}

class UploadImageLoadingState extends AddVisualState {}

class UploadImageSuccessState extends AddVisualState {}

class UploadImageErrorState extends AddVisualState {}

class EditNoteLoadingState extends AddVisualState {}

class EditNoteSuccessState extends AddVisualState {}

class EditNoteErrorState extends AddVisualState {}
class UpdateImageLoadingState extends AddVisualState {}

class UpdateImageSuccessState extends AddVisualState {}

class UpdateImageErrorState extends AddVisualState {}

