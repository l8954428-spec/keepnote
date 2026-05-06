// pages/add_note_page.dart
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add New Note',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[200],
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: _selectedImagePath != null
                          ? ClipOval(
                        child: Image.network(
                          _selectedImagePath!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      )
                          : Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: 'Add Profile Picture',
                      onPressed: () {
                        // UI only - will add image picker logic later
                        setState(() {
                          // Simulate adding a picture
                          _selectedImagePath = 'https://via.placeholder.com/150';
                        });
                      },
                      backgroundColor: Colors.white,
                      textColor: Colors.blue,
                      height: 40,
                      fontSize: 14,
                      borderRadius: 20,
                      isOutlined: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Name Input
              CustomInput(
                controller: _nameController,
                labelText: 'Name',
                hintText: 'Enter your full name',
                prefixIcon: Icons.person_outline,
              ),

              const SizedBox(height: 20),

              // Note Title Input
              CustomInput(
                controller: _titleController,
                labelText: 'Note Title',
                hintText: 'Enter note title',
                prefixIcon: Icons.title_outlined,
              ),

              const SizedBox(height: 20),

              // Notes Text Area
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Write your notes',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _notesController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: 'Write your notes here...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Submit Button
              CustomButton(
                text: 'Submit Note',
                onPressed: () {
                  // UI only - will add logic later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Note submitted successfully!'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                height: 54,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}