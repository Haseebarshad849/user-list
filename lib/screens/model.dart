import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model/screens/editUser.dart';
import 'package:model/screens/login.dart';
import 'package:model/services/auth.dart';
import 'package:model/services/cloudStore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Model extends StatefulWidget {
  @override
  _ModelState createState() => _ModelState();
}

class _ModelState extends State<Model> {
  List userProfilesList = [];
  String name = '';
  String phone = '';
  String gender = '';

  get() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    print(uid);
    print("_____+++===============");
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) {
        Map m = value.data();
        setState(() {
          name = m['name'];
          phone = m['phoneNo'].toString();
          gender = m['gender'];
        });
      });
      print("_____+++===============");
    } catch (e) {
      print(e.toString());
    }
  }

  // .orderBy('name', descending: false)
  // .limit(6);

  @override
  void initState() {
    get();
    super.initState();

    // fetchUserInfo();
    fetchDatabaseList();
  }

  // fetchUserInfo() async {
  //   FirebaseAuth.instance.currentUser.uid;
  //   // User getUser = FirebaseAuth.instance.currentUser;
  //   // userID = getUser.uid;
  // }

  fetchDatabaseList() async {
    dynamic resultant = await CloudStore().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      // setState(() {
      userProfilesList = resultant;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          RaisedButton(
            onPressed: () {
              EditUser(update: fetchDatabaseList).openDialogueBox(context);
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            color: Colors.black,
          ),
          RaisedButton(
            onPressed: () {
              AuthService().signOut().whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogIn(),
                  ),
                );
              });
            },
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            color: Colors.black,
          )
        ],
      ),
      body: Container(
        child: ListTile(
          title: Text(name),
          subtitle: Text(phone),
          leading: CircleAvatar(
            child: Image(
              image: AssetImage('assets/images/Profile_Image.png'),
            ),
          ),
          trailing: Text(gender),
        ),
        //==========================================
        //==== STREAM BUILDER FOR ALL USERS=======
        //==========================================
        // child: StreamBuilder(
        //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Text("Error getting data");
        //     } else if (snapshot.connectionState == ConnectionState.waiting) {
        //       return SpinKitWave(
        //         color: Colors.red,
        //         size: 50.0,
        //       );
        //     }
        //     return Card(
        //       child: ListView(
        //         children: snapshot.data.docs.map((DocumentSnapshot document) {
        //           return ListTile(
        //             title: Text(document.data()['name']),
        //             subtitle: Text(document.data()['phoneNo'].toString()),
        //             leading: CircleAvatar(
        //               child: Image(
        //                 image: AssetImage('assets/images/Profile_Image.png'),
        //               ),
        //             ),
        //             trailing: Text(document.data()['gender']),
        //           );
        //         }).toList(),
        //       ),
        //     );
        //   },
        // ),

        // //=============================================
        //================ LIST VIEW BUILDER===========
        //=============================================
        // child: ListView.builder(
        //   itemCount: userProfilesList.length,
        //   itemBuilder: (context, index) {
        //     return Card(
        //       child: ListTile(
        //         title: Text(userProfilesList[index]['name']),
        //         subtitle: Text(userProfilesList[index]['phoneNo'].toString()),
        //         // title: Text(userProfilesList.toString()),
        //         leading: CircleAvatar(
        //           child: Image(
        //             image: AssetImage('assets/images/Profile_Image.png'),
        //           ),
        //         ),
        //         trailing: Text(userProfilesList[index]['gender']),
        //       ),
        //     );
        //   },
        // ),
      ), //BODY CONTAINER
    );
  }
}
