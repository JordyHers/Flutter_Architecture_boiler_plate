import 'package:http/http.dart' as http;
import 'package:boilerplate/features/boilerplate_app/data/models/user_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

abstract class BoilerJsonSource {
  Future<List<User>> getUserList(String id) async {}
  Future<List<User>> getRemoteUserList(String id) async{}
}

class BoilerJsonDataSource implements BoilerJsonSource{

  @override
  Future<List<User>> getUserList(String id) async {
    var data = await rootBundle.loadString('assets/data.json');
    var jsonData = json.decode(data);
    List<User> users =[];
    for(var u in jsonData){
      User user = User(u["id"], u["name"], u["username"], u["email"]);
      print(user);
      users.add(user);
    }
    return users;
  }

  @override
  Future<List<User>> getRemoteUserList (String id) async {
    var data = await http.get('https://jsonplaceholder.typicode.com/users');
    var jsonData = json.decode(data.body);
    List<User> users =[];
    print('****** GETTING REMOTE LIST OF USERS *******');
    for(var u in jsonData){
      User user = User(u["id"], u["name"], u["username"], u["email"]);
      print(user);

      users.add(user);
    }
    return users;
  }
}