import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotomag3/services/auth.dart';

class AuthorizationPage extends StatefulWidget{
  AuthorizationPage({key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage>{

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String  _password;
  bool showLogin = true;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          child: Align(
            child: Text('IN_PRINT', style: TextStyle(
                fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white)
            ),
          ),
        ),
      );
    }

    Widget _imput(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1)
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: icon,
                ),
              )
          ),
        ),
      );
    }

    Widget _button(String text, void func()) {
      return RaisedButton(
        splashColor: Theme
            .of(context)
            .primaryColor,
        highlightColor: Theme
            .of(context)
            .primaryColor,
        color: Colors.white,
        child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: Theme
                .of(context)
                .primaryColor, fontSize: 20)
        ),
        onPressed: () {
          func();
        },
      );
    }

    Widget _form(String lable, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: _imput(
                  Icon(Icons.person), "LOGIN", _emailController, false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: _imput(
                  Icon(Icons.lock), "PASSWORD", _passwordController, true),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: _button(lable, func),
              ),
            )
          ],
        ),
      );
    }

    void _signInButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;
      dynamic user = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());
      if(user == null)
        Fluttertoast.showToast(
            msg: "Can't SignIn you! Please check your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16.0
        );
      else{
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;
      dynamic user = await _authService.registerWithEmailAndPassword(_email.trim(), _password.trim());
      if(user == null)
        Fluttertoast.showToast(
            msg: "Can't Register you! Please check your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      else{
        _emailController.clear();
        _passwordController.clear();
      }
    }




    Widget _buttonWave(){
      return Expanded(
        child: Align(
          child: ClipPath(
            child: Container(
              color: Colors.white,
              height: 300,
            ),
            clipper: BottomWaveClipper(),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    }


    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          _logo(),
          SizedBox(height: 100,),
          (
            showLogin
            ? Column(
              children: <Widget>[
                _form('LOGIN', _signInButtonAction),
                Padding(
                  padding : EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Text('Not registered yet? Register!', style: TextStyle(fontSize: 20, color: Colors.white),),
                    onTap:() {
                      setState((){
                      showLogin = false;
                      });
                    }
                  ),
                )
              ],
            )
            : Column(
              children: <Widget>[
                _form('REGISTOR', _registerButtonAction),
                Padding(
                  padding : EdgeInsets.all(10),
                  child: GestureDetector(
                      child: Text('Alredy registered? Login!', style: TextStyle(fontSize: 20, color: Colors.white),),
                      onTap:() {
                        setState((){
                          showLogin = true;
                        });
                      }
                  ),
                )
              ],
            )
          ),
          _buttonWave()
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path. lineTo(0.0, size.height);
    path. lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width/10), size.height/5);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondEndPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dx);
    return path;
  }



  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}
