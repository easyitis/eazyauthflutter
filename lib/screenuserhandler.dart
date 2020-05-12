import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';
import 'shared.dart';
import 'usermodel.dart';

class UserHandlerScreen extends StatefulWidget {
  UserHandlerScreen({Key key}) : super(key: key);

  @override
  _UserHandlerScreenState createState() => _UserHandlerScreenState();
}

class _UserHandlerScreenState extends State<UserHandlerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample User Login'),
        // backgroundColor: Colors.white,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Theme.of(context).primaryColor),
        iconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      body: UserLoginLogout(),
    );
  }
}

class UserLoginLogout extends StatefulWidget {
  UserLoginLogout({Key key}) : super(key: key);

  @override
  _UserLoginLogoutState createState() => _UserLoginLogoutState();
}

class _UserLoginLogoutState extends State<UserLoginLogout> {
  final _formKey = GlobalKey<FormState>();
  final _myEmailController = TextEditingController();
  final _myPasswordController = TextEditingController();
  bool _userIsThere = ((userId ?? 0) != 0);
  bool _showPassword = false;
  int _foundUser = userId;
  String _enteredEmail = userEmail;
  String _enteredPassword = "";
  String _messageToShow = "Some Text";
  bool _processing = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _myEmailController.dispose();
    _myPasswordController.dispose();
    super.dispose();
  }

  _forgetMe(BuildContext context) async {
    setState(() {
      _userIsThere = false;
      _showPassword = false;
      _foundUser = 0;
      _enteredEmail = "";
      _myEmailController.text = "";
      _messageToShow = "User details cleared";
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(_messageToShow),
          backgroundColor: Theme.of(context).primaryColor,
        ));
    });
  }

  _findMe(BuildContext context) async {
    _enteredEmail = _myEmailController.text;
    setState(() {
      _processing = true;
    });
    if (_formKey.currentState.validate()) {
      print(_myEmailController.text);
      _foundUser = await getUserByEmail(
          http.Client(), _myEmailController.text, easyauthSampleId);
      setState(() {
        _processing = false;
        _userIsThere = true;
        _showPassword = true;
        _messageToShow = "User validation required";
        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(_messageToShow),
            backgroundColor: Theme.of(context).primaryColor,
          ));
      });
    }
  }

  _verifyMe(BuildContext context) async {
    _enteredPassword = _myPasswordController.text;
    setState(() {
      _processing = true;
    });
    if (_formKey.currentState.validate()) {
      final _verified = await checkUserPassword(http.Client(), _enteredEmail,
          _myPasswordController.text, easyauthSampleId);
      if (_verified) {
        userId = _foundUser;
        userEmail = _enteredEmail;
      }

      setState(() {
        _processing = false;
        _myPasswordController.text = '';
        _userIsThere = true;
        _showPassword = !_verified;
        _enteredPassword = "";
        _messageToShow =
            _verified ? "User verified" : "Please re-enter secret key";
        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(_messageToShow),
            backgroundColor: Theme.of(context).primaryColor,
          ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _myEmailController.text = _enteredEmail;
    _myPasswordController.text = _enteredPassword;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                cursorColor: Theme.of(context).primaryColor,
                enabled: ((_foundUser == 0) && !_processing),
                autofocus: (_foundUser == 0),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      _userIsThere ? "You're logged in as" : "Enter email",
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                controller: _myEmailController,
                // initialValue: 'abc',
                validator: (value) {
                  if (value.isEmpty || !isEmail(value)) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              // ),
              Visibility(
                visible: _showPassword,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    enabled: !_processing,
                    keyboardType: TextInputType.text,
                    cursorColor: Theme.of(context).primaryColor,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Verify email using secret key",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    controller: _myPasswordController,
                    // initialValue: 'abc',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter secret key';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Visibility(
                visible: !_userIsThere && !_showPassword,
                child: RaisedButton(
                  // color: Theme.of(context).primaryColor,
                  child: Text('Find Me'),
                  onPressed: _processing
                      ? null
                      : () {
                          _findMe(context);
                        },
                ),
              ),
              Visibility(
                visible: !_userIsThere && !_showPassword,
                child: Text(
                    "This is the first step where the user enters their email address. Your app needs to trigger the 'find' API with the user's email address and your unique integraiton ID. The API searches for the email address, creates a user record if it doesn't exist and returns a unique user ID. You can use this user ID in your app to store other user properties."),
              ),
              Visibility(
                visible: _showPassword,
                child: RaisedButton(
                  // color: Theme.of(context).primaryColor,
                  child: Text('Verify'),
                  onPressed: _processing
                      ? null
                      : () {
                          _verifyMe(context);
                        },
                ),
              ),
              Visibility(
                visible: _showPassword,
                child: Text(
                    "In this step, the user enters the secret key received by email. Your app needs to trigger the 'verify' API with the user's email address, the secret key and your unique integraiton ID. The API returns a verified / not verified status. Based on that you take further action - such as storing the user ID in local memory."),
              ),
              Visibility(
                visible: _userIsThere && !_showPassword,
                child: RaisedButton(
                  // color: Theme.of(context).primaryColor,
                  child: Text('Forget Me'),
                  onPressed: _processing
                      ? null
                      : () {
                          _forgetMe(context);
                        },
                ),
              ),
              Visibility(
                visible: _userIsThere && !_showPassword,
                child: Text(
                    'At this point, the user is already verified and your app can perform actions specific to the user. The forget action shown above is app specific and no API needs to be called for this.'),
              ),
              Visibility(
                visible: _processing,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
