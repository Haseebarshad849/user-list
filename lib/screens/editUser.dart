import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model/services/cloudStore.dart';

class EditUser {
  Function update;
  String userUid;
  EditUser({this.update});
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _phoneNo = TextEditingController();
  // TextEditingController _nameController = TextEditingController();

  openDialogueBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Edit User Details',
            ),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                  TextField(
                    controller: _genderController,
                    decoration: InputDecoration(hintText: 'Gender'),
                  ),
                  TextField(
                    controller: _phoneNo,
                    decoration: InputDecoration(hintText: 'Phone No'),
                  )
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  submitAction(context);

                  update();
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  updateData(String name, String gender, int phoneNo, String userID) async {
    await CloudStore().updateUserList(name, gender, phoneNo, userID);
  }

  submitAction(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    updateData(_nameController.text, _genderController.text,
        int.parse(_phoneNo.text), uid);
    _nameController.clear();
    _genderController.clear();
    _phoneNo.clear();
  }
}
