import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  //fetching all items
  Future<List<Map>> fetchItems() async {
    List<Map> items = [];
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      //get response data
      var jsonString = response.body;
      //convert to List<Map>
      var data = jsonDecode(jsonString);
      items = data.cast<Map>();
    }
    return items;
  }

  //fetching one item
  Future<Map> getItem(String itemId) async {
    Map item = {};
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'));
    if (response.statusCode == 200) {
      //get response data
      var jsonString = response.body;
      //convert to List<Map>
      item = jsonDecode(jsonString);
      // item = data.cast<Map>();
    }
    return item;
  }

//add new item
  Future<bool> addItem(Map data) async {
    bool status = false;

    var response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: jsonEncode(data),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 201) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

//update an item
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;
    var response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
      body: jsonEncode(data),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

// delete an item
  Future<bool> deleteItem(String itemId) async {
    bool status = false;
    var response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
    );
    if (response.statusCode == 200) {
      status = true;
    }
    return status;
  }
}
