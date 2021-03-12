import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formkey,
          child: Center(
            child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: Image.asset('assets/happy-student.png',
                        width: 300, height: 300),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text('SUNSHINE ENGLISH', style: TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold, fontSize: 25
                    ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text('MEDIUM SCHOOL', style: TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold, fontSize: 25
                    ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                    child: TextFormField(
                      validator: (input){
                        if(input.isEmpty){
                          return 'Please enter your email';
                        }
                      },
                      onSaved: (input)=> _email = input,
                      decoration: InputDecoration(
                          labelText: 'Email'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: TextFormField(
                      validator: (input){
                        if(input.isEmpty){
                          return 'Please enter your password';
                        }
                      },
                      onSaved: (input)=> _password = input,
                      decoration: InputDecoration(labelText: 'Password'
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
                    child:ButtonTheme(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: signIn,
                        textColor: Colors.white,
                        color: Colors.indigo,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          //),
        ));
  }

  Future<FirebaseUser> signIn() async{
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try {

        final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
        AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password);
        FirebaseUser user = result.user;

        print('USER SUCCESSS'+ user.email);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => new Home(user: user)),
        );
      }catch (e){
        print(e.message+'Error');
      }
    }
  }
}