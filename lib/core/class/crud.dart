import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../function/check_internet.dart';
import 'status_request.dart';

String _basicAuth =
    'Basic ${base64Encode(utf8.encode('muhammad:muhammad224'))}';
Map<String, String> myHeader = {
  'authorization': _basicAuth,
};
final dio = Dio();

class CRUD {
  Future<Either<StatusRequest, Map>> postData(String url, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await dio.post(url, data: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseBody = jsonDecode(response.data);
          // ignore: avoid_print
          print(responseBody);
          return right(responseBody);
        } else {
          return left(StatusRequest.serverFail);
        }
      } else {
        return left(StatusRequest.offline);
      }
    } catch (_) {
      return left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> addRequestWithImage(url, data, File? image,
      [String? nameRequest]) async {
    nameRequest ??= "files";

    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(myHeader);

    if (image != null) {
      var length = await image.length();
      var stream = http.ByteStream(image.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(nameRequest, stream, length,
          filename: basename(image.path));
      request.files.add(multipartFile);
    }

    // add Data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    // add Data to request
    // Send Request
    var myRequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Map responseBody = jsonDecode(response.body);
      return Right(responseBody);
    } else {
      return const Left(StatusRequest.serverFail);
    }
  }
}
