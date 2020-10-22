import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';


class CallApi{

  Future<dynamic> postData(data,mainUrl,_setHeaders) async{
   print("here is postdata func");
    String url = 'http://10.0.2.2:8000/api/'+ mainUrl;
    var bodyEncoded = json.encode(data);
    var response = await http.post(url, body: bodyEncoded , headers: _setHeaders,);
    print("before sending response \n");
    final String res = response.body;
    print("after sending response ");

    return res;
//    return  await http.post(
//        url,
//        body: jsonEncode(data),
//        headers: _setHeaders()
//
//        );
  }
  Future<dynamic> getData(mainUrl) async{
    print("here is getdata func");
    String url = 'http://10.0.2.2:8000/api/'+ mainUrl;
    var response = await http.get(url);
    print("before sending response \n");
    final String res = response.body;
    print("after sending response ");

    return res;
//    return  await http.post(
//        url,
//        body: jsonEncode(data),
//        headers: _setHeaders()
//
//        );
  }
  Future<dynamic> getDataWithAuth(mainUrl,_setHeaders) async{
    print("here is getdata func");
    String url = 'http://10.0.2.2:8000/api/'+ mainUrl;
    var response = await http.get(url, headers: _setHeaders);
    print("before sending response \n");
    final String res = response.body;
    print("after sending response ");

    return res;
//    return  await http.post(
//        url,
//        body: jsonEncode(data),
//        headers: _setHeaders()
//
//        );
  }
  Future<dynamic> deleteData(mainUrl,_setHeaders) async{
    print("here is getdata func");
    String url = 'http://10.0.2.2:8000/api/'+ mainUrl;
    var response = await http.delete(url, headers: _setHeaders);
    print("before sending response \n");
    final String res = response.body;
    print("after sending response ");

    return res;
//    return  await http.post(
//        url,
//        body: jsonEncode(data),
//        headers: _setHeaders()
//
//        );
  }
  Future<dynamic> updateData(data,mainUrl,_setHeaders) async{
    print("here is putdata func");
    String url = 'http://10.0.2.2:8000/api/'+ mainUrl;
    var bodyEncoded = json.encode(data);

    var response = await http.put(url,body: bodyEncoded, headers: _setHeaders);
    print("before sending response \n");
    final String res = response.body;
    print("after sending response ");

    return res;
//    return  await http.post(
//        url,
//        body: jsonEncode(data),
//        headers: _setHeaders()
//
//        );
  }
//  postImage(String filename, String url) async {
//  var request = http.MultipartRequest('POST', Uri.parse(url));
//  request.files.add(
//  http.MultipartFile(
//  'avatar',
//  File(filename).readAsBytes().asStream(),
//  File(filename).lengthSync(),
//  filename: filename.split("/").last
//  )
//  );
//  var res = await request.send();
//  return res;
//}
//  Future postImage(File _image,String url,_setHeaders) async {
//
//    // open a bytestream
//    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
//    // get file length
//    var length = await _image.length();
//
//    // string to uri
//    var uri = Uri.parse("http://ip:8082/composer/predict");
//
//    // create multipart request
//    var request = new http.MultipartRequest("POST", uri);
//
//    // multipart that takes file
//    var multipartFile = new http.MultipartFile('file', stream, length,
//        filename: basename(imageFile.path));
//
//    // add file to multipart
//    request.files.add(multipartFile);
//
//    // send
//    var response = await request.send();
//    print(response.statusCode);
//
//    // listen for response
//    response.stream.transform(utf8.decoder).listen((value) {
//      print(value);
//    });
//
//  }
//
  Future<dynamic> postChatData(data,url,_setHeaders) async{
    print("here is postdata func");
    var bodyEncoded = json.encode(data);
    var response = await http.post(url, body: bodyEncoded , headers: _setHeaders,);
    print("before sending response \n");
    final String res = response.body;
    print("after sending response ");

    return res;
//    return  await http.post(
//        url,
//        body: jsonEncode(data),
//        headers: _setHeaders()
//
//        );
  }
}