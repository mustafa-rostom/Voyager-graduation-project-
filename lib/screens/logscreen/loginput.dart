import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../tabs_screen.dart';
import '../../API/API.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class LogInput extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateLogInput();
  }

}
class StateLogInput extends State<LogInput>{
  @override
  void initState() {
    super.initState();
    _getData();
  }

  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  bool _isLoading=false;
  var error;

  var accepted;
  bool storedPassword=false;
  _getData()async{
    SharedPreferences localStorage=await SharedPreferences.getInstance();
    print(localStorage.getString("password"));
    if(localStorage.getString('password')!=null){
      storedPassword=true;
        emailController.text=localStorage.getString('email');
        passwordController.text=localStorage.getString('password');
        forLogin(context);

    }



  }
   _alertStorePassword(BuildContext context){
     Alert(
       context: context,
       type: AlertType.warning,
       title: "Save Password",
       desc: "Do you want to save password",
       buttons: [
         DialogButton(
           child: Text(
             "Yes",
             style: TextStyle(color: Colors.white, fontSize: 20),
           ),
           onPressed: _saveData,
           color: Color.fromRGBO(0, 179, 134, 1.0),
         ),
         DialogButton(
           child: Text(
             "No",
             style: TextStyle(color: Colors.white, fontSize: 20),
           ),
           onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TabsScreen())),
           gradient: LinearGradient(colors: [
             Color.fromRGBO(116, 116, 191, 1.0),
             Color.fromRGBO(52, 138, 199, 1.0)
           ]),
         )
       ],
     ).show();

    }

  _saveData()async{

    SharedPreferences localStorage=await SharedPreferences.getInstance();
    localStorage.setString('email', emailController.text);
    localStorage.setString('password', passwordController.text);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TabsScreen()));

  }
   _showChoiceDialog(BuildContext context){
    Alert(
      context: context,
      type: AlertType.error,
      title: "error ",
      desc: "Connection failed",
      buttons: [
        DialogButton(
          child: Text(
            "ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
            setState(() {
              _isLoading=false;
            });
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),

      ],
    ).show();
  }

  forLogin(BuildContext context) async {

    setState(() {
      _isLoading=true;
    });
    _setHeaders()=>{
      'Content-type' : 'application/json',
    };
    var data = {

      'email': emailController.text,

      'password': passwordController.text,

    };
    const String mainUrl ="auth/login";

     try{
       var res = await CallApi().postData(data,mainUrl,_setHeaders());




       var body = json.decode(res);



       accepted=body["success"];


       if (accepted!=null) {
//        SharedPreferences localStorage=await SharedPreferences.getInstance();
//        localStorage.setString('token', body['token']);
//        localStorage.setString('user', json.encode(body['user']));
         print(body['success']['token']);
         SharedPreferences tokenLocalStorage=await SharedPreferences.getInstance();
         tokenLocalStorage.setString('token', body['success']['token']);
         if(storedPassword==true){
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TabsScreen()));

         }else{
           _alertStorePassword(context);

         }

       }
       else {
         setState(() {

           error = body['error'];
           print("\n");
           print(error);
           _isLoading=false;

         });
       }
//      }

     }catch(error){
       print("\n$error");

          _showChoiceDialog(context);

     }


  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width:  MediaQuery.of(context).size.width*.84,
                      height: MediaQuery.of(context).size.height*0.075,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          // border: Border.all(style: BorderStyle.none,color: Colors.white),
                          color: Color(0xFFF4F8FF)
                      ),
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                            color: Color(0xFFAAADAD)
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0,top: 17.5,bottom: 17.5),
                          labelText: 'email address' ,
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFAAADAD),
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ) ,
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26.0)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD7D7D7),),
                              borderRadius: BorderRadius.all(Radius.circular(26.0))
                          ),
                        ),
                        controller: emailController,
                        //  onSubmitted: (_) => _submitData() ,


                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.025,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*.84,
                      height: MediaQuery.of(context).size.height*0.075,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          //  border: Border.all(width: 5),
                          color: Color(0xFFF4F8FF)
                      ),
                      // color: Color(0xFFF4F8FF),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                            color: Color(0xFFAAADAD)
                        ),
                        decoration: InputDecoration(
                          labelText: 'password',
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFAAADAD),
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ) ,
                          contentPadding: EdgeInsets.only(left: 20.0,top: 17.5,bottom: 17.5),
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26.0)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD7D7D7)),
                              borderRadius: BorderRadius.all(Radius.circular(26.0))
                          ),

                        ),

                        controller: passwordController,
                        //  onSubmitted: ,

                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent, // makes highlight invisible too
                      child: Text(
                        'Forgot Password?' ,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                            fontSize: 13,

                            color: Color(0xFF4F4F4F)
                        ),
                      ),
                      onTap: (){},
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.67,
                        child:
                        error!=null ?
                        Text("* Email or Password is incorret",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),
                        )
                            : null
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height*0.03,
            ),
            Center(
              child: Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width:  MediaQuery.of(context).size.width*0.86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(50.0),
                    //shadowColor: Theme.of(context).accentColor,
                    color: Color(0xFF3FCC59),
                    //Theme.of(context).primaryColor,
                    //  elevation: 7.0,
                    child: MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent, // makes highlight invisible too
                      colorBrightness: Brightness.light,
                      onPressed: _isLoading ? null :()=>forLogin(context),
                      child:_isLoading ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "logining...",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18.0,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w600
                            ),


                            //   style: Theme.of(context).textTheme.button,
                          ),
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),

                          ),

                        ],
                      )
                          : Text(
                        "login",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.0,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w600
                        ),


                        //   style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

}