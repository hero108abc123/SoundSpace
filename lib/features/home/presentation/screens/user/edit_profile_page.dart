import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/presentation/bloc/user/user_bloc.dart';
import 'package:soundspace/features/home/presentation/widget/user_widget/edit_profile.dart';
import '../../../../../config/theme/app_pallete.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final Profile user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? avatarUrl;
  late TextEditingController displayNameController;
  late TextEditingController ageController;
  String gender = '';

  @override
  void initState() {
    super.initState();
    avatarUrl = widget.user.image;
    displayNameController = TextEditingController(text: widget.user.displayName);
    ageController = TextEditingController(text: widget.user.age.toString());
    gender = widget.user.gender;
  }

  @override
  void dispose() {
    displayNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void saveProfile() {
    if (avatarUrl == null || avatarUrl!.isEmpty) {
      showSnackBar(context, 'Please select an avatar');
      return;
    }

    context.read<UserBloc>().add(
          UserProfileUpdateRequested(
            displayName: displayNameController.text.trim(),
            age: int.tryParse(ageController.text.trim()) ?? widget.user.age,
            gender: gender,
            image: avatarUrl!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserProfileUpdateSuccess) {
          Navigator.pop(context);
        } else if (state is UserProfileUpdateFailure) {
          showSnackBar(context, state.message);
        }
      },
      child: Scaffold(
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
            displayNameController: displayNameController,
            ageController: ageController,
            gender: gender,
            onGenderChanged: (newGender) {
              setState(() {
                gender = newGender;
              });
            },
            avatarUrl: avatarUrl,
            onAvatarChanged: (newUrl) {
              setState(() {
                avatarUrl = newUrl;
              });
            },
            onSave: saveProfile,
          ),
        ),
      ),
    );
  }
}

class Setting extends StatelessWidget {
  final TextEditingController displayNameController;
  final TextEditingController ageController;
  final String gender;
  final ValueChanged<String> onGenderChanged;
  final String? avatarUrl;
  final ValueChanged<String> onAvatarChanged;
  final VoidCallback onSave;

  const Setting({
    super.key,
    required this.displayNameController,
    required this.ageController,
    required this.gender,
    required this.onGenderChanged,
    required this.avatarUrl,
    required this.onAvatarChanged,
    required this.onSave,
  });

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
                _buildAvatarSection(context),
                const SizedBox(height: 10),
                EditProfile(
                nameTitle: 'Display Name',
                controller: displayNameController,
                onChanged: (value) {},
              ),
              EditProfile(
                nameTitle: 'Gender',
                initialValue: gender,
                options: const ['Female', 'Male', 'Others', 'Prefer not to say'],
                onChanged: onGenderChanged,
              ),
              EditProfile(
                nameTitle: 'Age',
                controller: ageController, 
                onChanged: (value) {},
              ),

                const SizedBox(height: 20),
                _buildSaveButton(),
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
          CircleAvatar(
            radius: 65,
            backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                ? (avatarUrl!.startsWith('http')
                    ? NetworkImage(avatarUrl!) as ImageProvider
                    : FileImage(File(avatarUrl!)))
                : const AssetImage('assets/images/default_avatar.jpg'),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                onAvatarChanged(image.path);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: onSave,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        child: Text(
          'Save',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
