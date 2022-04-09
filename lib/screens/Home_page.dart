import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/services/AuthService_controller.dart';
import 'package:login_app/services/database.dart';
import 'package:login_app/shared/dialog_controller.dart';
import 'package:login_app/shared/drawer.dart';
import 'package:login_app/shared/loading.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  //AuthServiceControllerProvider model;

  HomePage({required this.uid});
  final String uid;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // String photoURL = model.userModel?.pictureModel as String;
    // String name = model.userModel?.name as String;
    // String email = model.userModel?.email as String;
    var taskcollections = FirebaseFirestore.instance.collection('tasks');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthServiceControllerProvider().signout();
              },
              icon: Icon(Icons.exit_to_app))
        ],
        title: Text('data'),
      ),
      drawer: drawers(),
      body: StreamBuilder<QuerySnapshot>(
        stream: taskcollections
            .doc(widget.uid)
            .collection('tasks')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot dsnapshot = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => EditNote(docEdit: dsnapshot),
                    //     ));
                  },
                  child: Card(
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(dsnapshot['tasks']),
                  ),
                );
              },
            );
          } else {
            return Loading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() => showDialog(
              context: context,
              builder: (BuildContext context) {
                String uid = widget.uid;
                return DialogContainer(
                  uid: widget.uid,
                );
              }))),
    );
  }
}
