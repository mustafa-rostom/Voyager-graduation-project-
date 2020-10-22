import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../screens/login.dart';
import '../API/API.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum SingingSex { male, female }


class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateLogin();
  }
}
class _StateLogin extends State<Signup>{
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  DateTime _recentDate;


  var errorName;
  var errorEmail;
  var errorPass;
  var errorPhone;
  var errorGender;
  var errorBD;

  bool _isLoading = false;


  SingingSex _characterSex = SingingSex.male;

  String birthDate ;

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime(2002),
        firstDate: DateTime(1960),
        lastDate: DateTime(2002)
    ).then((pickedDate){
      if(pickedDate==null)
      {
        return ;
      }
      setState(() {
        _recentDate=pickedDate;
        birthDate=DateFormat.yMd().format(pickedDate);
        print(birthDate);
      });
    });
  }
  _saveData()async{
    SharedPreferences localStorage=await SharedPreferences.getInstance();
    localStorage.clear();
    localStorage.setString('email', emailController.text);
    localStorage.setString('password', passwordController.text);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
  }

   _showAlertView(BuildContext context){

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
          onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login())),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
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
  handleLogin() async {
    String gender;
 setState(() {
   _isLoading=true;
 });
 if(_characterSex==SingingSex.male)

     gender="male";
  else
    gender="female";

    var dateAfterMyFormat= _recentDate.toString();
print(dateAfterMyFormat);
    _setHeaders()=>{
      'Content-type' : 'application/json',
      'Accept' : 'application/json'
    };
    var data = {
      'name': fullNameController.text,
      'email': emailController.text,
      'phone_number':  phoneNumberController.text,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text,
      'gender': gender,
      //_characterSex.toString(),
      'date_of_birth': dateAfterMyFormat
      //birthDate
    };
    const String mainUrl ="auth/register";
   try{ var res = await CallApi().postData(data,mainUrl,_setHeaders());

    var body = json.decode(res);

    print(body);

    print(body['token']);
    print(body['user']);
    print("\n");
    print(body["success"]);
    String success = body["success"];
    print(success);


    if (body["success"] == "true") {
      _showAlertView(context);

      print(body['token']['token']);
      print(body['user']);
    }
    else {
      setState(() {
        errorName = body['errors']['name'];
        print("\n");
        print(errorName);
        errorEmail = body['errors']['email'];
        print("\n");
        print(errorEmail);
        errorPass = body['errors']['password'];
        print("\n");
        print(errorPass);
        errorPhone = body['errors']['phone_number'];
        print("\n");
        print(errorPhone);
        errorGender = body['errors']['gender'];
        print("\n");
        print(errorGender);
        errorBD = body['errors']['date_of_birth'];
        print("\n");
        print(errorBD);
        _isLoading = false;
      });
    }

}catch(error){
    print("\n$error");

    _showChoiceDialog(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color(0xFFE5E5E5),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.075,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              height: 50.0,
              width: 120.0,
              child: Text('Sign Up',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 30.0,
                    color: Color(0xFF3FCC59)
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.035,),
            Center(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.87,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.86,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.075,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          //  border: Border.all(width: 5),
                          color: Color(0xFFF4F8FF)
                      ),
////////////////////////////////////////////////////////////////////////////name
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                            color: Color(0xFFAAADAD)
                        ),

                        decoration: InputDecoration(
                          labelText: 'full name',
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFAAADAD),
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 20.0, top: 17.5, bottom: 17.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorName != null
                                      ? Colors.red
                                      : Color(0xFFD7D7D7)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(26.0))
                          ),
                        ),
                        controller: fullNameController,
                      ),
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.67,
                        child:
                        errorName!=null ?
                        Text(
                          "* ${errorName[0]}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),
                        )
                            : null
                    ),
                    SizedBox(height: 18.0,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.87,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.075,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          //  border: Border.all(width: 5),
                          color: Color(0xFFF4F8FF)
                      ),
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                            color: Color(0xFFAAADAD)
                        ),
                        decoration: InputDecoration(
                          labelText: 'email address',
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFAAADAD),
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 20.0, top: 17.5, bottom: 17.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorEmail != null
                                      ? Colors.red
                                      : Color(0xFFD7D7D7)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(26.0))
                          ),
                        ),
                        controller: emailController,
                      ),
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.67,

                        child:
                        errorEmail!=null ?
                        Text(
                          "* ${errorEmail[0]}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),
                        )
                            : null
                    ),
                    SizedBox(height: 22.0,),

                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.87,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.075,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(color: errorBD != null
                              ? Colors.red:
                          Color(0xFFD7D7D7))
//                          color: Color(0xFFF4F8FF)
                      ),

                      child: Material(
                        borderRadius: BorderRadius.circular(26.0),
                        //shadowColor: Theme.of(context).accentColor,
                        color: Color(0xFFF4F8FF),
                        //Theme.of(context).primaryColor,

                        child: MaterialButton(

                            onPressed: ()=>_presentDatePicker(),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.calendar_today, color: Color(0xFFAAADAD),size: 30.0,),
SizedBox(width: 20.0,),
                                    Text(_recentDate==null ? 'Birth Date' : DateFormat.yMd().format(_recentDate),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFAAADAD),
                                      fontSize: 15,
                                    ),

                                ),

                              ],
                            )

                          //   style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.67,

                        child:
                        errorBD!=null ?
                        Text(
                          "* ${errorBD[0]}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),
                        )
                            : null
                    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.87,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.075,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          //  border: Border.all(width: 5),
                          color: Color(0xFFF4F8FF)
                      ),
                      child: TextFormField(
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
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 20.0, top: 17.5, bottom: 17.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorPass != null
                                      ? Colors.red
                                      : Color(0xFFD7D7D7)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(26.0))
                          ),
                        ),
                        controller: passwordController,

                      ),
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.67,

                        child:
                        errorPass!=null ?
                        Text
                          ("* $errorPass",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),
                        )
                            : null
                    ),
                    SizedBox(height: 22.0,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.87,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.075,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          //  border: Border.all(width: 5),
                          color: Color(0xFFF4F8FF)
                      ),
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                            color: Color(0xFFAAADAD)
                        ),
                        decoration: InputDecoration(
                          labelText: 'confirm password',
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFAAADAD),
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 20.0, top: 17.5, bottom: 17.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorPass != null
                                      ? Colors.red
                                      : Color(0xFFD7D7D7)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(26.0))
                          ),
                        ),
                        controller: confirmPasswordController,

                      ),
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.67,
                        child:
                        errorPass!=null ?
                        Text(
                          "* $errorPass",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),
                        )
                            : null
                    ),
                    SizedBox(height: 22.0,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.87,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.075,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          //  border: Border.all(width: 5),
                          color: Color(0xFFF4F8FF)
                      ),
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                            color: Color(0xFFAAADAD)
                        ),
                        decoration: InputDecoration(
                          labelText: 'phone number(optional)',
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFAAADAD),
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 20.0, top: 17.5, bottom: 17.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorPhone != null
                                      ? Colors.red
                                      : Color(0xFFD7D7D7)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(26.0))
                          ),
                        ),
                        controller: phoneNumberController,

                      ),
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.67,
                        child:
                        errorPhone!=null ?
                        Text("* ${errorPhone[0]}\n"
                            "* ${errorPhone[1]}",
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
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.02),
            //////////////////////////////////////////////////////////////////////Radio buttons
            Container(
              padding: EdgeInsets.only(left: 40.0),
              decoration: BoxDecoration(
                //      border: Border.all(width: 5)
              ),
              child: Row(children: <Widget>[


                    Padding(
                      padding: const EdgeInsets.only(right: 55.0),
                      child: Text('Sex:',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.left,

                      ),
                    ),

                  Radio(
                    value: SingingSex.male,
                    groupValue: _characterSex,
                    onChanged: (SingingSex value) {
                      setState(() {
                        _characterSex = value;
                      });
                    },
                  ),
                  Text(
                    'Male',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500

                    ),
                  ),
                  Radio(
                    value: SingingSex.female,
                    groupValue: _characterSex,
                    onChanged: (SingingSex value) {
                      setState(() {
                        _characterSex = value;
                      });
                    },
                  ),


                  Text(
                    'Female',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500


                    ),
                  ),

              ],
              ),
            ),

                  SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01,
                  ),
            Center(
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.07,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.86,
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
                      highlightColor: Colors.transparent,
                      // makes highlight invisible too
                      onPressed: _isLoading ? null : handleLogin,
                      child: Text(
                        _isLoading ? "signing..." : " Sign Up",
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
        )

    )
    ;
  }
}