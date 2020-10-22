import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import 'dart:convert';

class MakeOffer extends StatefulWidget{
final int tripId;
MakeOffer(this.tripId);

  @override
  _MakeOfferState createState() => _MakeOfferState(tripId);
}

class _MakeOfferState extends State<MakeOffer> {
  final int tripId;
  _MakeOfferState(this.tripId);
  var snackBar;
  final priceController=TextEditingController();
  final seatsNumController=TextEditingController();


  void _submitData(BuildContext context) {
    print('in submitdata');
    if (priceController.text.isEmpty || seatsNumController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Enter price and seats number")));

    } else {
      final int enteredPrice = int.parse(priceController.text);
      final int enteredSeats = int.parse(seatsNumController.text);
      if (enteredPrice <= 0  ) {
        print('eror');
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('price shouldnt be less than zero')));

      }else if((enteredSeats <= 0 || enteredSeats > 4) && enteredPrice > 0 ){
       Scaffold.of(context).showSnackBar( SnackBar(content: Text('seats at least 1 at most 4')));

      }else{
        createNewOffer(context);
      }
    }
    return;

  }

  createNewOffer(BuildContext context) async {
print('we are in create new offer func');

    SharedPreferences tokenLocalStorage = await SharedPreferences.getInstance();
    String currentToken = tokenLocalStorage.getString('token');
    String authentication = 'Bearer ' + currentToken;
    int userId=tokenLocalStorage.getInt("Id");
print(widget.tripId);
print(tripId);
    _setHeaders()=>{
      'Content-type' : 'application/json',
      'Accept' : 'application/x-www-form-urlencoded',
      "Authorization": authentication


    };
    var data = {
      'user_id': userId,
      'trip_id': widget.tripId,
      'offer_price':  priceController.text,
      'number_of_seats_needed': seatsNumController.text,
    };
    const String mainUrl ="offers";
    try{
      var res = await CallApi().postData(data,mainUrl,_setHeaders());

    var body = json.decode(res);

    print(body);

    print(body['data']);
    print("\n");
    print(body["success"]);
      if (body["success"] == true) {

        Navigator.pop(context);

      }
   }catch(error){
      print("\n$error");
    Scaffold.of(context).showSnackBar(      SnackBar(content: Text('connection failed')));
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Builder(
         builder: (context)=> Card(
           color: Colors.white,
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(decoration:
                  InputDecoration(
                      labelText: 'Price'
                  ),
                    controller: priceController,
     //               onSubmitted: (_) => _submitData() ,


                  ),
                  TextField(decoration:
                  InputDecoration(
                      labelText: 'Seats number'
                  ),
                    controller: seatsNumController,
                    keyboardType: TextInputType.number,
          //          onSubmitted: (_) =>_submitData() ,

                  ),

                  RaisedButton(child:
                  Text('send offer'),
                    onPressed:  (){
                      _submitData(context);
                    },
                    color: Colors.green,
                    textColor: Theme.of(context).textTheme.button.color,

                  ),
                ],
              )),
        ),
      ),
    );
  }
}