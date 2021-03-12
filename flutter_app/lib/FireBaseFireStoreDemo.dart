import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/api.dart';
import 'package:flutterapp/models/Student.dart';

class FireBaseFireStoreDemo extends StatefulWidget {
  FireBaseFireStoreDemo() : super();
  final String title = "Students List";
  @override
  FireBaseFireStoreDemoState createState() => FireBaseFireStoreDemoState();
}

class FireBaseFireStoreDemoState extends State<FireBaseFireStoreDemo> {

  bool _validate = false;
  bool showTextField = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController admissionController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController averageController = TextEditingController();

  bool isEditing = false;
  Student currentStudent;

  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getStudents(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          print("Documents ${snapshot.data.documents.length}");
          return buildList(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final student = Student.fromSnapshot(data);
    return Padding(
      key: ValueKey(student.admissionNo),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(student.name,style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.black,size: 30,),
            onPressed:  () {
              checkDelete(data);
            },
          ),
          onTap: () {
            //update
            setUpdateUI(student);
          },
        ),
      ),
    );
  }

  Future<void> checkDelete(DocumentSnapshot data) async {
    final student = Student.fromSnapshot(data);
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0))
          ),
          title: Text('Delete ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                deleteStudent(student);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  setUpdateUI(Student student) {
    admissionController.text = student.admissionNo;
    nameController.text = student.name;
    mobileController.text = student.mobileNo;
    averageController.text = student.average;
    addressController.text = student.address;

    setState(() {
      showTextField = true;
      isEditing = true;
      currentStudent = student;
    });
  }

  add() {
    if (isEditing) {
      updateStudent(
          currentStudent,
          admissionController.text,
          nameController.text,
          mobileController.text,
          addressController.text,
          averageController.text);
      setState(() {
        isEditing = false;
      });
    } else {
      print("Before add");
      addStudent(admissionController.text, nameController.text,
          mobileController.text, addressController.text, averageController.text);
      print("Add successful");
    }
    admissionController.text = '';
    nameController.text = '';
    mobileController.text = '';
    addressController.text = '';
    averageController.text = '';
  }

  button() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.indigo,
        child: Text(isEditing ? "UPDATE" : "ADD",
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),),
        onPressed: () {
          add();
          checkAdd();
          setState(() {
            showTextField = false;
            admissionController.text.isEmpty ? _validate = true : _validate = false;
            nameController.text.isEmpty ? _validate=true : _validate = false;
            averageController.text.isEmpty ? _validate=true : _validate = false;
            mobileController.text.isEmpty ? _validate=true : _validate = false;
            addressController.text.isEmpty ? _validate=true : _validate = false;
          });
        },
      ),
    );
  }

  Future<void> checkAdd() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0))
          ),
          //backgroundColor: Colors.blue,
          title: Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Student Added Successfully.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add,size: 35,),
            onPressed: () {
              setState(() {
                showTextField = !showTextField;
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            showTextField
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextFormField(
                      controller: admissionController,
                      decoration: InputDecoration(
                          labelText: "Admission No",
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: "Enter Admission No"),
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "Student Name",
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: "Enter Student Name"),
                    ),
                    TextFormField(
                      controller: mobileController,
                      decoration: InputDecoration(
                          labelText: "Mobile Number",
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: "Enter students mobile number"),
                      keyboardType: TextInputType.number,
                    ),

                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                          labelText: "Address",
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: "Enter students address"),
                    ),

                    TextFormField(
                      controller: averageController,
                      decoration: InputDecoration(
                          labelText: "Average",
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: "Enter students average"),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                button(),
              ],
            )
                : Container(),
            SizedBox(
              height: 20,
            ),
            Text(
              "STUDENTS LIST",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: buildBody(context),
            ),
          ],
        ),
      ),
    );
  }
}
