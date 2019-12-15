import 'package:flutter/material.dart';
import 'package:sekolahku_sqlite/ListStudent.dart';
import 'package:toast/toast.dart';
 
class Login extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}
 
class LoginState extends State<Login> {
  
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  bool _secureText = true;

  final _username = TextEditingController();
  final _password = TextEditingController();

  final FocusNode _textUsername = FocusNode();  
  final FocusNode _textPassword = FocusNode(); 

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  login(){
    if(_username.text == "admin" && _password.text == "Admin"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListStudent()),
      );
    } else {
      Toast.show("Username atau passwod yang Anda masukan salah!", 
      context, 
      backgroundColor: Colors.purple,
      duration: Toast.LENGTH_SHORT, 
      gravity:  Toast.BOTTOM);
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formStateKey,
        autovalidate: false,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25.0),
              ),
              Hero(
                tag: 'hero',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Icon(Icons.school, size: 100, color: Colors.purple,),
                ),
              ),
              SizedBox(height: 24.0),
              Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "SEKOLAHKU",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              TextFormField(
                controller: _username,
                keyboardType: TextInputType.text,
                autofocus: false,
                focusNode: _textUsername,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context, _textUsername, _textPassword);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Username wajib diisi';
                  }
                  if (value.trim() == "")
                    return "Only Space is Not Valid!!!";
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Username',
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  suffixIcon: Icon(Icons.person),
                ),
              ),
              // spasi
              SizedBox(height: 8.0),
              TextFormField(
                autofocus: false,
                obscureText: _secureText,
                controller: _password,
                keyboardType: TextInputType.text,
                focusNode: _textPassword,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context, _textPassword, _textUsername);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Password wajib diisi';
                  }
                  if (value.trim() == "")
                    return "Only Space is Not Valid!!!";
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  suffixIcon: IconButton(
                      onPressed: showHide,
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                  ),
                ),
              ),
              // spasi
              SizedBox(height: 24.0),
              // tombol
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: Colors.purple.shade100,
                  elevation: 5.0,
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    onPressed: () {
                      if (_formStateKey.currentState.validate()) {
                          _formStateKey.currentState.save();
                          login();
                        }
                    },
                    color: Colors.purple,
                    child: Text('Log In', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                ),
              ),
            ],
          )
        )
      ),
    );
    }
}