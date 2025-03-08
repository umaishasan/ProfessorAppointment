import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myacademicappointment/Components/CommonComponent.dart';
import 'package:myacademicappointment/Firebase/FirebaseServices.dart';
import 'package:myacademicappointment/Models/Person.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController qualification = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Person>(context);
    return Scaffold(
      body: Stack(
        children: [
          CommonComponent.AppBarCreator(
              context, "Profile", Icons.arrow_back, () => backToHome(context)),
          Center(
            // Edit profile card
            child: SingleChildScrollView(
              child: Column(
                // Profile Card
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 115, horizontal: 24),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Light shadow
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 4), // Position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        //Profile Image
                        Stack(children: [
                          CommonComponent.ImageAvatar(
                              context, userData.UserImage, 90, 90),
                          Positioned(
                            top: 55,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                EditImage();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(
                                      107, 117, 117, 117), // Background color
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ]),

                        //labels
                        const SizedBox(height: 13),
                        Text(
                          userData.User,
                          style: const TextStyle(
                            fontFamily: 'Heebo',
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF080808),
                          ),
                        ),

                        //Text fields
                        const SizedBox(height: 24),
                        _buildInfoField('Name:', name, userData.Name),
                        //const SizedBox(height: 16),
                        //_buildInfoField('Email:', email, userData.Email),
                        const SizedBox(height: 16),
                        _buildInfoField('Phone:', phone, userData.Phone),
                        const SizedBox(height: 16),
                        _buildInfoField('Gender:', gender, userData.Gender),
                        const SizedBox(height: 16),
                        _checkQualification(userData.User, userData.User)
                      ],
                    ),
                  ),
                  // Edit Profile Button
                  //Align(
                  //alignment: Alignment.center,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SizedBox(
                      width: 231,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          EditProfile(
                              userData.Id,
                              name.text,
                              qualification.text,
                              phone.text,
                              gender.text,
                              userData.Email,
                              userData.User,
                              userData.UserImage);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF32983E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _checkQualification(String userdata, String showTxtInitial) {
    if (userdata == "Teacher") {
      //const SizedBox(height: 16);
      return _buildInfoField('Qual.:', qualification, showTxtInitial);
    } else {
      return const SizedBox.shrink();
    }
  }

//Common Widget For TextFields
  Widget _buildInfoField(
      String label, TextEditingController value, String showTxtInitial) {
    value.text = showTxtInitial;
    return Row(
      children: [
        SizedBox(
          width: 76,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Heebo',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0x9ED9D9D9),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: TextField(
                controller: value,
                decoration: const InputDecoration(border: InputBorder.none),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void backToHome(BuildContext context) {
    CommonComponent.BacktoHome(context);
  }

  void EditProfile(String id, String userName, String qualification,
      String phone, String gender, String email, String user, String imagUrl) {
    FirebaseServices.UpdateUserProfile(
            id, userName, qualification, phone, gender)
        .then((value) {
      CommonComponent.uploadImage(id, userName);
      Provider.of<Person>(context, listen: false).updateUserData({
        "Id": id,
        "Username": userName,
        "User": user,
        "Email": email,
        "Phone": phone,
        "Gender": gender,
        "Qualification": qualification,
        "UserImage": imagUrl
      });
      CommonComponent.BacktoHome(context);
    });
    print(
        "Id: ${id}, Name: ${userName}, Qualification: ${qualification}, Gender: ${gender}");
  }

  void EditImage() {
    CommonComponent.PickImage();
  }
}
