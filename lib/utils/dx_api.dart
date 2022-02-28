// Copyright 2022 Pegasystems Inc. All rights reserved.
// Use of this source code is governed by a Apache 2.0 license that can be
// found in the LICENSE file.

import 'dart:collection';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dx_interpreter.dart';

const String _username = 'user@constellation.com'; // eg. 'user@constellation.com'
const String _password = 'rules'; // eg. 'password'
const String _baseUrl = 'https://974f-83-142-157-190.ngrok.io/prweb/app/SpaceTravel/api/application/v2'; // eg. 'https://demo.rpega.com/prweb/app/SpaceTravel/api/application/v2'

final _headers = {
  'Accept': 'application/json',
  'Authorization':
      'Basic ' + base64.encode(utf8.encode(_username + ':' + _password))
};

Future<UnmodifiableMapView<String, dynamic>> getPortal(String portalName) async {
  final response = await http
      .get(Uri.parse(_baseUrl + '/portals/$portalName'), headers: _headers);
  return getImmutableCopy(json.decode(response.body));
}

Future<UnmodifiableMapView<String, dynamic>> getPage(String pyRuleName, String pyClassName) async {
  final response = await http.get(
      Uri.parse(_baseUrl + '/pages/$pyRuleName?pageClass=$pyClassName'),
      headers: _headers);
  return getImmutableCopy(json.decode(response.body));
}

Future<UnmodifiableMapView<String, dynamic>> openAssignment(String pzInsKey) async {
  final response = await http
      .get(Uri.parse(_baseUrl + '/assignments/$pzInsKey'), headers: _headers);
  return getImmutableCopy(json.decode(response.body));
}

Future<UnmodifiableMapView<String, dynamic>> createAssignment(String caseTypeID, String processID) async {
  final String postData = json.encode({'caseTypeID': caseTypeID, 'processID': processID});
  final response = await http
      .post(Uri.parse(_baseUrl + '/cases'), headers: _headers, body: postData);
  return getImmutableCopy(json.decode(response.body));
}

Future<UnmodifiableMapView<String, dynamic>> processAssignment(String assignmentId, String actionName, Map? payload) async {
  final String patchData = json.encode(payload ?? {'content': {}});
  final response = await http
      .patch(Uri.parse(_baseUrl + '/assignments/$assignmentId/actions/$actionName'), headers: _headers, body: patchData);
  return getImmutableCopy(json.decode(response.body));
}
