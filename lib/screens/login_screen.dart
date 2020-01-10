



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';


import 'package:digicard/animation/Fadeanimation.dart';

final startColor = Color(0xFFaa7ce4);
final endColor = Color(0xFFe46792);
final titleColor = Color(0xff444444);
final textColor = Color(0xFFa9a9a9);
final shadowColor = Color(0xffe9e9f4);


class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  bool showSpinner=false;
  
  
  
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: showSpinner,
      child:  Scaffold(
      
     resizeToAvoidBottomPadding: false,
      body: Container(
       width:double.infinity,
        decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      colors: [startColor,endColor],
    )
        ),
        child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 40,),
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           FadeAnimation( 1,Text('Login',style: TextStyle(color: shadowColor, fontSize: 40,fontFamily: 'Karla2'),)),
            SizedBox(height:10.0),
            FadeAnimation (1.3,Text('Welcome To Digicard',style: TextStyle(color:shadowColor, fontSize: 18,fontFamily: 'Karla'),)),
          ],
        ),
      ),
      SizedBox(height: 20,),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(55), topRight: Radius.circular(55)),
          ),
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                SizedBox(height: 60,),
               FadeAnimation(1.4, Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(
                      color: Color.fromRGBO(225, 95, 27, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10)
                    )],
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200],
                            )
                          ),
                        ),
                        child:TextField(
                          
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        
                      ),
                     
                     keyboardType: TextInputType.emailAddress,
                     onChanged: (value) {
                      //Do something with the user input.
                         _email=value;
                      },   
                    ), 
                   ),

                   Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200],
                            )
                          ),
                        ),
                        child:TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none
                      ),
                      obscureText: true,
                        onChanged: (value) {
                     //Do something with the user input.
                      _password=value;
                       },
                    ), 
                   ),
                    ],
                  ),
                )),
                SizedBox(height: 40,),
                Container(
              height: 45,
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 50),


              child:RaisedButton(
               
                shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(50.0)
                   ),
                  child:Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), 
                 color:endColor,
                onPressed: ()async{

                   setState(() {
                  showSpinner=true;
                });
                  try{
                  final user = await _auth.signInWithEmailAndPassword(email: _email,password: _password);
                 if(user!=null)
                 {
                   Navigator.of(context).pushNamed('/homepage');
                 }
                  setState(() {
                  showSpinner=false;
                }); 
                  }
                  catch(e)
                  {
                    print(e);
                  }
                 

                },

              ),
            ),
            SizedBox(height: 20,),
          FadeAnimation (1.7,Text("Create an Account?", style: TextStyle(color: textColor),),),
            SizedBox(height: 10,),

             FadeAnimation(1.8,Container(
              height: 45,
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child:RaisedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/signup');
                },
                shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(50.0)
                   ),
                  child:Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), 
                color:endColor,
              ),
            ),),
              ],
            ),
          ),
        ),
      ),

    ],
        ),
      ),
    ),
      );
  }
}
