import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/Login_Page.dart';

class MainDrawer extends StatefulWidget {

  const MainDrawer({Key key,this.user1});
  final FirebaseUser user1;
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.indigo,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage('https://image.shutterstock.com/image-photo/happy-young-indian-business-woman-600w-1443633284.jpg'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text('it1010@my.sliit.lk',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person,color: Colors.indigo,),
            title: Text('Profile',style: TextStyle(fontSize: 18),),
            onTap: (){
            },
          ),
          ListTile(
            leading: Icon(Icons.settings,color: Colors.indigo,),
            title: Text('Settings',style: TextStyle(fontSize: 18),),
            onTap: (){
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back,color: Colors.indigo,),
            title: Text('Logout',style: TextStyle(fontSize: 18),),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => LoginPage()
              ));
            },
          ),
        ],
      ),
    );
  }
}

