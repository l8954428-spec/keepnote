import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  NoteModel({
    required this.name,
    required this.title,
    required this.notes,
    required this.image,
  });

  final String? name;
  final String? title;
  final String? notes;
  final String? image;

  NoteModel copyWith({
    String? name,
    String? title,
    String? notes,
    String? image,
  }) {
    return NoteModel(
      name: name ?? this.name,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      image: image ?? this.image,
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json){
    return NoteModel(
      name: json["name"],
      title: json["title"],
      notes: json["notes"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
    "notes": notes,
    "image": image,
  };

  @override
  String toString(){
    return "$name, $title, $notes, $image, ";
  }

  @override
  List<Object?> get props => [
    name, title, notes, image, ];
}
