import 'package:flutter/material.dart';
import 'package:flutter_form/pages/dashboard.dart';
import 'package:flutter_form/utils/auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatelessWidget {
  static String id = "login_page";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Login/Register'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Register'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              LoginForm(),
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final GlobalKey<FormBuilderFieldState> _formKey =
      GlobalKey<FormBuilderFieldState>();

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldForm(
            labelText: "Email",
            hintText: "name@gmail.com",
            onChanged: (value) {},
          ),
          SizedBox(height: 15.0),
          TextFieldForm(
            labelText: "Password",
            hintText: "Enter your password",
            onChanged: (value) {},
            obscureText: true,
          ),
          SizedBox(height: 15.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () async {
              _formKey.currentState?.save();
              if (_formKey.currentState?.validate() == true) {
                final v = _formKey.currentState?.value;
                var result = await _auth.singInEmailAndPassword(
                    v?['Email'], v?['Password']);

                if (result == 1) {
                  _showPopup(context);
                } else if (result == 2) {
                  _showPopup(context);
                } else if (result != null) {
                  Navigator.popAndPushNamed(context, Dashboard.id);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormBuilderFieldState> _formKey =
      GlobalKey<FormBuilderFieldState>();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldForm(
            labelText: "Name",
            hintText: "John Doe",
            onChanged: (value) {},
          ),
          SizedBox(height: 15.0),
          TextFieldForm(
            labelText: "Email",
            hintText: "name@gmail.com",
            onChanged: (value) {},
          ),
          SizedBox(height: 15.0),
          TextFieldForm(
            labelText: "Password",
            hintText: "Enter your password",
            onChanged: (value) {},
            obscureText: true,
          ),
          SizedBox(height: 15.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            child: Text(
              "Register",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () async {
              _formKey.currentState?.save();
              if (_formKey.currentState?.validate() == true) {
                final v = _formKey.currentState?.value;
                var result = await _auth.createAcount(
                    v?['Name'], v?['Email'], v?['Password']);

                if (result == 1) {
                  _showPopup(context);
                } else if (result == 2) {
                  _showPopup(context);
                } else if (result != null) {
                  Navigator.popAndPushNamed(context, Dashboard.id);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class TextFieldForm extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final bool obscureText;

  const TextFieldForm({
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

void _showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(''),
        content: Text('Something is wrong, please try again'),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
