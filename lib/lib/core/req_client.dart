import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tedfinance_mobile/core/env/environment.dart';

import '../shared/util/share_preference_util.dart';

// import 'package:dio_http_cache/dio_http_cache.dart';

class ReqClient {
  Dio dio = Dio();
  // DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

  Future<Response> postWithoutHeaderClient(url, data) async {
    print(url);
    print(data);
    return await dio.post(url,
        data: data,
        options: Options(
          headers: {
            // 'Accept': '*/*',

            "x-api-key": Environment().config.API_KEY,
          },
        ));
  }

  Future<Response> getWithoutHeaderClient(url) async {
    return await dio.get(url,
        options: Options(
          headers: {
            // 'Accept': '*/*',

            "x-api-key": Environment().config.API_KEY
          },
        ));
  }

  Future<dynamic> getWithAuthHeaderClient(url) async {
    // dio.interceptors.add(_dioCacheManager.interceptor);

    final String token = await SharedPreferenceUtils.getToken();
    // final int? id = await SharedPreferenceUtils.getUserId();

    print("yuoptoken $token");
    print("yurl $url");

    try {
      // Options _cacheOptions = buildCacheOptions(Duration(days: 7),
      //     maxStale: Duration(days: 10),
      //     forceRefresh: true,
      //     options: Options(
      //       headers: {
      //         // 'Accept': '*/*',
      //         'authorizationToken': token,
      //         "x-api-key": Environment().config.API_KEY,
      //         "authid": id
      //       },
      //     ));
      Response response = await dio.get(url,
          options: Options(
            headers: {
              // 'Accept': '*/*',
              'Authorization': 'Bearer $token',
              "x-api-key": Environment().config.API_KEY,
              // "authid": id
            },
          ));

      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      // print("jhnnututu${e.response!.statusCode}");
      if (e.response != null && e.response!.statusCode == 401) {
        redirectUserToLogin();
      } else {
        return e.response;
      }
    } catch (e) {
      print("dnnbbb");
      print(e);
      return e;
    }

    return null;
  }

  Future<Response> postWithAuthClient(url, data,
      {
        withMedia = false,
        hasBody = true,
         Map<String, String>? headers

      }) async {
    final String token = await SharedPreferenceUtils.getToken();
    headers?['Authorization'] = 'Bearer $token';
    // final int? id = await SharedPreferenceUtils.getUserId();
    // print(id.toString());
    // print("jktoken:==> " + token.toString());
    // print("jk-api-key:==> " + Environment().config.API_KEY.toString());
    print("jk-api-url:==> " + url);
    print("jk-api-url:==> $token");

    log("x-api: ${Environment().config.API_KEY}");
    log("token: $token");
    late Response response;
    if (hasBody && data != null) {
      response = await dio.post(url,
          data: data,
          options: Options(
            headers: withMedia
                ? {
                    'Accept': '*/*',
                    'Authorization': 'Bearer $token',
                    "API-KEY": Environment().config.API_KEY,
                    'Content-Type': 'multipart/form-data',
                    // "authid": id
                  }
                : {
                    'Accept': '*/*',
                    'Authorization': 'Bearer $token',
                    "API-KEY": Environment().config.API_KEY,
                    // "authid": id,
                  },
          ));
    } else {
      response = await dio.post(url,
          options: Options(
            headers: withMedia
                ? {
                    // 'Accept': '*/*',
                    'Authorization': 'Bearer $token',
                    "API-KEY": Environment().config.API_KEY,
                    'Content-Type': 'multipart/form-data',
                    // "authid": id
                  }
                : {
                    // 'Accept': '*/*',
                    'Authorization': 'Bearer $token',
                    "API-KEY": Environment().config.API_KEY,
                    // "authid": id
                  },
          ));
    }

    if (response.statusCode == 401) {
      redirectUserToLogin();
    }
    return response;
  }

  Future<Response> puttWithAuthClient(url, data) async {
    final String token = await SharedPreferenceUtils.getToken();
    // final int? id = await SharedPreferenceUtils.getUserId();
    print("dataaa:$data");

    ///   print(id.toString());
    Response response = await dio.put(url,
        data: data,
        options: Options(
          headers: {
            // 'Accept': '*/*',
            'authorizationToken': token,
            "x-api-key": Environment().config.API_KEY,
            //"authid": id,
            //"authid": 139
          },
        ));

    if (response.statusCode == 401) {
      redirectUserToLogin();
    }
    return response;
  }

  Future<Response> deleteClient(url, data) async {
    final String token = await SharedPreferenceUtils.getToken();
    // final int? id = await SharedPreferenceUtils.getUserId();
    return await dio.delete(url,
        data: data,
        options: Options(
          headers: {
            // 'Accept': '*/*',
            'authorizationToken': token,
            "x-api-key": Environment().config.API_KEY,
            //   "authid": id
          },
        ));
  }

  Future<Response> deleteWithAuthClient(url) async {
    final String token = await SharedPreferenceUtils.getToken();

    /// final int? id = await SharedPreferenceUtils.getUserId();
    Response response = await dio.delete(url,
        options: Options(
          headers: {
            // 'Accept': '*/*',
            'authorizationToken': token,
            "x-api-key": Environment().config.API_KEY,
            //    "authid": id
          },
        ));

    if (response.statusCode == 401) {
      redirectUserToLogin();
    }
    return response;
  }

//   Future<Response> puttWithAuthClient(url,data)async{
//      final prefs = await SharedPreferences.getInstance();
//     final String? token = prefs.getString('token');
//   return await dio
//           .put(url,data: data,options:  Options(
//                 headers: {
//                   // 'Accept': '*/*',
// 'authorizationToken': token,
//                   "x-api-key":Environment().config.API_KEY
//                 },
//               ));
//  }

  redirectUserToLogin() async {
    await SharedPreferenceUtils.reset();
    await SharedPreferenceUtils.viewedIntro();
    // Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
    //     CustomPageRoute(Login()), (Route<dynamic> route) => false);
  }
}
