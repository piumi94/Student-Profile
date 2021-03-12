import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/api.dart';
import 'package:flutterapp/models/Student.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RatingBar extends StatefulWidget {
  final double rate;
  RatingBar({Key key,this.rate});

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review'),backgroundColor: Colors.indigo,),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getStudents(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          print("Documents ${snapshot.data.documents.length}");
          return _buildList(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );
  }


  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context,DocumentSnapshot data) {
    final std = Student.fromSnapshot(data);
    return RatingDialog(
      icon: const Icon(
        Icons.account_circle,
          size: 100,
          color: Colors.blue),
      title: "Rate "+ std.name,
      description:
      "How would you rate the student?",
      submitButton: "SUBMIT",
      positiveComment: "Good Performance :)",
      negativeComment: "Need Improvement :(",
      accentColor: Colors.yellow, // optional
      onSubmitPressed: (rating) {
        print("onSubmitPressed: rating = $rating");
        std.documentReference.updateData({'reviewTotal': rating});
      },
    );
  }
}