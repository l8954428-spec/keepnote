// pages/edit_note_page.dart
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form.dart';

class EditNotePage extends StatefulWidget {
  final String noteName;
  final String noteTitle;
  final String noteContent;
  final String? noteImage;

  const EditNotePage({
    super.key,
    required this.noteName,
    required this.noteTitle,
    required this.noteContent,
    this.noteImage,
  });

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _notesController;

  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.noteName);
    _titleController = TextEditingController(text: widget.noteTitle);
    _notesController = TextEditingController(text: widget.noteContent);
    _selectedImagePath = widget.noteImage;
  }

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
          'Edit Note',
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
                      text: 'Change Profile Picture',
                      onPressed: () {
                        // UI only - will add image picker logic later
                        setState(() {
                          // Simulate changing picture
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

              // Update Button
              CustomButton(
                text: 'Update Note',
                onPressed: () {
                  // UI only - will add update logic later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Note updated successfully!'),
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

              const SizedBox(height: 12),

              // Delete Button
              CustomButton(
                text: 'Delete Note',
                onPressed: () {
                  // UI only - will add delete logic later
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Note'),
                      content: const Text('Are you sure you want to delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Note deleted successfully!'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                backgroundColor: Colors.white,
                textColor: Colors.red,
                height: 54,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                isOutlined: true,
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