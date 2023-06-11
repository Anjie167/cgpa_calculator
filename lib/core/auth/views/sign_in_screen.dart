import 'package:cgpa_calcultor/core/auth/viewModel/auth_view_model.dart';
import 'package:cgpa_calcultor/global%20widgets/common_button.dart';
import 'package:cgpa_calcultor/global%20widgets/custom_text_form_field.dart';
import 'package:cgpa_calcultor/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../global widgets/loading_container.dart';
import '../../../utils/console.dart';

// A custom text field widget with a red border and white text
// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final bool obscureText;
//   final TextEditingController controller;
//
//   const CustomTextField({
//     Key? key,
//     required this.hintText,
//     this.obscureText = false,
//     required this.controller,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: const TextStyle(color: Colors.white54),
//         enabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red, width: 2),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red, width: 2),
//         ),
//       ),
//     );
//   }
// }

// A custom button widget with a red background and white text

// The main login screen widget
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for the email and password fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  // A method to validate the email and password inputs
  void validateInputs() {
    // Get the email and password values
    final email = emailController.text;
    final password = passwordController.text;

    try{
      // Check if they are empty or not
      if (email.isEmpty || password.isEmpty) {
        // Show a snackbar with an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter your email and password'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Perform the login logic here
        setState(() {
          loading = true;
        });
        AuthViewModel.instance.login(context, email, password).then((value) {
          setState(() {
            loading = false;
          });
          Console.log(value!.email);
          if(value.role == "student"){
            Navigator.pushReplacementNamed(context, "profile");
          }else{
            Navigator.pushReplacementNamed(context, "students");
          }
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
                  loading
                      ? const LoadingContainer(color: kPrimaryBase,)
                  :CommonButton(
                    text: 'Log In',
                    onPress: validateInputs,
                    textColor: Colors
                        .white, // Call the validateInputs method when pressed
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't Have An Account? "),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "sign_up");
                            },
                            child: const Text(
                              "Sign Up",
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
