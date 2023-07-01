library reader_service;

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:built_collection/built_collection.dart';
import 'package:flutter_reader/models/models.dart';
import 'dart:convert';

Future<BuiltList<FeedInfo>> getFeedInfos() async {
  final response = await http.read("http://localhost:3000/feeds");
  return new BuiltList(json.decode(response).map(FeedInfo.fromJson));
}

Future<BuiltList<FeedEntry>> getFeedEntries(String feedId,
    {int max = 20, int end, bool descriptionsOnly: true}) async {
  final url = new Uri.http(
      "localhost:3000",
      "/feeds/$feedId/items",
      makeQueryParameters(
          {'max': max, 'end': end, 'descriptions-only': descriptionsOnly}));
  final response = await http.read(url);
  return new BuiltList(json.decode(response).map(FeedEntry.fromJson));
}

Future<FeedEntry> getFeedEntry(String feedId, String entryId) async {
  final url =
      new Uri.http("localhost:3000", "/feeds/$feedId/items/$entryId");
  final response = await http.read(url);
  return FeedEntry.fromJson(json.decode(response));
}

Future<Null> setFeedEntryReadState(
    String feedId, String entryId, bool read) async {
  final url = new Uri.http(
      "localhost:3000", "/feeds/$feedId/items/$entryId/read");
  print((await http.post(url, body: {'value': read ? "True" : "False"})).body);
  return null;
}

Future<Null> setFeedEntryStarredState(
    String feedId, String entryId, bool starred) async {
  final url = new Uri.http(
      "localhost:3000", "/feeds/$feedId/items/$entryId/starred");
  print(
      (await http.post(url, body: {'value': starred ? "True" : "False"})).body);
  return null;
}

Map<String, String> makeQueryParameters(Map<String, Object> preMap) {
  final result = <String, String>{};
  preMap.forEach((key, value) {
    if (value != null) {
      result[key] = value.toString();
    }
  });
  return result;
}
