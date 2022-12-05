import 'package:http/http.dart' as http;

class RequestBuilder {
  
  Future<String> makeRequest (
    {
      required String id, 
      required String password, 
      required String school, 
      required String city, 
      required String state
    }) async {

    var url = Uri.http('localhost:3000', '/student');
    var response = await http.post(url, body: {
      "id": id,
      "password": password,
      "school": school,
      "city": city,
      "state": state
    });

    return response.body;
  }
}