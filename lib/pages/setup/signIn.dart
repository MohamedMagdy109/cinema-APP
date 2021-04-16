import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecproject/Pages/home.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

String _email , _password;
final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formkey, //el mas2ol 3n save form
        child: Column(
          children: <Widget>[  //bktb t7teeh el design
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'please type an Email';
                }
              } ,
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextFormField(
              validator: (input){
                if(input.length<6){
                  return 'your password needs to be least at 6 character';
                }
              } ,
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign In'),
            )
          ],
        ),
      ),
    );
  }

    Future<void> signIn() async {
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user))) ;
               //Todo: Navigate to home
      }catch(e){
        print(e.message);
      }
    }
  }
}