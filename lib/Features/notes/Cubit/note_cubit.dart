import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_weather_app/Features/notes/View/Notes.dart';

import '../../../Core/constant.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteCibitInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reference to the notes collection
  CollectionReference get _notes => _firestore.collection('Notes');

  // Send/Save a note to Firebase

  CollectionReference users = FirebaseFirestore.instance.collection('Notes');

  Future<void> addNote5({required String title, required String desc}) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'title': title,
          'description': desc,
          // 'userId': ,
          'createdAt': FieldValue.serverTimestamp(), // Adds current server time
          'updatedAt': FieldValue.serverTimestamp(),
        })
        .then((value) => print("Notes Added"))
        .catchError((error) => print("Failed to add note: $error"));
  }

Stream<List<Map<String, dynamic>>> getMessagesStream() {
  return FirebaseFirestore.instance
      .collection('Notes')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'title': data['title'] ?? 'No Title',
        'content': data['content'] ?? '',
        'timestamp': (data['timestamp'] as Timestamp?)?.toDate(),
      };
    }).toList();
  });
}



  Future<void> saveNoteToFirestore({
    required String title,
    required String description,
    required String userId, // To associate note with user
  }) async {
    try {
      // Get reference to Firestore collection
      final notesCollection = FirebaseFirestore.instance.collection('Notes');
      // Add a new document with auto-generated ID
      await notesCollection.add({
        'title': title,
        'description': description,
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(), // Adds current server time
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('Note saved successfully!');
    } catch (e) {
      print('Error saving note: $e');
      throw Exception('Failed to save note: $e'); // Re-throw for error handling
    }
  }

  // Get all notes for a specific user
  Stream<List<Map<String, dynamic>>> getNotes(String userId) {
    return _notes
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'id': doc.id,
              'title': data['title'] ?? '',
              'description': data['description'] ?? '',
              'createdAt': (data['createdAt'] as Timestamp).toDate(),
            };
          }).toList();
        });
  }

  // Get a single note by ID
  Future<Map<String, dynamic>?> getNoteById(String noteId) async {
    try {
      final doc = await _notes.doc(noteId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'title': data['title'],
          'description': data['description'],
          'createdAt': (data['createdAt'] as Timestamp).toDate(),
        };
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get note: $e');
    }
  }
  // Update an existing note

  // Delete a note
  Future<void> deleteNote(String noteId) {
    return _notes.doc(noteId).delete();
  }

  // Get all notes for a specific user
  Stream<List<Note>> getNotesStream(String userId) {
    return _notes
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Note.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();
        });
  }

  // Get a single note
  Future<Note?> getNote(String noteId) async {
    final doc = await _notes.doc(noteId).get();
    if (doc.exists) {
      return Note.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  /*
  List<Note> notes = [];
  
  Addnote(
      {required Note note, required String title, required String desc}) async {
    try {
      emit(NoteCibitLoading());
      note.title = title;
      note.description = desc;
      notes.add(note);
      await saveListData('notes', notes);
      print(notes);
      print('note added sucessfully');
      emit(NoteCibitSucess());
    } on Exception catch (e) {
      print(e.toString());
      emit(NoteCibitError());
    }
  }

  Future<void> Removefun(Note note) async {
    await notes.remove(note);
    if (note == null) {
      print('Data removed successfully.');
    } else {
      print('Failed to remove data.');
    }
  }

  FetchAllNotes() {
    emit(NotesLoading());
    var notesbox = loadTasks();
    //print(notesbox.toString());
    emit(NotesSucess());
  }

  Future<void> SaveTasks(String key, List<Note> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        key, jsonEncode(tasks.map((task) => task.toJson()).toList()));
  }

  /// Saves a list of strings to SharedPreferences.
  ///
  /// [key] is the identifier for the list.
  /// [list] is the list of strings to be saved.
  Future<void> saveListData(String key, List<Note> list) async {
    List<dynamic> castlist = list.cast();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        key, jsonEncode(castlist.map((task) => task.toJson()).toList()));
  }

  /// Retrieves a list of strings from SharedPreferences.
  ///
  /// [key] is the identifier for the list.
  /// Returns the list of strings, or an empty list if no data is found.
  /*
  Future<List<String>> getListData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }
*/
  Future<List<Note>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      return decoded.map((json) => Note.fromJson(json)).toList();
    }
    return [];
  }
  */
}
