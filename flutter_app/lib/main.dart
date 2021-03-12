import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/FireBaseFireStoreDemo.dart';
import 'package:flutterapp/Grading.dart';
import 'package:flutterapp/MyProfile.dart';
import 'package:flutterapp/Rating_Bar.dart';
import 'package:flutterapp/Splash_Screen.dart';
import 'package:flutterapp/main_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        "/secondPage": (context) => FireBaseFireStoreDemo(),
        "/homePage": (context) => Home(),
        "/profile": (context) => MyProfile(),
        "/grading" : (context) => Grading(),
        "/performance": (context) => RatingBar()
      },
    );
  }
}

class Home extends StatefulWidget {

  const Home({Key key,this.user});
  final FirebaseUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home', style: TextStyle(color: Colors.indigo)
          ),
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.indigo),
        ),
        drawer: MainDrawer(),
        body: Container(
          color: Colors.white,
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Image.asset('assets/girl-icon.png'),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                      child: Text('WELCOME ${widget.user.email}',style:
                      TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color:
                      Colors.indigo)),
                    ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.indigo,
                        child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Image.asset('assets/unnamed.png'),
                                    iconSize: 65,
                                    tooltip: 'Closes application',
                                    onPressed: () {
                                      print('Pressed Profile');
                                      Navigator.pushNamed(context, '/profile');
                                    },
                                  ),
                                  Text(
                                    'Profile',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]))),
                    Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.indigo,
                        child: Center(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Image.asset(
                                        'assets/Food-List-Ingredients-icon.png'),
                                    iconSize: 65,
                                    tooltip: 'Closes application',
                                    onPressed: () {
                                      print('Pressed List');
                                      Navigator.pushNamed(context, '/secondPage');
                                    },
                                  ),
                                  Text(
                                    'Student List',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]))),
                    Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.indigo,
                        child: Center(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Image.asset(
                                        'assets/126425.png'),
                                    iconSize: 65,
                                    tooltip: 'Closes application',
                                    onPressed: () {
                                      print('Pressed Performance');
                                      Navigator.pushNamed(context, '/performance');
                                    },
                                  ),
                                  Text(
                                    'Performance',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]))),
                    Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.indigo,
                        child: Center(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Image.asset(
                                        'assets/attendance-icon-png-7.png'),
                                    iconSize: 65,
                                    tooltip: 'Closes application',
                                    onPressed: () {
                                      print('Pressed Attendance');
                                      Navigator.pushNamed(context, '/grading');
                                    },
                                  ),
                                  Text(
                                    'Student Rating',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]))),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
