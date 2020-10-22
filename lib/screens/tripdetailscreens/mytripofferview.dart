import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/API.dart';
import 'dart:convert';
import '../../screens/tripdetails.dart';
import '../triprequest/updateoffer.dart';

class MyTripOffer extends StatefulWidget{
  final List<dynamic> allOffers;
  final BuildContext ctx;
MyTripOffer(this.ctx,this.allOffers);
  @override
  State<StatefulWidget> createState() {
    return _StateMyTripOffer(ctx,allOffers) ;
  }

}
class _StateMyTripOffer extends State<MyTripOffer>{
  _StateMyTripOffer(this.ctx,this.allOffers);
 final List<dynamic> allOffers;
  final BuildContext ctx;

  var noResultMessage;
  var messageDeleted;
  var messageConnection;
  int userId;




  respondOffer(int respond,int offerId) async {

    SharedPreferences tokenLocalStorage = await SharedPreferences.getInstance();
    String currentToken = tokenLocalStorage.getString('token');
    String authentication = 'Bearer ' + currentToken;
print(respond);
print(offerId);


    _setHeaders()=>{
      'Content-type' : 'application/json',
      'Accept' : 'application/x-www-form-urlencoded',
      "Authorization": authentication


    };
    var data = {
      'offer_status': respond,

    };
     String mainUrl ="offers/respond/"+offerId.toString();
    try{ var res = await CallApi().postData(data,mainUrl,_setHeaders());

    var body = json.decode(res);

    print(body);

    print(body['data']);
    print("\n");
    print(body["success"]);


    if (body["success"] == true) {
      Scaffold.of(ctx).showSnackBar(SnackBar(content:Text("${body['message']}"),));
setState(() {

});

    }
    else  {
      Scaffold.of(ctx).showSnackBar(SnackBar(content:Text("${body['message']}"),));
    }
  }catch(error){
      print("\n$error");
      Scaffold.of(ctx).showSnackBar(SnackBar(content:Text("Connection failed"),));

    }}


  Widget showOffers() {
    if(allOffers==null)
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
      return Container(
        height: MediaQuery.of(context).size.height*0.4,
        color: Color(0xFFE5F3EB),
        child: SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,

            children:
            allOffers.map((tr){

              return tr['offer_status']==2? Container(): Card(
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
                      title: Text('${tr['owner']["name"] }  ',
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
                          SmoothStarRating(
                              allowHalfRating: true,

                              starCount: 5,
                              rating: 3.5,
                              size: 20.0,
                              //fullRatedIconData: Icons.blur_off,
                              //halfRatedIconData: Icons.blur_on,
                              color: Color(0xFF3FCC59),
                              borderColor:Color(0xFF3FCC59),
                              spacing:0.0
                          ),
                          tr['offer_status']==1?
                          Text("Accepted",style: TextStyle(color: Colors.black54),)
                              :
                          Row(
                            children: <Widget>[
                             InkWell(
                                child: Text("Accept"),
                                onTap: (){
                                  respondOffer(1, tr["id"]);
                                },
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              InkWell(
                                child: Text("Refuse"),
                                onTap: (){
                                  respondOffer(2, tr["id"]);

                                },


                              )
                            ],
                          )
                        ],
                      ),

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

      );
    }else if(allOffers.isEmpty){
      return  Container(
        //    height: MediaQuery.of(context).size.height * 0.6,
        color: Color(0xFFE5F3EB),
        child: Center(child: Text("No offers made")),
      );
    }

  }



  @override
  Widget build(BuildContext context) {
    return showOffers();
  }

}