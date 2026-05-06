import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/model/user_model.dart';

import '../pages/notes_dashboard.dart';

class LogicImpl extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;
  void _startLoading(){
    loading = true;
    notifyListeners();
  }
  void _stopLoading(){
    loading = false;
    notifyListeners();
  }
  UserModel? useData ;

  Future<void> registerUser({required UserModel userModel, required BuildContext context}) async {
    try {
      _startLoading();
      final userCrd = await _auth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );
      await _firestore.collection('users') .doc(userCrd.user?.uid).set(userModel.toJson());
      _stopLoading();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered success'),backgroundColor: Colors.green,));

    }catch(e){
      _stopLoading();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e'),backgroundColor: Colors.red,));

    }
  }

  Future <void> login(String email, String password, BuildContext context) async{
    try {
      _startLoading();
      final userCrd = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = userCrd.user;
      if (user == null) {
        _stopLoading();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not found'),backgroundColor: Colors.red,));

      }else {
        final userDoc = await _firestore
            .collection('users')
            .doc(user.uid)
            .get();
        if (!userDoc.exists) {
          _stopLoading();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('User not found'),
            backgroundColor: Colors.red,));
        } else {
          final userData1 = userDoc.data();

          useData = UserModel.fromJson(userData1!);
          notifyListeners();
          _stopLoading();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NotesDashboard()),
          );
        }
      }
    }catch(x){
      _stopLoading();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered success'),backgroundColor: Colors.green,));

    }
  }
}