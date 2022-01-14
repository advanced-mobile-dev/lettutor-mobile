import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/widgets/network_circle_avatar.dart';

class UserProfileHeader extends StatefulWidget {
  final User user;
  final Function(XFile) onPickedImage;
  UserProfileHeader({this.user, this.onPickedImage});

  @override
  State<UserProfileHeader> createState() => _UserProfileHeaderState();
}

class _UserProfileHeaderState extends State<UserProfileHeader> {
  XFile _pickedFile;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      GestureDetector(
        onTap: () async {
          try {
            final ImagePicker _picker = new ImagePicker();
            final pickedFile = await _picker.pickImage(
              source: ImageSource.gallery,
            );
            widget.onPickedImage(pickedFile);
            setState(() {
              _pickedFile = pickedFile;
            });
          } catch (e) {
            print(e);
          }
        },
        child: Stack(
          children: <Widget>[
            _pickedFile == null
                ? NetworkCircleAvatar(url: widget.user.avatar, radius: 35)
                : CircleAvatar(
                    radius: 35,
                    backgroundImage: Image.file(
                      File(_pickedFile.path),
                      height: 120,
                      width: 120,
                    ).image,
                    backgroundColor: Colors.transparent,
                  ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  child: Icon(
                    Icons.edit,
                    size: 15,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ))
          ],
        ),
      ),
      SizedBox(
        width: 15,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.user.name, style: Theme.of(context).textTheme.bodyText1),
          SizedBox(
            height: 5,
          ),
          Text(widget.user.email, style: Theme.of(context).textTheme.bodyText2)
        ],
      )
    ]);
  }
}
