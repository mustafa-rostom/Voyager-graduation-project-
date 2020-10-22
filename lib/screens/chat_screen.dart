//import 'dart:io';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_socket_io/flutter_socket_io.dart';
//import 'package:flutter_socket_io/socket_io_manager.dart';
//
//
//class ChatScreen extends StatefulWidget {
//
//
//  @override
//  _ChatScreenState createState() => _ChatScreenState();
//}
//
//class _ChatScreenState extends State<ChatScreen> {
//
//  TextEditingController _textEditingController;
//
//  int _counter = 0;
//  SocketIO socketIO;
//  SocketIO socketIO02;
// // WebSocketChannel _channel;
//
//
//
//
//  _connectSocket01() {
//    //update your domain before using
//    /*socketIO = new SocketIO("http://127.0.0.1:3000", "/chat",
//        query: "userId=21031", socketStatusCallback: _socketStatus);*/
//    socketIO = SocketIOManager().createSocketIO("http://127.0.0.1:3000", "/chat", query: "userId=21031", socketStatusCallback: _socketStatus);
//
//    //call init socket before doing anything
//    socketIO.init();
//
//    //subscribe event
//    socketIO.subscribe("socket_info", _onSocketInfo);
//
//    //connect socket
//    socketIO.connect();
//  }
//
//  _socketStatus(dynamic data) {
//    print("Socket status: " + data);
//  }
//  _onSocketInfo(dynamic data) {
//    print("Socket info: " + data);
//  }
//  _subscribes() {
//    if (socketIO != null) {
//      socketIO.subscribe("chat_direct", _onReceiveChatMessage);
//    }
//  }
//  _unSubscribes() {
//    if (socketIO != null) {
//      socketIO.unSubscribe("chat_direct", _onReceiveChatMessage);
//    }
//  }
//
//  _reconnectSocket() {
//    if (socketIO == null) {
//      _connectSocket01();
//    } else {
//      socketIO.connect();
//    }
//  }
//
//  _disconnectSocket() {
//    if (socketIO != null) {
//      socketIO.disconnect();
//    }
//  }
//
//  _destroySocket() {
//    if (socketIO != null) {
//      SocketIOManager().destroySocket(socketIO);
//    }
//  }
//
//  void _sendChatMessage(String msg) async {
//    if (socketIO != null) {
//      String jsonData =
//          '{"message":{"type":"Text","content":'
//          ' ${(msg != null && msg.isNotEmpty) ? '"${msg}"'
//          : '"Hello SOCKET IO PLUGIN :))"'},'
//          '"roomId":"589f10b9bbcd694aa570988d",'
//          '"date":"589f10b9bbcd694aa570988d",'
//
//          '"avatar":''"img/avatar-default.png"},'
//          '"sender":{"userId":"589f10b9bbcd694aa570988d",'
//          '"first":"Ha","last":"Test 2","location":'
//          '{"lat":10.792273999999999,'
//          '"long":106.6430356,'
//          '"accuracy":38,'
//          '"regionId":null,'
//          '"vendor":"gps",'
//          '"verticalAccuracy":null},'
//          '"name":"Ha Test 2"},'
//          '"receivers":["587e1147744c6260e2d3a4af"],'
//          '"conversationId":"589f116612aa254aa4fef79f"'
//          ',"name":null,"isAnonymous":null}';
//      socketIO.sendMessage("chat_direct", jsonData, _onReceiveChatMessage);
//    }
//  }
//
//  void socketInfo(dynamic message) {
//    print("Socket Info: " + message);
//  }
//
//  void _onReceiveChatMessage(dynamic message) {
//    print("Message from UFO: " + message);
//  }
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed(
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//  void _showToast() {
//    _sendChatMessage(_textEditingController.text);
//  }
//
//
//  @override
//  void initState() {
//    super.initState();
//    _connectSocket01();
//
//  }
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        leading: null,
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(Icons.close),
//              onPressed: () {
//                //Implement logout functionality
//              }),
//        ],
//        title: Text('⚡Chat'),
//        backgroundColor: Color(0xFF3FCC59),
//      ),
//      body: SafeArea(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//           // StreamBuilder(
//            //  stream: _channel.stream,
//            //  builder: (context ,snapshot){
//             //   return Padding(
//               //   padding: EdgeInsets.symmetric(vertical: 24.0),
//              //    child: Text(snapshot.hasData ?'${snapshot.data}':''),
//              //  );
//           //   },),
//            //Text('Hello mustafa',style: TextStyle(fontSize: 20),),
//            Container(
//              decoration: BoxDecoration(
//                border: Border(
//                  top: BorderSide(color: Color(0xFF3FCC59), width: 2.0),
//                ),
//              )
//              ,
//              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Expanded(
//                    child: TextField(
//                     // controller: _textEditingController,
//                      onChanged: (value) {
//                        //Do something with the user input.
//                      },
//                      decoration: InputDecoration(
//                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                        hintText: 'Type your message here...',
//                        border: InputBorder.none,
//
//
//
//
//                      ),
//                    ),
//                  ),
//                  FlatButton(
//                    onPressed: () {
//                        if (_textEditingController.text.isEmpty){
//                         return;
//
//                         }else{
//                          _showToast();
//                        }
//                    },
//                       child: Text(
//                       'Send',
//                          style: TextStyle(
//    color:Color(0xFF3FCC59),
//    fontWeight: FontWeight.bold,
//    fontSize: 18.0
//    ),
//                         ),
//                     ),
//
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//  //void sendMessage(){
//  // _channel.sink.add(_textEditingController.text);
// // }
//
//
//
//}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import '../API/API.dart';
class ChatPage extends StatefulWidget {
  final int tripId;
  final String tripMakerName;
  final int tripMakerId;
  final String avatar;
  ChatPage(
      this.tripId,
      this.tripMakerName,
      this.tripMakerId,
      this.avatar
      );
  @override
  _ChatPageState createState() => _ChatPageState(tripId,tripMakerName,tripMakerId,avatar);
}

class _ChatPageState extends State<ChatPage> {
  final int tripId;
  final String tripMakerName;
  final int tripMakerId;
  final String avatar;
  _ChatPageState(
      this.tripId,
      this.tripMakerName,
      this.tripMakerId,
      this.avatar
      );
  SocketIO socketIO;
  List<String> messages;
  double height, width;
  TextEditingController textController;
  ScrollController scrollController;

//  getMessages() async {
//
//    _setHeaders()=>{
//      'Content-type' : 'application/json',
//
//    };
//    var data = {
//      'roomID': tripMakerId,
//
//    };
//    const String mainUrl ="https://voyagermostafa.herokuapp.com/getMessages/";
//    try{ var res = await CallApi().postChatData(data,mainUrl,_setHeaders());
//
//    var body = json.decode(res);
//print(body);
//   }catch(error){
//print(error);
//print("error");
//    }}
  @override
  void initState() {

    //Initializing the message list
    messages = List<String>();
    //Initializing the TextEditingController and ScrollController
    textController = TextEditingController();
    scrollController = ScrollController();
    //Creating the socket
    socketIO = SocketIOManager().createSocketIO(
      'https://voyagermostafa.herokuapp.com/getMessages',
      '/',query: 'roomID=$tripId'
    );
    //Call init before doing anything with socket
    socketIO.init();
    //Subscribe to an event to listen to
    socketIO.subscribe('receive_message', (jsonData) {
      //Convert the JSON data received into a Map
      Map<String, dynamic> data = json.decode(jsonData);
      this.setState(() => messages.add(data['message']));
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
    //Connect to the socket
    socketIO.connect();
    super.initState();
  }


  Widget buildSingleMessage(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          messages[index],
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return Container(
      height: height * 0.8,
      width: width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return buildSingleMessage(index);
        },
      ),
    );
  }

  Widget buildChatInput() {
    return Container(
      width: width * 0.7,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(left: 40.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: 'Send a message...',
        ),
        controller: textController,
      ),
    );
  }

  Widget buildSendButton() {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () {

        //Check if the textfield has text or not
        if (textController.text.isNotEmpty) {
          //Send the message as JSON data to send_message event
          socketIO.sendMessage(
              'sendMessage', json.encode({'roomID':tripId,'userID':tripMakerId,'message': textController.text,'name':tripMakerName,'avatar':avatar,'date': DateTime.now().toString()}));
          //Add the message to the list
          this.setState(() => messages.add(textController.text));
          textController.text = '';
          //Scrolldown the list to show the latest message
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        }
      },
      child: Icon(
        Icons.send,
        size: 30,
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      height: height * 0.1,
      width: width,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: height * 0.1),
            buildMessageList(),
            buildInputArea(),
          ],
        ),
      ),
    );
  }
}