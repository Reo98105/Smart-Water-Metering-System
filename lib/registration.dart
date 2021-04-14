import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swms_user_auth_module/login.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/DAO/regislogDAO.dart';
import 'package:swms_user_auth_module/showAlert.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  User user;
  RegislogDAO regisDAO = new RegislogDAO();
  ShowAlert showAlert = new ShowAlert();
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isCheck = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller1;
  TextEditingController _controller2;
  TextEditingController _controller3;
  TextEditingController _controller4;

  @override
  void initState() {
    //start listen and make user.username default text become _controller1
    if (widget.user == null) widget.user = new User.def();
    _controller1 = TextEditingController();
    _controller1.text = widget.user.username;
    _controller2 = TextEditingController();
    _controller2.text = widget.user.password;
    _controller3 = TextEditingController();
    _controller3.text = widget.user.email;
    _controller4 = TextEditingController();
    widget.user.nric = int.tryParse(_controller4.text);
    super.initState();
  }

  @override
  void dispose() {
    //clean up controller when widget is removed
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                autofocus: true,
                controller: _controller1,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Username';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                controller: _controller2,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                controller: _controller3,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Email address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: TextFormField(
                controller: _controller4,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                decoration: InputDecoration(
                  labelText: 'NRIC',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter NRIC';
                  }
                  return null;
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                    child: ElevatedButton.icon(
                      //go to _handleRegister function..
                      onPressed: isCheck
                          ? () {
                              _handleRegister(context);
                            }
                          : null,
                      icon: Icon(Icons.app_registration),
                      label: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[400],
                        elevation: 5.0,
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      icon: Icon(Icons.cancel),
                      label: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[400],
                        elevation: 5.0,
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 100.0, 5.0, 5.0),
              child: CheckboxListTile(
                value: isCheck,
                onChanged: (bool value) {
                  setState(
                    () {
                      isCheck = value;
                    },
                  );
                },
                title: Text(
                  'By clicking Register, you agree to our Terms and that you have read our Data Use Policy, including our Cookie Use.',
                  style: TextStyle(fontSize: 12.0),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.lightBlueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //handle registration event
  Future<void> _handleRegister(BuildContext context) async {
    if (_formKey.currentState.validate())
      widget.showAlert.showLoadingDialog(context);
    String username = _controller1.text;
    String password = _controller2.text;
    String email = _controller3.text;
    int nric = int.tryParse(_controller4.text);
    try {
      widget.user = new User(username, nric, password, email);
      int result = await widget.regisDAO.registerUser(widget.user);
      print(result);
      if (result == 1) {
        Navigator.of(_formKey.currentContext, rootNavigator: true)
            .pop(); //close the dialog
        widget.showAlert.showRSuccess(context);
      } else {
        Navigator.of(_formKey.currentContext, rootNavigator: true)
            .pop(); //close the dialog
        AlertDialog alert = AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: Text('Back to login'),
            ),
          ],
          backgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: new Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text('Something went wrong! Try again later!'),
              ),
            ],
          ),
        );
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }
}
