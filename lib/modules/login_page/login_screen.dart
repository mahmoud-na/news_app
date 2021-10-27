import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordIsShown = true;
  var emailTextFormFieldController = TextEditingController();
  var passwordTextFormFieldController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                      textEditingController: emailTextFormFieldController,
                      textInputType: TextInputType.emailAddress,
                      labelText: 'Email Address',
                      prefixIcon: const Icon(Icons.email),
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Address must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      textEditingController: passwordTextFormFieldController,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: passwordIsShown,
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordIsShown = !passwordIsShown;
                          });
                        },
                        icon: passwordIsShown
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print(emailTextFormFieldController.text);
                        print(passwordTextFormFieldController.text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Register Now'),
                      ),
                    ],
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
