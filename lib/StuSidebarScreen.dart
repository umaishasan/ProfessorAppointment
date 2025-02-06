import 'package:flutter/material.dart';

class StudentSidebar extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final VoidCallback? onHomePressed;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onDiscussionPressed;
  final VoidCallback? onAppointmentPressed;
  final VoidCallback? onLogoutPressed;

  const StudentSidebar({
    super.key,
    this.name = "Maria Jason",
    this.role = "Student",
    this.imageUrl =
        "https://dashboard.codeparrot.ai/api/image/Z6UKasNJMVoCot_D/user-imag.png",
    this.onHomePressed,
    this.onProfilePressed,
    this.onDiscussionPressed,
    this.onAppointmentPressed,
    this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      color: Colors.white,
      child: Column(
        children: [
          // Profile Section
          Container(
            height: 256,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[300]!,
                  const Color(0xFF277B31),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 53),
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Heebo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Heebo',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          // Navigation Items
          const SizedBox(height: 11),
          _buildNavItem(
              'Home',
              'https://dashboard.codeparrot.ai/api/image/Z6UKasNJMVoCot_D/vector.png',
              onHomePressed),
          // _buildNavItem(
          //     'Profile',
          //     'https://dashboard.codeparrot.ai/api/image/Z6UKasNJMVoCot_D/vector-2.png',
          //     onProfilePressed),
          // _buildNavItem(
          //     'Discussion',
          //     'https://dashboard.codeparrot.ai/api/image/Z6UKasNJMVoCot_D/vector-3.png',
          //     onDiscussionPressed),
          // _buildNavItem(
          //     'Appointment',
          //     'https://dashboard.codeparrot.ai/api/image/Z6UKasNJMVoCot_D/vector-4.png',
          //     onAppointmentPressed),

          //const Spacer(),

          // Logout Button
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 20, left: 38),
          //   child: _buildNavItem(
          //       'Logout',
          //       'https://dashboard.codeparrot.ai/api/image/Z6UKasNJMVoCot_D/vector-5.png',
          //       onLogoutPressed),
          // ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, String iconPath, VoidCallback? onPressed) {
    return Row(
      children: [
        //padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        InkWell(
          onTap: onPressed,
        ),
        //icon path

        Image.network(
          iconPath,
          width: 25,
          height: 25,
          color: Colors.black,
        ),
        const SizedBox(width: 24),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Heebo',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    // return InkWell(
    //   onTap: onPressed,
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
    //     child: Row(
    //       children: [
    //
    //
    //
    //       ],
    //     ),
    //   ),
    // );
  }
}
