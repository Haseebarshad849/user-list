import 'package:cloud_firestore/cloud_firestore.dart';

class CloudStore {
  // Create a CollectionReference called users that references the firestore collection
  final users = FirebaseFirestore.instance.collection('users');
  //users = users.orderBy('name');

  Future<void> addUser(String email, String password, String name, String uid,
      String gender, int phoneNo) {
    // Call the user's CollectionReference to add a new user
    return users.doc(uid).set({
      'email': email, // Harshad@gmail.com
      'password': password, // Strong Password
      'name': name, // Haseeb Arshad
      'uid': uid,
      'gender': gender,
      'phoneNo': phoneNo,
    });
  }

  Future updateUserList(
      String name, String gender, int phoneNo, String uid) async {
    return await users
        .doc(uid)
        .update({'name': name, 'gender': gender, 'phoneNo': phoneNo});
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await users.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
