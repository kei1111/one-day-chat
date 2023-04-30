import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  final Function updateUser;

  const EditProfileScreen({required this.user, required this.updateUser});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late File _profileImage;
  String _name = '';
  String _bio = '';
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.user.username;
    _bio = widget.user.bio;
  }

  _handleImageFromGallery() async {}

  _displayProfileImage() {
    if (_profileImage == null) {
      if (widget.user.profileImageUrl.isEmpty) {
        return const AssetImage('assets/images/user_placeholder.jpg');
      } else {
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    } else {
      return FileImage(_profileImage);
    }
  }

  _submit() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading
                ? LinearProgressIndicator(
                    backgroundColor: Colors.blue[200],
                    valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: _displayProfileImage(),
                    ),
                    ElevatedButton(
                      onPressed: _handleImageFromGallery,
                      child: Text(
                        'Change Profile Image',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16.0),
                      ),
                    ),
                    TextFormField(
                      initialValue: _name,
                      style: const TextStyle(fontSize: 18.0),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          size: 30.0,
                        ),
                        labelText: 'Name',
                      ),
                      validator: (input) => input!.trim().isEmpty
                          ? 'Please enter a valid name'
                          : null,
                      onSaved: (input) => _name = input!,
                    ),
                    TextFormField(
                      initialValue: _bio,
                      style: const TextStyle(fontSize: 18.0),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.book,
                          size: 30.0,
                        ),
                        labelText: 'Bio',
                      ),
                      validator: (input) => input!.trim().length > 150
                          ? 'Please enter a bio less than 150 characters'
                          : null,
                      onSaved: (input) => _bio = input!,
                    ),
                    Container(
                      margin: const EdgeInsets.all(40.0),
                      height: 40.0,
                      width: 250.0,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text(
                          'Save Profile',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
