import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => new _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  File _image;
  Future getImage(bool isCamera) async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    setState(() {
      _image = image;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Colors.indigo,
      ),
    body: StreamBuilder <QuerySnapshot>(
    stream: Firestore.instance.collection('Profile_Info').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData)
        return Text('Loading data... Please Wait..');
      return Column(
       children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/girl-icon.png'),
            ),
          ),
         IconButton(
           icon: Icon(Icons.camera_alt),
           onPressed: (){
             getImage(true);
           },
         ),
          _image == null? Container() : Image.file(_image,
            height: 300.0,
            width: 300.0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(snapshot.data.documents[0]['name'],
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'SourceSansPro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 25.0),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: ListTile(
              leading: Text(
                'Address : ' + snapshot.data.documents[0]['address'],
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: ListTile(
              leading: Text(
              'Contact No: ' + snapshot.data.documents[0]['contactNo'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: ListTile(
              leading: Text(
              'Birth Date: ' + snapshot.data.documents[0]['birthDate'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18
                ),
              ),
            ),
          ),
        ],
      );
    },
    )
    );
  }
}