import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:voyager/screens/tabs_screen.dart';
import '../API/API.dart';
import 'package:intl/intl.dart';
import 'tripscreen/background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

class MakeTrip extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TripState();
  }

}
class _TripState extends State<MakeTrip>{

  final carModelController=TextEditingController();
  final priceController=TextEditingController();
  final messageController=TextEditingController();
  final dayController=TextEditingController();

  TimeOfDay _recentTime;
  DateTime _recentDate;

  static const provinceItems=<String>[
    "select",
    'Alexandria',
    'Aswan',
    "Asyut",
    'Beheira',
    'Beni Suef',
    'Cairo',
    'Dakahlia',
    'Damietta',
    'Faiyum',
    'Gharbia',
    'Giza',
    'Ismailia',
    'Kafr El Sheikh',
    'Luxor',
    'Matruh',
    'Minya',
    'Monufia',
    'New Valley',
    'North Sinai',
    'Port Said',
    'Qalyubia',
    'Qena',
    'Red Sea',
    'Sharqia',
    'Sohag',
    'South Sinai',
    'Suez',
  ];
  var startUp='select';
  var destination='select';
  List<String> _numOfPasses=["1","2","3","4"];
  var currentItemSelected='1';

  bool _isLoading=false;

  var errorFrom;
  var errorTo;
  var errorCarModel;
  var errorDate;
  var errorPrice;
  var errorDesc;
  void _tripTimePicker(){
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: prefix0.TextDirection.ltr,
          child: child,
        );
      },
    ).then((pickedTime){
      if(pickedTime==null)
      {
        return ;
      }
      setState(() {
        _recentTime=pickedTime;
      });
    });
  }
  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((pickedDate){
      if(pickedDate==null)
      {
        return ;
      }
      setState(() {
        _recentDate=pickedDate;
      });
    });
  }
  _showChoiceDialog(BuildContext context) {
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
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _isLoading = false;
            });
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),

      ],
    ).show();
  }
  postTrip() async {
    setState(() {
      _isLoading=true;
    });
    if(destination=="select"){
      setState(() {
        _isLoading=false;
        errorTo = "select the start";

      });
      return;
    }else  if(destination=="select"){
      setState(() {
        _isLoading=false;
        errorTo = "select the destination";

      });
      return;
    }
    SharedPreferences tokenLocalStorage = await SharedPreferences.getInstance();
    String currentToken = tokenLocalStorage.getString('token');
    String authentication = 'Bearer ' + currentToken;
    int userId=tokenLocalStorage.getInt("Id");
    var dateAfterMyFormat= _recentDate.add(Duration(hours: _recentTime.hour,minutes: _recentTime.minute,seconds: 0)).toString();


   // var dateAfterMyFormat = myFormat.parse("$_recentDate ");
    print("$dateAfterMyFormat");
    _setHeaders()=>{
      'Content-type' : 'application/json',
      'Accept' : 'application/x-www-form-urlencoded',
      "Authorization": authentication


    };
    var data = {
      'user_id': userId,
      'from': startUp,
      'to':  destination,
      'car_model': carModelController.text,
      'price_per_passenger': priceController.text,
      'number_of_empty_seats': currentItemSelected,
      'departure_date': dateAfterMyFormat,
      'description' : messageController.text
    };
    const String mainUrl ="trips";
    try{ var res = await CallApi().postData(data,mainUrl,_setHeaders());

    var body = json.decode(res);

    print(body);

    print(body['data']);
    print("\n");
    print(body["success"]);


    if (body["success"] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context)=>TabsScreen(),
        ),
      );

    }
    else  {
      setState(() {
        errorFrom = body['errors']['from'];
        print("\n");
        print(errorFrom);
        errorTo = body['errors']['to'];
        print("\n");
        print(errorTo);
        errorCarModel = body['errors']['car_model'];
        print("\n");
        print(errorCarModel);
        errorDate = body['errors']['departure_date'];
        print("\n");
        print(errorDate);
        errorPrice = body['errors']['price_per_passenger'];
        print("\n");
        print(errorPrice);
        errorDesc= body['errors']['description'];

        _isLoading = false;
      });
    }}catch(error){
      print("\n$error");

      _showChoiceDialog(context);
    }}


  Widget build(BuildContext context) {
    print('here is wedgit of maketrip');
print(_recentTime);
    return Scaffold(body: SingleChildScrollView(
      child: Column(children: <Widget>[

        Background(),

        SizedBox(
          height: 30,
        ),
/////////////////////////////////////////////////////////////////////////
        Container(
          width: MediaQuery.of(context).size.width* 0.86,
          height: 100,
          padding: EdgeInsets.only(left: 5.0,),
          child: Row(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width* 0.40,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
///////////////////////////////////////////////////////////////////// From
                  Container(
                    width: 48.0,
                    height: 29.0,
                    child: Text(
                      "From",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          color: Color(0xFF3FCC59),
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.start,
                    ),

                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 56.0,
                    width: MediaQuery.of(context).size.width* 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xFFE9EFF1),

                    ),
                    child:Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: DropdownButton<String>(
                        underline: null,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF839195),
                            fontSize: 18
                        ),
                        isExpanded: true,
                        items: provinceItems.map((String dropDownStringItems){
                          return DropdownMenuItem<String>(
                            value: dropDownStringItems,
                            child: Text(dropDownStringItems),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected){
                          if(newValueSelected!=destination)
                          setState(() {
                            this.startUp=newValueSelected;
                          });
                        },
                        value: startUp,
                      ),
                    ),
                  )
                  ,
                  SizedBox(
                    height: 1.0,
                  ),
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.40,
                      child:
                      errorFrom!=null ?
                      Text(
                        "* ${errorFrom[0]}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.red,
                            fontSize: 5,
                            fontWeight: FontWeight.w400
                        ),
                      )
                          : null
                  ),
                ],

              ),
            ),
///////////////////////////////////////////////////////////////////////
            SizedBox(
              width:  MediaQuery.of(context).size.width* 0.04,
            ),
/////////////////////////////////////////////////////////////////////////
            Container(
              width: MediaQuery.of(context).size.width* 0.40,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
/////////////////////////////////////////////////////////////////////// TO
                  Container(
                    width: 48.0,
                    height: 29.0,
                    child: Text(
                      "To",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          color: Color(0xFF3FCC59),
                          fontWeight: FontWeight.w600
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 56.0,
                    width: MediaQuery.of(context).size.width* 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        //  border: Border.all(width: 5),
                        color: Color(0xFFE9EFF1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: DropdownButton<String>(
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF839195),
                            fontSize: 18
                        ),
                        isExpanded: true,
                        items: provinceItems.map((String dropDownStringItems){
                          return DropdownMenuItem<String>(
                            value: dropDownStringItems,
                            child: Text(dropDownStringItems),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected){
                          if(newValueSelected!=startUp)
                          setState(() {
                            this.destination=newValueSelected;
                          });
                        },
                        value: destination,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.40,

                      child:
                      errorTo!=null ?
                      Text(
                        "* ${errorTo[0]}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.red,
                            fontSize: 5,
                            fontWeight: FontWeight.w400
                        ),
                      )
                          : null
                  ),
                ],

              ),

            )
          ],
          ),
        ),
        ////////////////////////////////////////////////////////////////////////////////
        SizedBox(
          height: 15,
        ),
        ///////////////////////////////////////////////////////////////////////////
        Container(
          width: MediaQuery.of(context).size.width* 0.86,
          height: 100,
          padding: EdgeInsets.only(left: 5.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
///////////////////////////////////////////////////////////////////////Car Model
              Container(
                width: 120.0,
                height: 29.0,
                child: Text(
                  "Car Model",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      color: Color(0xFF3FCC59),
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.start,
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 56.0,
                width: MediaQuery.of(context).size.width* 0.84,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xFFE9EFF1)
                ),
                child: TextFormField(

                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.characters,
                  autocorrect: true,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.0,
                    color: Color(0xFF839195),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.local_taxi),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: errorCarModel != null
                                ? Colors.red
                                : Color(0xFFD7D7D7)),
                        borderRadius: BorderRadius.all(
                            Radius.circular(30.0))                    ),
                    labelText: 'Car Model' ,
                    labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF839195),
                        fontSize: 18
                    ) ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),


                  ),
                  controller: carModelController,
                  //  onSubmitted: (_) => _submitData() ,
                ),
              ),
              SizedBox(
                height: 1.0,
              ),
              Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.66,

                  child:
                  errorCarModel!=null ?
                  Text(
                    "* ${errorCarModel[0]}",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.red,
                        fontSize: 5,
                        fontWeight: FontWeight.w400
                    ),
                  )
                      : null
              ),
            ],

          ),
        ),
////////////////////////////////////////////////////////////////////////////////////////////////////
        SizedBox(
          height: 15,
        ),
////////////////////////////////////////////////////////////////////////
        Container(
          width: MediaQuery.of(context).size.width* 0.86,
          height: 100,
          padding: EdgeInsets.only(left: 5.0,),
          child: Row(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width* 0.40,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
///////////////////////////////////////////////////////////////////////////////// EGPPRICE

                  Container(
                    width: 164.0,
                    height: 28.0,
                    child: Text(
                      "Price For Pass",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          color: Color(0xFF3FCC59),
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 56.0,
                    width: MediaQuery.of(context).size.width* 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xFFE9EFF1)
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                        color: Color(0xFF839195),
                      ),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorPrice != null
                                      ? Colors.red
                                      : Color(0xFFD7D7D7)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30.0))                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 17.5,horizontal: 40.0),
                          labelText: 'egp' ,
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF839195),
                              fontSize: 18
                          ) ,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),

                          )
                      ),
                      controller: priceController,
                      //  onSubmitted: (_) => _submitData() ,
                    ),
                  ),

                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.40,

                      child:
                      errorPrice!=null ?
                      Text(
                        "* ${errorPrice[0]}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.red,
                            fontSize: 5,
                            fontWeight: FontWeight.w400
                        ),
                      )
                          : null
                  ),
                ],),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width* 0.04,
            ),
//////////////////////////////////////////////////////////////////number of passes
            Container(
              width: MediaQuery.of(context).size.width* 0.40,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 200.0,
                    height: 28.0,
                    child: Text(
                      "Number Of Passes",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          color: Color(0xFF3FCC59),
                          fontWeight: FontWeight.w600
                      ),
                    ),

                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  Container(
                    height: 56.0,
                    width:  MediaQuery.of(context).size.width* 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        //  border: Border.all(width: 5),
                        color: Color(0xFFE9EFF1)
                    ),
                    child:  Padding(
                      padding:  EdgeInsets.only(left: 20,right: 20.0),
                      child: DropdownButton<String>(
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF839195),
                            fontSize: 18
                        ),
                        isExpanded: true,
                        items: _numOfPasses.map((String dropDownStringItems){
                          return DropdownMenuItem<String>(
                            value: dropDownStringItems,
                            child: Text(dropDownStringItems),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected){
                          setState(() {
                            this.currentItemSelected=newValueSelected;
                          });
                        },
                        value: currentItemSelected,
                      ),
                    ) ,
                  )
                ],

              ),

            )
          ]),
        ),
        SizedBox(
          height: 15.0,
        ),
///////////////////////////////////////////////////////////////////////////////Time Picker
        Container(
          width:MediaQuery.of(context).size.width* 0.86,

          child: Row(
            children: <Widget>[
          Container(
          width:MediaQuery.of(context).size.width* 0.45,
          height: 100,
          padding: EdgeInsets.only(left: 5.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
///////////////////////////////////////////////////////////////////////
              Container(
                width: 120.0,
                height: 29.0,
                child: Text(
                  "Date",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      color: Color(0xFF3FCC59),
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.start,
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 45.0,
                width:MediaQuery.of(context).size.width* 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  //shadowColor: Theme.of(context).accentColor,
                  color: Color(0xFFE9EFF1),
                  //Theme.of(context).primaryColor,
                  elevation: 3.0,
                  child: MaterialButton(

                      onPressed: ()=>_presentDatePicker(),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.calendar_today, color: Color(0xFF839195),size: 20.0,),

                          Text(_recentDate==null ? 'Date' : DateFormat.yMMMEd().format(_recentDate),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF839195),
                              fontSize: 12,
                            ),
                          ),

                        ],
                      )

                    //   style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),




            ],

          ),
        ),
              SizedBox(
                width:MediaQuery.of(context).size.width* 0.04,

              ),
              Container(
                width:MediaQuery.of(context).size.width* 0.35,
                height: 100,
                padding: EdgeInsets.only(left: 5.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
///////////////////////////////////////////////////////////////////////
                    Container(
                      width: 120.0,
                      height: 29.0,
                      child: Text(
                        "Time",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.0,
                            color: Color(0xFF3FCC59),
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.start,
                      ),

                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 45.0,
                      width:MediaQuery.of(context).size.width* 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        //shadowColor: Theme.of(context).accentColor,
                        color: Color(0xFFE9EFF1),
                        //Theme.of(context).primaryColor,
                        elevation: 3.0,
                        child: MaterialButton(

                            onPressed: ()=>_tripTimePicker(),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.watch_later, color: Color(0xFF839195),size: 20.0,),

                                Text(_recentTime==null ?
                                "Time"
                                    : MaterialLocalizations.of(context).formatTimeOfDay(_recentTime,alwaysUse24HourFormat: false),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF839195),
                                    fontSize: 15,
                                  ),
                                ),

                              ],
                            )

                          //   style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),




                  ],

                ),
              ),
            ],
          ),
        ),

//////////////////////////////////////////////////////////////////  Date

///////////////////////////////////////////////////////////////////////////////////////////
        SizedBox(
          height: 15.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.86,
          height: 249.0,
          padding: EdgeInsets.only(left: 5.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
///////////////////////////////////////////////////////////////////// Message
              Container(
                width: 164.0,
                height: 28.0,
                child: Text(
                  "Message",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      color: Color(0xFF3FCC59),
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.start,
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: 205.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xFFE9EFF1)
                  ),
                  child: TextField(
                    scrollPadding: EdgeInsets.all(205.0),
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    maxLines: 100,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.0,
                      color: Color(0xFF839195),
                    ),
                    decoration: InputDecoration(
                        hintText: "Insert your message",
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF839195),
                            fontSize: 18
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: errorDesc != null
                                    ? Colors.red
                                    : Color(0xFFD7D7D7)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(30.0))                        ),
                        contentPadding: EdgeInsets.only(left: 20,top: 30 , right: 20),
                        labelText: 'type something' ,
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF839195),
                            fontSize: 18
                        ) ,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),

                        )
                    ),
                    controller: messageController,
                    //  onSubmitted: (_) => _submitData() ,


                  ),
                ),
              ),
              SizedBox(
                height: 1.0,
              ),
              Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.40,
                  child:
                  errorDesc!=null ?
                  Text(
                    "* ${errorDesc[0]}",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w400
                    ),
                  )
                      : null
              )
            ],

          ),
        ),
//////////////////////////////////////////////////////////////////////////POST button
        SizedBox(
          height: 15.0,
        )
        ,
        Container(
            height: 65.0,
            width:  MediaQuery.of(context).size.width*0.86,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              //shadowColor: Theme.of(context).accentColor,
              color: Color(0xFF3FCC59),
              //Theme.of(context).primaryColor,
              elevation: 7.0,
              child: MaterialButton(
                onPressed: _isLoading ? null : postTrip ,
                child: Text(
                  _isLoading ? "Posting..." : " Post",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600
                  ),


                  //   style: Theme.of(context).textTheme.button,
                ),
              ),
            )),
        SizedBox(
          height: 50.0,
        )
      ] ),
    ) ,);

  }

}