import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tracking_project_app/core/app_data.dart';
import 'package:tracking_project_app/views/widgets/styles.dart';

const String baseUrl = "https://scubetech.xyz/projects/dashboard";
const Map<String, String> requestHeader = {"Content-Type": "application/json"};

Future<List> projectTrackingListRequest() async{
  var url = Uri.parse("$baseUrl/all-project-elements/");
  var response = await http.get(url, headers: requestHeader);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if(resultCode == 200){
    return resultBody;
  }else{
    customToast(msg: 'Something went wrong', color: Colors.red);
    return [];
  }
}

Future<bool> addElementRequest(formValues) async {
  var url = Uri.parse("$baseUrl/add-project-elements/");
  var postBody = json.encode(formValues);
  var response = await http.post(url, headers: requestHeader, body: postBody,);
  var resultCode = response.statusCode;
  if (resultCode == 201) {
   customToast(msg: 'Successfully Added', color: greenClr);
    return true;
  } else {
    customToast(msg: 'Something went wrong', color: Colors.red);
    return false;
  }
}

Future<bool> updateElementRequest(id, formValues) async {
  var url = Uri.parse("$baseUrl/update-project-elements/$id/");
  var postBody = json.encode(formValues);
  var response = await http.put(url, headers: requestHeader, body: postBody,);
  var resultCode = response.statusCode;
  if (resultCode == 200) {
    customToast(msg: 'Successfully Updated', color: greenClr);
    return true;
  } else {
    customToast(msg: 'Something went wrong', color: Colors.red);
    return false;
  }
}