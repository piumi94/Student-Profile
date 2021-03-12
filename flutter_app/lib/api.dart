import 'package:cloud_firestore/cloud_firestore.dart';
import './models/Student.dart';

String collectionName = "Students";

getStudents() {
  print('GET STUDENTS');
  return Firestore.instance.collection(collectionName).snapshots();
}

getSortedRatings(){
  return Firestore.instance.collection(collectionName).orderBy('average').snapshots();
}

addStudent(String admissionNo,String name,String mobileNo,String address,String average){
  Student student = Student(admissionNo: admissionNo,name: name,mobileNo:mobileNo,address:address,average:average);
  try{
    Firestore.instance.runTransaction(
          (Transaction transaction) async{
        await Firestore.instance
            .collection(collectionName)
            .document()
            .setData(student.toJson());
      },
    );
  } catch(e){
    print(e.toString());
  }
}

updateStudent(Student student, String admissionNo, String name, String mobileNo,String address, String average){
  try {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.update(student.documentReference, {'name': name,'admissionNo':admissionNo,'mobileNo': mobileNo,'average':average,'address':address});
    });
  } catch(e) {
    print(e.toString());
  }
}

deleteStudent(Student student){
  Firestore.instance.runTransaction(
        (Transaction transaction) async{
      await transaction.delete(student.documentReference);
    },
  );
}