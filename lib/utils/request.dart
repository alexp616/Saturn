import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class RequestBuilder {
  
  Future<String> makeRequest ({
      required String id, 
      required String password, 
      required String school, 
      required String city, 
      required String state
    }) async {

    var url = Uri.http('45.77.108.113', '/student');
    var response = await http.post(url, body: jsonEncode({
      "id": id,
      "password": password,
      "school": school,
      "city": city,
      "state": state
    }), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }).catchError((err) {
      print(err);
    });

    return response.body;
  }
}