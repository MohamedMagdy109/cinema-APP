import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecproject/Pages/Setup/signIn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String _email , _password ,_confirmpassword;
final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
var passKey = GlobalKey<FormFieldState>();


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
              // validator: (input){
              //   if(input.length<6){
              //     return 'your password needs to be least at 6 character';
              //   }
              // } ,
              // onSaved: (input) => _password = input,
              onChanged: (value){
                    this._password=value;  // this.
                  },
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,  
            ),
            TextFormField(
              // validator: (confirmation ){
              //   if(confirmation != _password ){
              //     return 'your password not confirm';
              //   }
              // } ,
              // onSaved: (input) => _confirmpassword,
              onChanged: (value){
                    this._confirmpassword=value;  // this.
                  },
              decoration: InputDecoration(
                labelText: 'Re Type Password'
              ),
              obscureText: true,  
            ),
            RaisedButton(
              onPressed: cheek,
              child: Text('Sign up'),
            )
          ],
        ),
      ),
    );
  }
  void cheek(){
                  if(_password == _confirmpassword){
                   signUp();
                

                   
                  }else{
                     print(_password);
                   print(_confirmpassword);
                   print("wrongpassword");
                   dialogTigger(context);

                  }
                }

    void signUp() async {
    if(_formkey.currentState.validate()){ 
      _formkey.currentState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        user.sendEmailVerification();
        // Display for the user that we send an email
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())) ;
               //Todo: Navigate to home
      }catch(e){
        print(e.message);
      }
    }
  }
  Future<bool>dialogTigger(BuildContext context){
  return showDialog(
    barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text('', style: TextStyle(fontSize: 15.0),),
          content: Text('password doesnt match'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('ok'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      }
  );
}
}  