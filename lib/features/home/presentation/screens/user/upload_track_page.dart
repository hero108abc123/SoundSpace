import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';

class UploadTrackPage extends StatefulWidget {
  const UploadTrackPage({Key? key}) : super(key: key);

  @override
  _UploadTrackPageState createState() => _UploadTrackPageState();
}

class _UploadTrackPageState extends State<UploadTrackPage> {
  String? imagePath;
  String? audioPath;
  String title = '';
  String lyrics = '';

  Future<void> _pickImage() async {
    final pickedFile =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.files.single.path;
      });
    }
  }

  Future<void> _pickAudio() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowedExtensions: ['mp3'],
    );
    if (pickedFile != null) {
      setState(() {
        audioPath = pickedFile.files.single.path;
      });
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon/playlist/icon Back.png',
                      height: 26,
                      width: 26,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Upload Track',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: imagePath == null
                          ? const Icon(Icons.camera_alt,
                              size: 50, color: Colors.black54)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(imagePath!),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Title',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickAudio,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          audioPath != null
                              ? (audioPath!.split('/').last.length > 25
                                  ? '${audioPath!.split('/').last.substring(0, 22)}...'
                                  : audioPath!.split('/').last)
                              : 'Select MP3 file',
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.audiotrack, color: Colors.black54),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    lyrics = value;
                  });
                },
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter lyrics...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Upload',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
