import 'dart:convert';
import 'dart:io';

import "package:dio/dio.dart";
import 'package:flutter/foundation.dart';
import 'package:solanki/models/customer.dart';
import 'package:solanki/models/category.dart';
import 'config.dart';
import 'models/login_model.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode(Config.key + ":" + Config.secret),
    );

    bool ret = false;

    try {
      var response =
          await Dio().post(Config.url + Config.key + ":" + Config.customerURL,
              data: model.toJson(),
              options: Options(headers: {
                HttpHeaders.authorizationHeader: 'Basic $authToken',
                HttpHeaders.contentTypeHeader: "application/json"
              }));

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }

    return ret;
  }

  Future<LoginResponseModel?> loginCustomer(
      String username, String password) async {
    LoginResponseModel? model;
    try {
      var response = await Dio().post(Config.tokenURL,
          data: {
            "username": username,
            "password": password,
          },
          options: Options(
              headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          }));

      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      print(e.message);
    }
    return model;
  }

  Future<List<Category>?> getCategories() async{
    List<Category> ? data = List<Category>();

    try{
      String url = Config.url + Config.categoriesURL +
    "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      var response = await Dio().get(url,
      options: Options(
        headers:{
          HttpHeaders
        .contentTypeHeader: "application/json",
        },
      ),
      );
      if (response.statusCode == 200){
        data = (response.data as List)
            .map(
              (i) => Category.fromJson(i),
        )
            .toList();
      }
    } on DioException catch (e){
      print(e.response);
    }
    return data;
  }
}
