import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phone: json["phone"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "password": password,
  };

  @override
  String toString(){
    return "$firstName, $lastName, $email, $phone, $password, ";
  }

  @override
  List<Object?> get props => [
    firstName, lastName, email, phone, password, ];
}
