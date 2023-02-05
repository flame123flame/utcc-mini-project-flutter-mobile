import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/src/options.dart' as op;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:utcc_mobile/model/bus_model.dart';

import '../model/role_model.dart';
import '../model/user.dart';
import '../model/users_login.dart';
import '../provider/user_login_provider.dart';
import 'configDio.dart';

class ApiService {
  static Dio? dioClient = getDio();
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  static showLoadding() {
    EasyLoading.show(
      indicator: Image.asset(
        'assets/images/Loading_2.gif',
        height: 70,
      ),
    );
  }

  static Future<UserLogin> Login(String username, String password) async {
    try {
      Response response = await dioClient!.post('/token/authenticate', data: {
        "username": username,
        "password": password,
      });

      if (response.statusCode == 200) {
        UserLogin data = UserLogin.fromJson(response.data);
        await storageToken.write(
          key: 'jwttoken',
          value: data.jwttoken,
        );
        await storageToken.write(
          key: 'username',
          value: username,
        );
        await storageToken.write(
          key: 'password',
          value: password,
        );
        await storageToken.write(
          key: 'employeeId',
          value: data.employeeId.toString(),
        );
        return data;
      } else {
        return throw Exception('Failed to load service');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<Response> apiGetPin(String pin) async {
    showLoadding();
    var getUserName = await storageToken.read(key: 'username');
    try {
      Response response = await dioClient!.post('/api/user/check-pin',
          data: {"username": getUserName, "pin": pin});
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        return response;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (error) {
      EasyLoading.dismiss();
      print(error);
      throw error;
    }
  }

  static Future<Response> apiSetPin(String pin) async {
    var getUserName = await storageToken.read(key: 'username');
    try {
      Response response = await dioClient!.post('/api/user/set-pin',
          data: {"username": getUserName, "pin": pin});
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load service');
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<List<User>> apiGetUser() async {
    try {
      showLoadding();
      final servicesRes = await dioClient!.post('/api/user/get-user', data: {});
      if (servicesRes.statusCode == 200) {
        List<User> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(User.fromJson(element));
        });
        EasyLoading.dismiss();
        return response;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (e) {
      print("Exception: $e");
      EasyLoading.dismiss();

      throw e;
    }
  }

  static Future<List<RoleModel>> apiGetRole() async {
    try {
      showLoadding();
      final servicesRes = await dioClient!.get('/api/role/get-list');
      if (servicesRes.statusCode == 200) {
        List<RoleModel> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(RoleModel.fromJson(element));
        });
        EasyLoading.dismiss();
        return response;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (e) {
      print("Exception: $e");
      EasyLoading.dismiss();

      throw e;
    }
  }

  static Future<UserLogin> apiGetUserById(int? id) async {
    showLoadding();
    try {
      Response response = await dioClient!
          .post('/api/employee/find-by-id', data: {"employeeId": 11});
      if (response.statusCode == 200) {
        UserLogin result = UserLogin.fromJson(response.data['data']);
        EasyLoading.dismiss();
        return result;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (error) {
      EasyLoading.dismiss();
      print(error);
      throw error;
    }
  }

  static Future<Response> SaveRole(
      String code, String role, String roleDescription, String munuList) async {
    try {
      Response response = await dioClient!.post('/api/role/save', data: {
        "roleCode": code,
        "roleName": role,
        "roleDescription": roleDescription.isEmpty ? null : roleDescription,
        "munuList": munuList,
      });

      if (response.statusCode == 200) {
        return response;
      } else {
        return throw Exception('Failed to load service');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<List<BusModel>> apiGetListBus() async {
    try {
      showLoadding();
      final servicesRes = await dioClient!.get('/api/bus/get-list');
      if (servicesRes.statusCode == 200) {
        List<BusModel> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(BusModel.fromJson(element));
        });
        EasyLoading.dismiss();
        return response;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (e) {
      print("Exception: $e");
      EasyLoading.dismiss();

      throw e;
    }
  }

  static Future<Response> apiSaveBus(
      String busNo,
      String fare,
      String discountFare,
      String busType,
      String busPlate,
      String busProvince) async {
    try {
      print(fare.split("."));
      Response response = await dioClient!.post('/api/bus/save', data: {
        "busNo": busNo,
        "fare":
            fare.split(".").length == 1 ? int.parse(fare) : double.parse(fare),
        "discountFare": discountFare.split(".").length == 1
            ? int.parse(discountFare)
            : double.parse(discountFare),
        "busType": busType,
        "busPlate": busPlate,
        "busProvince": busProvince,
      });

      if (response.statusCode == 200) {
        return response;
      } else {
        return throw Exception('Failed to load service');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<Response> apiSaveUser(
    String username,
    String password,
    String confirmPassword,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String position,
    String prefix,
    String roleCode,
  ) async {
    try {
      Response response = await dioClient!.post('/api/user/register', data: {
        "username": username,
        "password": password,
        "confirmPassword": confirmPassword,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "position": position,
        "prefix": prefix,
        "roleCode": roleCode,
      });

      if (response.statusCode == 200) {
        return response;
      } else {
        return throw Exception('Failed to load service');
      }
    } catch (error) {
      throw error;
    }
  }
}
