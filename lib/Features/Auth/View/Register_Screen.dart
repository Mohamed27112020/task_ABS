import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_app/Features/Auth/Cubit/Cubit/RegisterCubit/register_cubit.dart';
import 'package:task_weather_app/Features/Auth/Cubit/RegisterCubit/register_state.dart';
import 'package:task_weather_app/Features/home/View/Home.dart';
import 'package:task_weather_app/Widget/CustomBottom.dart';
import 'package:task_weather_app/Widget/Snackbar.dart';
import 'package:task_weather_app/Widget/customtextfiled.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String? name;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterLoading) {
          showSnackbar(context, 'Loading Register', Colors.grey);
        } else if (state is RegisterSucces) {
          showSnackbar(context, 'Success Register', Colors.green);
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NotesHomePage();
              },
            ),
          );
        } else if (state is RegisterFailure) {
          showSnackbar(context, 'Failure Register', Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          //   backgroundColor: Kprimarycolor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Container(
                  width: double.infinity,
                  height: 900,
                  //   color: Colors.red,
                  alignment: Alignment.center,
                  child: Container(
                    width: 500,
                    //    color: Colors.blue,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "ABS.AI Notes ",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Welcome back! Please Register your account.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        customTextField(
                          controller: namecontroller,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          hinttext: 'Name',
                          onchange: (data) {
                            name = data;
                          },
                        ),
                        SizedBox(height: 20),
                        customTextField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          hinttext: 'Email',
                          onchange: (data) {
                            email = data;
                          },
                        ),
                        SizedBox(height: 10),
                        customTextField(
                          controller: passwordcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          hinttext: 'password',
                          onchange: (data) {
                            password = data;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomBottom(
                          color: Colors.blue,
                          ontap: () async {
                            if (formkey.currentState!.validate()) {
                              await BlocProvider.of<RegisterCubit>(
                                context,
                              ).Registerfun(
                                email: email!,
                                password: password!,
                                name: name!,
                                context: context,
                              );
                            }
                            emailcontroller.clear();
                            passwordcontroller.clear();
                          },
                          name: 'Register',
                        ),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have account ? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login ",
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
