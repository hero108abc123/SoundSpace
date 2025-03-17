import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/edit_profile.dart';
import '../../../../../config/theme/app_pallete.dart';

class EditProfilePage extends StatefulWidget {
  final Profile user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
              AppPallete.gradient4,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Setting(
          user: widget.user,
        ),
      ),
    );
  }
}

class Setting extends StatelessWidget {
  final Profile user;
  const Setting({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 10),
                _buildAvatarSection(context),
                const SizedBox(height: 10),
                const EditProfile(
                    nameTitle: 'Full Name',
                    title: 'FullName',
                    icon: Icon(Icons.person)),
                const EditProfile(
                    nameTitle: 'Display Name',
                    title: 'DisplayName',
                    icon: Icon(Icons.person_2)),
                const EditProfile(
                    nameTitle: 'Gender',
                    title: 'Gender',
                    icon: Icon(Icons.man)),
                const EditProfile(
                    nameTitle: 'Age', title: 'Age', icon: Icon(Icons.cake)),
                const SizedBox(height: 20),
                _buildSaveButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              'assets/images/icon/playlist/icon Back.png',
              width: 26,
              height: 25.08,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Edit Profile',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const CircleAvatar(
              radius: 46,
              backgroundImage: AssetImage('assets/images/Billielish3.jpg'),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 3,
            child: IconButton(
              icon: const Icon(
                Icons.camera_enhance,
                color: Color.fromARGB(255, 180, 180, 180),
                size: 30,
              ),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              tooltip: 'Change Avatar',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: Text(
          'Save',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
