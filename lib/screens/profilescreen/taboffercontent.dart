import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import 'dart:convert';
import '../../screens/tripdetails.dart';
import '../triprequest/updateoffer.dart';

class ShowMyOffer extends StatefulWidget{
  final BuildContext ctx;
  ShowMyOffer(this.ctx);
  @override
  State<StatefulWidget> createState() {
    return _StateShowMyOffer(ctx) ;
  }

}
class _StateShowMyOffer extends State<ShowMyOffer>{
  final BuildContext ctx;
  _StateShowMyOffer(this.ctx);
  List<dynamic> allOffers;
  var noResultMessage;
  var messageDeleted;
  var messageConnection;
  int userId;
  Future<void> _showChoiceDialog(BuildContext context,int offerId,int tripId,int offerPrice,int numOfSeats){
    return showDialog(context: context, builder: (BuildContext context){

      return AlertDialog(
        backgroundColor: Color(0xFFF4F8FF),
        elevation: 4,
        shape: Border.all(width: 1,color: Colors.black),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Update'),
                onTap: (){
                  Navigator.pop(context);
                  _startUpdateOffer(context,offerId,tripId,offerPrice,numOfSeats);

                }
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              GestureDetector(
                child: Text('Delete'),
                onTap: ()async{
                  Navigator.pop(context);
                  await  deleteOffer(context);
            //    print(messageDeleted);
                if(messageDeleted!=null){
                  Scaffold.of(ctx).showSnackBar(
                      SnackBar(
                        content: Text("$messageDeleted"),
                      ));
                  messageDeleted=null;
                }else if(messageConnection!=null){
                  Scaffold.of(ctx).showSnackBar(
                      SnackBar(
                        content: Text("$messageConnection"),
                      ));
                  messageConnection=null;
                }
                },
              )
            ],
          ),
        ),
      );
    });
  }

  getOffers(BuildContext context) async {

    SharedPreferences tokenLocalStorage=await SharedPreferences.getInstance();
    String currentToken=tokenLocalStorage.getString('token');

    print("\nwe are in get user info\n");
    print(currentToken);
    String authentication= 'Bearer ' + currentToken;
    print(authentication);
    _setHeaders()=>{
//      'Content-type' : 'application/json',
      "Accept": 'application/json',
      "Authorization": authentication
    };

     String mainUrl ="offers";


    var res = await CallApi().getDataWithAuth(mainUrl,_setHeaders());




    var body = json.decode(res);

    print(body);

    print(body["success"]);


      setState(() {
        allOffers=body['offers'];
      });

  }

  deleteOffer(BuildContext context) async {
print(userId);
print("\nwe are in delete user offer");

    SharedPreferences tokenLocalStorage=await SharedPreferences.getInstance();
    String currentToken=tokenLocalStorage.getString('token');

    print(currentToken);
    String authentication= 'Bearer ' + currentToken;
    print(authentication);
    _setHeaders()=>{
//      'Content-type' : 'application/json',
      "Accept": 'application/json',
      "Authorization": authentication
    };

    String mainUrl ="offers/"+userId.toString();


    try{var res = await CallApi().deleteData(mainUrl,_setHeaders());




    var body = json.decode(res);

    print(body);

    print(body["success"]);
    if(body["success"]=="true")
{
  messageDeleted=body['message'];

  getOffers(context);

}
}catch(error){
      print(error);
      messageConnection="connection failed";
    }
  }

  Widget showOffers() {
    if(allOffers==null&&noResultMessage==null)
    {
      return  Container(
          color: Color(0xFFE5F3EB),
          child:  Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),

            ),
          )
      );
    }else if(allOffers!=null&&allOffers.isNotEmpty) {
      return Expanded(
        child: Container(
          color: Color(0xFFE5F3EB),
          child: SingleChildScrollView(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

              children:
              allOffers.map((tr){
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0 , horizontal: 2.0),
                  elevation: 5,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    color: Color(0xFFD0ECD8),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius:40,
                          backgroundColor: Color(0xFF053218),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                                child: Text('${tr["offer_price"]} LE',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF3FCC59),
                                      fontFamily: 'Poppins'),)),
                          ),),
//                          trailing: IconButton(
//                            icon: Icon(Icons.delete),
//                            color: Theme.of(context).errorColor,
//                            onPressed: (){},
//                          ),
                        title: Text('${tr['trip']["from"] }  ->  ${tr['trip']["to"]}',
                          style: TextStyle(
                              fontSize: 15.0, fontFamily: 'Poppins',fontWeight: FontWeight.w700),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                    DateFormat.yMMMEd().format(DateTime.parse(tr["created_at"]))),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  DateFormat.jm().format(DateTime.parse(tr["created_at"])),
                                ),
                              ],
                            ),

                          ],
                        ),
                       onLongPress: (){
                          userId=tr['id'];
                          _showChoiceDialog(context,tr['id'],tr['trip_id'],tr['offer_price'],tr['number_of_seats_needed']);
                       },
                        onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>TripDetailsView(tr['trip']['id'],tr['user']['name'],tr['user']['rate'],tr['user']['id'])));

                        },

                      ),
                    ),
                  ),
                );
                //Card(child:


              }).toList()
              ,

            ),
          ),

        ),
      );
    }else if(allOffers.isEmpty){
      return  Container(
        //    height: MediaQuery.of(context).size.height * 0.6,
        color: Color(0xFFE5F3EB),
        child: Center(child: Text(noResultMessage!=null ?"$noResultMessage":"No offers made")),
      );
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOffers(context);

  }
  void _startUpdateOffer(BuildContext ctx,int offerId,int tripId,int offerPrice, int numOfSeats){
    print("we entered startaddnewtrans");

    showModalBottomSheet(backgroundColor:Colors.white ,context: ctx, builder: (_){

      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height*0.3,
        child: GestureDetector(
          onTap: (){},
          child: UpdateTheOffer(ctx,offerId,tripId,offerPrice,numOfSeats),
          behavior: HitTestBehavior.opaque,
        ),
      );}
    );

  }

  @override
  Widget build(BuildContext context) {
    return showOffers();
  }

}