// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/chat_list.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/initPlatformState.dart';

getChatList(BuildContext context) async {
  log("message list api");
  final provider = Provider.of<DataProvider>(context, listen: false);
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');
  // if (apiToken == null) return;
  try {
    var response = await http.post(
        Uri.parse('$api/chat-list?page=1&language_id=1'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log(response.body);
      bool isLogOut =
          jsonResponse["message"].toString().contains("Please login again");
      if (isLogOut) {
        initPlatformState(context);
      } else {
        final chatDetails = ChatListModel.fromJson(jsonResponse);
        provider.getChatListDetails(chatDetails);
      }
    } else {
      log("Something Went Wrong");
    }
  } on Exception catch (e) {
    log("Something Went Wrong1");
    print(e.toString().contains("Failed host lookup"));
  }
}
