import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_app/Features/notes/Cubit/note_cubit.dart';
import 'package:task_weather_app/Features/notes/View/Notes.dart';
import 'Addnotebottomsheet.dart';
import 'CustomBottom.dart';
import 'CustomTextField.dart';

class AddFormnote extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? title, desc;

  AddFormnote({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextField(
            onsaved: (value) {
              title = value;
            },
            Htext: 'Title',
            Maxline: 1,
          ),
          SizedBox(height: 20),
          CustomTextField(
            onsaved: (value) {
              desc = value;
            },
            Htext: 'Description',
            Maxline: 5,
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
          CustomBottom(
            color: Colors.amber,
            ontap: () async {
              int i = 1;
              if (formkey.currentState!.validate()) {
                formkey.currentState!.save();
                //  Note notemodel = Note(id: i, title: title!, description: desc!);
                await context.read<NoteCubit>().addNote5(
                  title: title!,
                  desc: desc!,
                );
                //  await BlocProvider.of<NoteCubit>(context).saveNoteToFirestore(
                //    userId: i.toString(),
                //    title: title!,
                //   description: desc!,
                // );
                debugPrint('done');
                //  BlocProvider.of<NoteCubit>(context).FetchAllNotes();
                formkey.currentState!.reset();
              }
            },
            name: 'Add',
          ),
        ],
      ),
    );
  }
}
