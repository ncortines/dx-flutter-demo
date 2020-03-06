// Copyright 2020 Pegasystems Inc. All rights reserved.
// Use of this source code is governed by a Apache 2.0 license that can be
// found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dx_interpreter.dart';

final String _username = 'user@constellation.com';
final String _password = 'rules';
final String _baseUrl = 'https://lu-84-cam.eng.pega.com';

final _headers = {
  'Accept': 'application/json',
  'Authorization':
      'Basic ' + base64.encode(utf8.encode(_username + ':' + _password))
};

Future<Map> getPortal(String portalName) async {
  final response = await http
      .get(_baseUrl + '/prweb/api/v2/portals/$portalName', headers: _headers);
  return getImmutableCopy(json.decode(response.body));
}

Future<Map> getPage(String pyRuleName, String pyClassName) async {
  final response = await http.get(
      _baseUrl + '/prweb/api/v2/pages/$pyRuleName?pageClass=$pyClassName',
      headers: _headers);
  return getImmutableCopy(json.decode(response.body));
}

Future<Map> openAssignment(String pzInsKey) async {
  final response = await http
      .get(_baseUrl + '/prweb/api/v2/assignments/$pzInsKey', headers: _headers);
  return getImmutableCopy(json.decode(response.body));
}

Future<Map> processAssignment(String assignmentId, String actionName, Map payload) async {
  final String patchData = json.encode({'content': payload ?? {} });
  final response = await http
      .patch(_baseUrl + '/prweb/api/v2/assignments/$assignmentId/actions/$actionName', headers: _headers, body: patchData);
  return getImmutableCopy(json.decode(response.body));
}
