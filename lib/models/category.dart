import 'dart:ui';

import 'package:flutter/material.dart';

class Category {
  int categoryId;
  String categoryName;
  String categoryDesc;
  int parent;
  Image image;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryDesc,
    this.image,
});

  Category.fromJson(Map<String, dynamic> json){
    categoryId = json['id'];
    categoryName = json['name'];
    categoryDesc = json['description'];
    parent = json['parent'];
    image = json['image'] != null? new Image.fromJson(json['image']) : null;
  }
}

Class Image{
  String url;

  Image({
  this.url,
});

  Image.fromJson(Map<String, dynamic>json){
    url = json['src'];
};
}