import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/api.dart';
import 'package:flutterapp/models/Student.dart';

class Grading extends StatefulWidget {
  @override
  _GradingState createState() => _GradingState();
}

class _GradingState extends State<Grading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grading List'),backgroundColor: Colors.indigo,),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getSortedRatings(),
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

    return Padding(
      key: ValueKey(std.admissionNo),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),

      child:  Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(
            std.name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          trailing: Text(
            std.average,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}