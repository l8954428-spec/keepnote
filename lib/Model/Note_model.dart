import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  const NoteModel({
    required this.name,
    required this.title,
    required this.notes,
    required this.image,
    required this.email,
    this.noteId,
  });

  final String? name;
  final String? title;
  final String? notes;
  final String? image;
  final String? email;
  final String? noteId;
  NoteModel copyWith({
    String? name,
    String? title,
    String? notes,
    String? image,
    String? email,
    String? noteId,
  }) {
    return NoteModel(
        name: name ?? this.name,
        title: title ?? this.title,
        notes: notes ?? this.notes,
        image: image ?? this.image,
        email: email ?? this.email,
        noteId: noteId??this.noteId
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      name: json["name"],
      title: json["title"],
      notes: json["notes"],
      image: json["image"],
      email: json["email"],
      noteId: json["noteId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
    "notes": notes,
    "image": image,
    "email": email,
    "noteId":noteId
  };

  @override
  String toString() {
    return "$name, $title, $notes, $image, $email $noteId";
  }

  @override
  List<Object?> get props => [name, title, notes, image, email, noteId];
}