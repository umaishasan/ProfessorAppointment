import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myacademicappointment/Components/CommonComponent.dart';
import 'package:myacademicappointment/ForgetPasswordScreen.dart';
import 'package:myacademicappointment/Models/Person.dart';
import 'package:myacademicappointment/Firebase/FirebaseServices.dart';
import 'package:myacademicappointment/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  //static String User = "";

  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background ellipse
          Positioned(
            top: -18,
            left: -660,
            child: Container(
              width: 1027,
              height: 1701,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(73, 100, 188, 71),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Heading
                  const SizedBox(height: 90),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontFamily: 'Jaro',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),

                  // Email TextField
                  const SizedBox(height: 100),
                  _buildTextField("Enter Email", _emailController, false),

                  // Password TextField
                  const SizedBox(height: 18),
                  _buildTextField("Enter Password", _passwordController, true),

                  //Forget Password
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          forgetPasswordMethod();
                        },
                        child: const Text(
                          'Forget password',
                          style: TextStyle(
                            color: Color.fromARGB(204, 117, 110, 2),
                            fontSize: 16,
                            fontFamily: 'Heebo',
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Login Button
                  const SizedBox(height: 17),
                  SizedBox(
                    width: 276,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        loginMethod();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF32983E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Heebo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  //Don't have an account?
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Heebo',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          signupMethod();
                        },
                        child: const Text(
                          " SignUp",
                          style: TextStyle(
                            color: Color.fromARGB(204, 117, 110, 2),
                            fontSize: 16,
                            fontFamily: 'Heebo',
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          //circle
          progressCircle()
        ],
      ),
    );
  }

  //Widget _buildTextField(String hint, dynamic _txtController) {
  Widget _buildTextField(
      String hint, TextEditingController textController, bool isPassword) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
          color: const Color(0xFFE7E5E5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 1)),
      child: TextField(
        controller: textController,
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF7D7777),
            fontSize: 20,
            fontFamily: 'Heebo',
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget progressCircle() {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.black,
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ));
    } else {
      return Text("");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginMethod() async {
    setState(() {
      isLoading = true;
    });

    try {
      //signin account and save user
      Person? user = await FirebaseServices.SigninAccount(
          _emailController.text, _passwordController.text);

      //set user
      if (user != null) {
        Provider.of<Person>(context, listen: false).updateUserData({
          "Id": user.Id,
          "Username": user.Name,
          "Email": user.Email,
          "Phone": user.Phone,
          "Gender": user.Gender,
          "User": user.User,
          "Qualification": user.Qualification,
          "UserImage": user.UserImage
        });

        //waiting
        Future.delayed(const Duration(seconds: 1), () {
          checkScheduleChecker(user.User, user.Email, user.Name, [""], "",
              user.Qualification, user.UserImage);
        });
      }
    } catch (e) {
      print("Login error: ${e}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    //print("Name: ${user?.Name}, Email: ${user?.Email}, User: ${user?.User}, Gender: ${user?.Gender}");
  }

  void checkScheduleChecker(
      String user,
      String email,
      String name,
      List<String> dateTimes,
      String status,
      String qualification,
      String imageUrl) async {
    //check user teacher
    if (user == "Teacher") {
      //check account exist and schedule
      if (await FirebaseServices.IsAccountExistForSche()) {
        CommonComponent.CreateToast("Login Successfully");
        CommonComponent.BacktoHome(context);
      } else {
        await FirebaseServices.CreateScheduleUser(
            name, dateTimes, status, qualification, imageUrl);
        CommonComponent.CreateToast("Login Successfully");
        CommonComponent.BacktoHome(context);
      }
      //else user student
    } else {
      CommonComponent.CreateToast("Login Successfully");
      CommonComponent.BacktoHome(context);
    }
  }

  void signupMethod() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SignupScreen()));
  }

  void forgetPasswordMethod() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ForgetPasswordScreen(
                  email: _emailController.text,
                )));
  }
}
