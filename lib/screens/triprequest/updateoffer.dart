import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import 'dart:convert';

class UpdateTheOffer extends StatefulWidget{
  final BuildContext ctx;
  final int offerId;
  final int tripId;
  final int offerPrice;
  final int numSeatsNeeded;
  UpdateTheOffer(this.ctx,this.offerId,this.tripId,this.offerPrice,this.numSeatsNeeded);

  @override
  _UpdateOfferState createState() => _UpdateOfferState(offerId,tripId,offerPrice,numSeatsNeeded);
}

class _UpdateOfferState extends State<UpdateTheOffer> {
  final int offerId;
  final int tripId;
  final int offerPrice;
  final int numSeatsNeeded;
  _UpdateOfferState(this.offerId,this.tripId,this.offerPrice,this.numSeatsNeeded);
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
        updateMyOffer(context);
      }
    }
    return;

  }

  updateMyOffer(BuildContext context) async {
    print('we are in update  offer func');

    SharedPreferences tokenLocalStorage = await SharedPreferences.getInstance();
    String currentToken = tokenLocalStorage.getString('token');
    String authentication = 'Bearer ' + currentToken;
    _setHeaders()=>{
      'Content-type' : 'application/json',
//      'Accept' : '*/*',
      "Authorization": authentication


    };
    print(tripId);
    print(priceController.text);
    print(seatsNumController.text);
    var data = {
      'trip_id' : tripId.toString(),
      'offer_price' : priceController.text,
      'number_of_seats_needed' : seatsNumController.text,
    };

     String mainUrl ="offers/" + offerId.toString();
     print(mainUrl);
   // try{
      var res = await CallApi().updateData(data,mainUrl,_setHeaders());

      var body = json.decode(res);

      print(body);

//      print(body['data']);
//      print("\n");
//      print(body["success"]);
//      if (body["success"] == true) {

        Navigator.pop(context);
        Scaffold.of(widget.ctx).showSnackBar( SnackBar(content: Text('trip updated successfuly')));

     // }
//    }catch(error){
//      print("\n$error");
//      Scaffold.of(context).showSnackBar( SnackBar(content: Text('Failed to update offer')));
//    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    priceController.text=offerPrice.toString();
    seatsNumController.text=numSeatsNeeded.toString();
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
                  Text('edit offer'),
                    onPressed:  (){
                     // _submitData(context);
                      updateMyOffer(context);
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