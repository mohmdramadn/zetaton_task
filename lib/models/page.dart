// To parse this JSON data, do
//
//     final page = pageFromJson(jsonString);

import 'dart:convert';

import 'package:zetaton_task/models/photos.dart';

Page pageFromJson(String str) => Page.fromJson(json.decode(str));

String pageToJson(Page data) => json.encode(data.toJson());

class Page {
  int page;
  int perPage;
  List<Photos> photos;
  int totalResults;
  String nextPage;

  Page({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.totalResults,
    required this.nextPage,
  });

  Page copyWith({
    int? page,
    int? perPage,
    List<Photos>? photos,
    int? totalResults,
    String? nextPage,
  }) =>
      Page(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        photos: photos ?? this.photos,
        totalResults: totalResults ?? this.totalResults,
        nextPage: nextPage ?? this.nextPage,
      );

  factory Page.fromJson(Map<String, dynamic> json) => Page(
    page: json["page"],
    perPage: json["per_page"],
    photos: List<Photos>.from(json["photos"].map((x) => Photos.fromJson(x))),
    totalResults: json["total_results"],
    nextPage: json["next_page"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    "total_results": totalResults,
    "next_page": nextPage,
  };
}
