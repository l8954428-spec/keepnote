// pages/signup_page.dart
import 'package:flutter/material.dart';
import 'package:notes/Services/Logic_Impl.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  LogicImpl impl = LogicImpl();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<LogicImpl>(
      builder: (BuildContext context, logic, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Register',
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
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // First Name
                    CustomInput(
                      controller: _firstNameController,
                      labelText: 'First Name',
                      hintText: 'Enter your first name',
                      prefixIcon: Icons.person_outline,
                      onChanged: (x) {},
                      validator: (x) {
                        if (x!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Last Name
                    CustomInput(
                      controller: _lastNameController,
                      labelText: 'Last Name',
                      hintText: 'Enter your last name',
                      prefixIcon: Icons.person_outline,
                      validator: (x) {
                        if (x!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Email Address
                    CustomInput(
                      controller: _emailController,
                      labelText: 'Email Address',
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (x) {
                        if (x!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Phone Number
                    CustomInput(
                      controller: _phoneController,
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (x) {
                        if (x!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password
                    CustomInput(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      validator: (x) {
                        if (x!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Confirm Password
                    CustomInput(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password', // an
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      validator: (x) {
                        if (x!.isEmpty) {
                          return 'Required';
                        }
                        if (x != _passwordController.text) {
                          return 'Mismatch';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    // Sign Up Button
                    CustomButton(
                      text: 'Sign Up',
                      isLoading: logic.loading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {


                          await logic.registerUser(
                            userModel: UserModel(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              password: _passwordController.text,
                            ), context: context,
                          );
                          // if (result.first == true) {
                          //   setState(() {
                          //     loading= false;
                          //   });
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${result.last}'),backgroundColor: Colors.green,));
                          // }else{
                          //   setState(() {
                          //     loading= false;
                          //   });
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${result.last}'),backgroundColor: Colors.red,));
                          //
                          // }
                          // debugPrint('email:${user?.email}'); 8869151655
                        }
                      },
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      height: 54,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),

                    const SizedBox(height: 20),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}