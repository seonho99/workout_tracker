import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workout_tracker/data/services/firebase_auth_service.dart';
import 'package:workout_tracker/data/services/firebase_storage_service.dart';
import 'package:workout_tracker/pages/frame_page.dart';
import 'package:workout_tracker/show_snackbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  final auth = FirebaseAuthService();
  final storage = FirebaseStorageService();
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? profileImageURL;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    setState(() {
      _isUploading = true;
    });

    try{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String? downloadURL = await storage.uploadProfileImage(
          File(pickedFile.path), auth.user?.uid);

      await auth.updatePhotoUrl(downloadURL);

      setState(() {
        profileImageURL = downloadURL;
      });
    }
  } catch(e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      _isUploading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = auth.user?.displayName;
    email = auth.user?.email;
    profileImageURL = auth.user?.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: profileImageURL != null
                            ? NetworkImage(profileImageURL!)
                            : const AssetImage('assets/me.jpg'),
                        child:
                            _isUploading
                          ? CircularProgressIndicator()
                            : Icon(Icons.camera_alt, size: 30, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () async{
                              try {
                                await auth.deletePhotoUrl();
                                await storage.deleteProfileImage(auth.user?.uid);
                              } catch(e){
                                showSnackBar(context, e.toString());
                              }
                              setState(() {
                                profileImageURL = null;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              TextFormField(
                enabled: false,
                initialValue: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@example.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('이메일 인증을 안하셨나요?'),
                  TextButton(
                    onPressed: () {
                      if(auth.user?.emailVerified??false){
                        showSnackBar(context, '이미 인증된 사용자입니다.');
                        return;
                      }
                      try {
                        auth.sendVerificationEmail();
                        showSnackBar(context, '인증 이메일이 다시 전송되었습니다.');
                      } catch (e){
                        showSnackBar(context, e.toString());
                      }
                    },
                    child: Text(
                      'Send Email',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      auth.updateName(name).then((_) {
                        showSnackBar(context, '수정되었습니다.');
                      }).catchError((e) {
                        showSnackBar(context, e.toString());
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    '수정',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      try {
                        await auth.signOut();
                        context.go('settings/login');
                      } catch (e){
                        showSnackBar(context, e.toString());
                      }
                    },
                    child: Text(
                      '로그아웃',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Text('|'),
                  TextButton(
                    onPressed: () async {
                      try {
                        await auth.deleteAccount();
                        showSnackBar(context, '탈퇴처리가 완료되었습니다.');
                        context.go('settings/login');
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }
                    },
                    child: Text(
                      '회원탈퇴',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
