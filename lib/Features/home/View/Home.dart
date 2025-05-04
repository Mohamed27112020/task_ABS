import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_app/Features/notes/Cubit/note_cubit.dart';
import 'package:task_weather_app/Features/notes/View/Notes.dart';
import 'package:task_weather_app/Widget/Addnotebottomsheet.dart';

class NotesHomePage extends StatelessWidget {
  final List<Note> notes = [
    Note(
      id: 1,
      title: 'Project Roadmap 2025',
      description:
          'Strategic planning for Q3-Q4 product releases. Need to finalize feature priorities and resource allocation.',
    ),
    Note(
      id: 2,
      title: 'Project Roadmap 2025',
      description:
          'Strategic planning for Q3-Q4 product releases. Need to finalize feature priorities and resource allocation.',
    ),
    Note(
      id: 3,
      title: 'Project Roadmap 2025',
      description:
          'Strategic planning for Q3-Q4 product releases. Need to finalize feature priorities and resource allocation.',
    ),
    Note(
      id: 4,
      title: 'Project Roadmap 2025',
      description:
          'Strategic planning for Q3-Q4 product releases. Need to finalize feature priorities and resource allocation.',
    ),
    Note(
      id: 5,
      title: 'Project Roadmap 2025',
      description:
          'Strategic planning for Q3-Q4 product releases. Need to finalize feature priorities and resource allocation.',
    ),
    Note(
      id: 6,
      title: 'Project Roadmap 2025',
      description:
          'Strategic planning for Q3-Q4 product releases. Need to finalize feature priorities and resource allocation.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: context.read<NoteCubit>().getNotesStream(''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error'));
        } else {
     //    Map<String, dynamic> notes = snapshot.data ;
          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Addnotebottomsheet();
                    },
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
            appBar: AppBar(
              title: Text('Notes'),
              actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Emily Johnson',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You have 12 notes in your workspace',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search notes...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'All Notes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Column(
                    children:
                        notes.map((note) => _buildNoteCard(note)).toList(),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              note.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 12),
            Text(
              'Edited 16 min ago',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
