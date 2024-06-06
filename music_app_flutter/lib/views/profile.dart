import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app_flutter/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  static const routeName = "userprofile";

  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ScrollController _scrollController = ScrollController();
  File? _selectedImage;
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController();
  bool _nightMode = false;
  bool _notifications = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
    _loadPreferences();
  }

  void _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    if (imagePath != null) {
      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('profile_name') ?? '';
      _nightMode = prefs.getBool('night_mode') ?? false;
      _notifications = prefs.getBool('notifications') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 51.0,
                left: 14.0,
                right: 20.0,
              ),
              child: ListTile(
                title: Text(
                  'What do you need to do, Dinh Lam?',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 173, 181, 1.0)),
                ),
              ),
            ),
            _isEditing
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            fillColor: Color.fromRGBO(238, 238, 238, 1.0),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            label: Text("Capture"),
                            icon: Icon(Icons.camera),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                            label: Text("Gallery"),
                            icon: Icon(Icons.photo_library_outlined),
                          ),
                        ],
                      ),
                    ],
                  )
                : _selectedImage != null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(_selectedImage!),
                      )
                    : CircleAvatar(
                        radius: 80,
                        child: Icon(
                          Icons.person,
                          size: 80,
                        ),
                      ),
            SizedBox(height: 20),
            _isEditing
                ? ElevatedButton(
                    onPressed: () {
                      _saveChanges();
                    },
                    child: Text('Save Changes'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    child: Text('Edit Profile'),
                  ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  _buildSettingRow(Icons.nightlight, 'Night Mode', _nightMode,
                      (value) {
                    setState(() {
                      _nightMode = value;
                    });
                  }),
                  SizedBox(height: 8),
                  _buildSettingRow(
                      Icons.notifications, 'Notifications', _notifications,
                      (value) {
                    setState(() {
                      _notifications = value;
                    });
                  }),
                  SizedBox(height: 8),
                  _buildSettingRowWithIconButton(
                      Icons.privacy_tip, 'Private Account', () {
                    // Do something when Private Account is pressed
                  }),
                  SizedBox(height: 8),
                  _buildSettingRowWithIconButton(Icons.security, 'Security',
                      () {
                    // Do something when Security is pressed
                  }),
                  SizedBox(height: 8),
                  _buildSettingRowWithIconButton(Icons.language, 'Language',
                      () {
                    // Do something when Language is pressed
                  }),
                  SizedBox(height: 8),
                  _buildSettingRowWithIconButton(Icons.info, 'About Us', () {
                    // Do something when About Us is pressed
                  }),
                  SizedBox(height: 8),
                  _buildSettingRowWithIconButton(Icons.logout, 'Log Out', () {
                    _logout();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(
      IconData icon, String text, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(57, 62, 70, 1.0),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(238, 238, 238, 1.0),
            ),
            child: Icon(icon, color: Color.fromRGBO(34, 40, 49, 1.0)),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromRGBO(238, 238, 238, 1.0),
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color.fromRGBO(0, 173, 181, 1.0),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRowWithIconButton(
      IconData icon, String text, Function onPressed) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Color.fromRGBO(57, 62, 70, 1.0),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(238, 238, 238, 1.0),
              ),
              child: Icon(icon, color: Color.fromRGBO(34, 40, 49, 1.0)),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromRGBO(238, 238, 238, 1.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(source: source);
    if (xFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', xFile.path);
      setState(() {
        _selectedImage = File(xFile.path);
      });
    }
  }

  void _saveChanges() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_name', _nameController.text);
    await prefs.setBool('night_mode', _nightMode);
    await prefs.setBool('notifications', _notifications);

    setState(() {
      _isEditing = false;
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận"),
          content: Text("Bạn có chắc chắn muốn đăng xuất không?"),
          actions: [
            TextButton(
              onPressed: () async {
                await prefs.remove('user_token');
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text("Đồng ý"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Hủy"),
            ),
          ],
        );
      },
    );
  }
}
