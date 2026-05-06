import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/model/note_model.dart';
import 'package:notes/model/user_model.dart';

import '../pages/notes_dashboard.dart';

class LogicImpl extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;
  late bool isUpdate;
  void _startLoading(){
    loading = true;
    notifyListeners();
  }
  void _stopLoading(){
    loading = false;
    notifyListeners();
  }
  UserModel? useData ;
  List<NoteModel> notes =[];

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
          getUserNoteById(context: context);
        }
      }
    }catch(x){
      _stopLoading();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered success'),backgroundColor: Colors.green,));

    }
  }

  /// POST NOTE

  Future<void> postNote({required NoteModel note, required BuildContext context}) async{
    try{
      _startLoading();
      await _firestore.collection('notes').doc().set(note.toJson());
      _stopLoading();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note added successful'),backgroundColor: Colors.green,));
      getUserNoteById(context: context);

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e'),backgroundColor: Colors.red,));
      _stopLoading();
    }
  }


  Future<void> getUserNoteById({  String? email, required BuildContext context}) async{
    try{
      _startLoading();
      final noteDocs = await _firestore.collection('notes').where("email", isEqualTo: useData?.email??email).get();

      // final s = noteDocs.
      final noteData = noteDocs.docs.map((x) {
        final d = NoteModel.fromJson(x.data());
        final completeNote = d.copyWith(
            noteId: x.id
        );
        return completeNote;
      } ).toList();
      notes = noteData;
      notifyListeners();
      _stopLoading();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e'),backgroundColor: Colors.red,));

      _stopLoading();
    }
  }


  Future<void> deleteNote({required String noteId, required BuildContext context ,  required bool isUpdate}) async{
    try {
      this.isUpdate = isUpdate;
      notifyListeners();
      _startLoading();
      await _firestore.collection('notes').doc(noteId).delete();
      await getUserNoteById(context: context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note deleted successful'),backgroundColor: Colors.green,));
      if(context.mounted){
        Navigator.pop(context);
      }

      _stopLoading();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e'),backgroundColor: Colors.red,));

      _stopLoading();
    }
  }


  Future<void> updateNotes({required NoteModel note,  required BuildContext context, required bool isUpdate}) async{
    try{

      this.isUpdate = isUpdate;
      _startLoading();
      notifyListeners();
      await _firestore.collection('notes').doc(note.noteId).update(note.toJson());
      if(context.mounted){
        Navigator.pop(context);
      }
      _stopLoading();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e'),backgroundColor: Colors.red,));

      _stopLoading();
    }
  }

}