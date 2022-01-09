class NoteModel {
  String? id;
  String? title;
  String? status;
  String? dateTime;
  String? desc;
  String? Image_url;

  NoteModel({
    this.title,
    this.id,
    this.status,
    this.dateTime,
    this.desc,
    this.Image_url,
  });

  NoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    status = json['status'];
    dateTime = json['dateTime'];
    desc = json['desc'];
    Image_url = json['Image_url'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'status': status,
      'dateTime': dateTime,
      'desc': desc,
      'Image_url': Image_url,
    };
  }
}
