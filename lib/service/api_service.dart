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
import '../model/weather_main.dart';
import '../provider/user_login_provider.dart';
import '../screens/bus/model/bus_vehicle.dart';
import '../screens/driver/model/driver.dart';
import '../screens/work/model/worksheet.dart';
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

  static Future<Response> apiDeleteUser(String username) async {
    try {
      showLoadding();
      Response response =
          await dioClient!.get('/api/user/delete-user/' + username);
      if (response.statusCode == 200) {
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

  static Future<Response> apiDeleteRole(String code) async {
    try {
      showLoadding();
      Response response = await dioClient!.get('/api/role/delete-role/' + code);
      if (response.statusCode == 200) {
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

  static Future<WeatherMain> apiGetCurrentWeather() async {
    showLoadding();
    try {
      // Bangkok
      // String city = "Bangkok";
      String city = "Huai Khwang";
      String apiKey = "341c061275afe0918b8b600975aeceb6";
      var response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric&lang=th');
      if (response.statusCode == 200) {
        WeatherMain result = WeatherMain.fromJson(response.data);
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

  static Future<List<BusVehicle>> apiListBus() async {
    try {
      showLoadding();
      final servicesRes = await dioClient!.get('/api/bus-vehicle/get-list');
      if (servicesRes.statusCode == 200) {
        List<BusVehicle> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(BusVehicle.fromJson(element));
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

  static Future<List<BusModel>> apiGetListBus() async {
    try {
      showLoadding();
      final servicesRes =
          await dioClient!.get('/api/bus-vehicle/get-list-dropdown');
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

  static Future<Response> apiDeleteBusVehicle(int id) async {
    try {
      showLoadding();
      Response response = await dioClient!.get('/api/bus-vehicle/delete/${id}');
      if (response.statusCode == 200) {
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

  static Future<Response> apiSaveBus(String busVehicleNumber,
      String busVehiclePlateNo, String busVehiclePlateProv) async {
    try {
      Response response = await dioClient!.post('/api/bus-vehicle/save', data: {
        "busVehicleNumber": busVehicleNumber,
        "busVehiclePlateNo": busVehiclePlateNo,
        "busVehiclePlateProv": busVehiclePlateProv,
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

  static Future<Response> apiSaveWorksheet(
    DateTime worksheetDate,
    String worksheetTimeBegin,
    String busVehiclePlateNo,
    String worksheetDriver,
    String worksheetFarecollect,
  ) async {
    try {
      Response response = await dioClient!.post('/api/worksheet/save', data: {
        "worksheetDate": worksheetDate.toString().split(".")[0],
        "worksheetTimeBegin": worksheetTimeBegin,
        "busVehiclePlateNo": busVehiclePlateNo,
        "worksheetDriver": worksheetDriver,
        "worksheetFarecollect": worksheetFarecollect,
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

  static Future<List<Driver>> apiGetListFarecollect() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes = await dioClient!.get('/api/driver/farecollect');
      if (servicesRes.statusCode == 200) {
        List<Driver> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(Driver.fromJson(element));
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

  static Future<List<Driver>> apiGetListDriver() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes = await dioClient!.get('/api/driver/farecollect');
      if (servicesRes.statusCode == 200) {
        List<Driver> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(Driver.fromJson(element));
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

  static Future<List<Worksheet>> apiGetListWorksheet() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes = await dioClient!.get('/api/worksheet/get-list');
      if (servicesRes.statusCode == 200) {
        List<Worksheet> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(Worksheet.fromJson(element));
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
