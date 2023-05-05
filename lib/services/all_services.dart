import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lawyers_list/core/api_end_points.dart';
import 'package:lawyers_list/core/constants.dart';
import 'package:lawyers_list/model/sign_in/sign_in_req.dart';
import 'package:lawyers_list/model/sign_in/sign_in_res.dart';

class Allservices {
  var dio = Dio();
  // user login
  Future<SignInResModel?> signin(SignInReqModel reqModel) async {
    try {
      Response response = await dio.post(kBaseUrl + ApiEndPoints().signin,
          data: jsonEncode(reqModel.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return SignInResModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
