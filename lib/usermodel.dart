import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'shared.dart';

List<User> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody)['data'].cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

Future<int> getUserByEmail(
    http.Client client, String userEmail, int integrationId) async {
  final response = await client.post(
    apiusersdatapathfind,
    body: {
      'useremail': '$userEmail',
      'integrationid': '$integrationId',
      'secretkey': easyauthSampleSecret,
    },
  );
  client.close();
  return int.parse(response.body);
}

Future<bool> checkUserPassword(http.Client client, String userEmail,
    String passwordInput, int integrationId) async {
  final response = await client.post(
    apiadmindatapathverify,
    body: {
      'useremail': '$userEmail',
      'integrationid': '$integrationId',
      'secretkeyentered': '$passwordInput',
      'secretkey': easyauthSampleSecret,
    },
  );
  client.close();
  return (int.parse(response.body) == 1) ? true : false;
}

class User {
  final int userid;
  final String useremail;
  final String username;
  final int userverified;
  final int integrationId;

  User(
      {this.userid,
      this.useremail,
      this.username,
      this.userverified,
      this.integrationId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'] as int,
      useremail: json['useremail'] as String,
      username: json['username'] as String,
      userverified: json['userverified'] as int,
      integrationId: json['companyid'] as int,
    );
  }
}
