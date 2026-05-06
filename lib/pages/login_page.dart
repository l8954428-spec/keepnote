// pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:notes/model/user_model.dart';
import 'package:notes/pages/signup_page.dart';
import 'package:notes/Services/Logic_Impl.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form.dart';
import 'notes_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final provider = Provider.of<LogicImpl>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    // provider.
    return Consumer<LogicImpl>(
      builder: (BuildContext context, logic, Widget? child) {
        return  Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Sign In ',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(color: Colors.grey[200], height: 1),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Email Address
                  CustomInput(
                    controller: _emailController,
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  // Password
                  CustomInput(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  const SizedBox(height: 32),

                  // Login Button
                  CustomButton(
                    text: 'Log In',
                    isLoading: logic.loading,
                    onPressed: () async {

                      await logic.login(
                          _emailController.text,
                          _passwordController.text,
                          context
                      );
                      // logic.login();
                      // if (result.first == true) {
                      //
                      //   final user = result.last as UserModel;
                      //   debugPrint('${user.email}');
                      //
                      // } else {
                      //   setState(() {
                      //     loading = false;
                      //   });
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text('wrong Email or password '),
                      //       backgroundColor: Colors.red,
                      //     ),
                      //   );
                      // }
                    },
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    height: 54,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),

                  const SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}