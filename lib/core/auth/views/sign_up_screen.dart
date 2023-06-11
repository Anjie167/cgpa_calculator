import 'package:cgpa_calcultor/core/auth/viewModel/auth_view_model.dart';
import 'package:cgpa_calcultor/global%20widgets/common_button.dart';
import 'package:cgpa_calcultor/global%20widgets/custom_text_form_field.dart';
import 'package:cgpa_calcultor/utils/colors.dart';
import 'package:cgpa_calcultor/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../global widgets/loading_container.dart';
import '../../../utils/console.dart';
import '../models/auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers for the email and password fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final matricNumberController = TextEditingController();
  bool isStudent = true;
  bool loading = false;


  void validateInputs() async {
    // Get the email and password values
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final firstName = firstnameController.text.trim();
    final lastName = lastnameController.text.trim();
    final phone = phoneNumberController.text.trim();
    final matric = matricNumberController.text.trim();


    try{
      // Check if they are empty or not
      if (email.isEmpty ||
          password.isEmpty ||
          firstName.isEmpty ||
          lastName.isEmpty ||
          phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter all details'),
            backgroundColor: Colors.red,
          ),
        );
        // Show a snackbar with an error message
      } else {
        // Perform the login logic here
        setState(() {
          loading = true;
        });
        UserData userData = UserData(
          role: isStudent ? "student" : "lecturer",
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phone,
          matricNumber: matric,
        );
        await AuthViewModel.instance
            .signUp(context, userData, password)
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Registered'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, "sign_in");
          setState(() {
            loading = false;
          });
        });
      }
    }catch(e){
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  40.0.height,
                  LayoutBuilder(builder: (context, constraints) {
                    return RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 30),
                            children: [
                          TextSpan(
                              text: "CGPA",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color)),
                          TextSpan(
                              text: "Calculator",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))
                        ]));
                  }),
                  const SizedBox(height: 32),
                  CustomTextFormField(
                    hintText: 'First Name',
                    controller: firstnameController,
                    inputType: TextInputType.text,
                  ),
                  CustomTextFormField(
                    hintText: 'Last Name',
                    controller: lastnameController,
                    inputType: TextInputType.text,
                  ),
                  CustomTextFormField(
                    hintText: 'Phone Number',
                    controller: phoneNumberController,
                    inputType: TextInputType.phone,
                  ),
                  if (isStudent)
                    CustomTextFormField(
                      hintText: 'Matric Number',
                      controller: matricNumberController,
                      inputType: TextInputType.text,
                    ),
                  CustomTextFormField(
                    hintText: 'Email',
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                  ),
                  CustomTextFormField(
                    hintText: 'Password',
                    showText: false,
                    controller: passwordController,
                    inputType: TextInputType.text,
                  ),
                  RoleSwitch(
                    isStudent: isStudent,
                    onChanged: (newValue) {
                      setState(() {
                        isStudent = newValue;
                      });
                    },
                  ),
                  loading
                      ? const LoadingContainer(color: kPrimaryBase,)
                  : CommonButton(
                    text: 'Sign Up',
                    onPress: validateInputs,
                    textColor: Colors
                        .white, // Call the validateInputs method when pressed
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already Have An Account? "),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: kPrimaryBase,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoleSwitch extends StatefulWidget {
  final bool isStudent;
  final Function(bool)? onChanged;

  const RoleSwitch(
      {super.key,
      required this.isStudent,
      this.onChanged}); // Initial role is set to student

  @override
  State<RoleSwitch> createState() => _RoleSwitchState();
}

class _RoleSwitchState extends State<RoleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Lecturer',
          style: TextStyle(fontSize: 16.0),
        ),
        Switch(
          value: widget.isStudent,
          onChanged: widget.onChanged,
        ),
        const Text(
          'Student',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
