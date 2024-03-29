import 'dart:convert';
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
import '../screens/fare/model/bus_lines.dart';
import '../screens/fare/model/fare_list.dart';
import '../screens/fare/model/request_ticket.dart';
import '../screens/fare/model/ticket.dart';
import '../screens/fare/model/ticket_trip.dart';
import '../screens/terminal_agent/model/terminal_agent.dart';
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

  static String printJson(jsonObject, {bool isShowLog = true}) {
    JsonEncoder encoder = new JsonEncoder.withIndent("     ");
    String response = encoder.convert(jsonObject);
    if (true == isShowLog) {
      log(response);
    }
    return response;
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
        await storageToken.write(
          key: 'employeeShift',
          value: data.employeeShift.toString(),
        );
        await storageToken.write(
          key: 'employeeStatus',
          value: data.employeeStatus.toString(),
        );
        await storageToken.write(
          key: 'buslinesId',
          value: data.buslinesId.toString(),
        );
        await storageToken.write(
          key: 'busTerminalId',
          value: data.busTerminalId.toString(),
        );
        return data;
      } else {
        return throw Exception('Failed to load service');
      }
    } on DioError catch (error) {
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
      var employeeShift = await storageToken.read(key: 'employeeShift');
      var buslinesId = await storageToken.read(key: 'buslinesId');
      final servicesRes = await dioClient!.post(
          '/api/user/get-user-driver-by-busline-id',
          data: {'buslinesId': buslinesId, 'employeeShift': employeeShift});
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

  static Future<List<User>> apiGetUserFarecollect() async {
    try {
      showLoadding();
      var employeeShift = await storageToken.read(key: 'employeeShift');
      var buslinesId = await storageToken.read(key: 'buslinesId');
      final servicesRes = await dioClient!.post(
          '/api/user/get-user-farecollect-by-busline-id',
          data: {'buslinesId': buslinesId, 'employeeShift': employeeShift});
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

  static Future<List<BusLines>> apiFindBusLinesId(
    int busLinesId,
  ) async {
    showLoadding();
    try {
      Response response =
          await dioClient!.post('/api/bus-lines/find-by-bus-lines-id', data: {
        "busLinesId": busLinesId,
      });
      if (response.statusCode == 200) {
        List<BusLines> responseData = [];
        response.data['data'].forEach((element) {
          responseData.add(BusLines.fromJson(element));
        });
        EasyLoading.dismiss();
        return responseData;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<List<FareListModel>> apiFindWorksheetId(
    int worksheetId,
  ) async {
    showLoadding();
    try {
      Response response =
          await dioClient!.post('/api/bus-vehicle/find-by-worksheet-id', data: {
        "worksheetId": worksheetId,
      });
      if (response.statusCode == 200) {
        List<FareListModel> responseData = [];
        response.data['data'].forEach((element) {
          responseData.add(FareListModel.fromJson(element));
        });
        EasyLoading.dismiss();
        return responseData;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (error) {
      throw error;
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

  static Future<Response> apiSaveTicket(int? trip, int worksheetId,
      int busTerminalId, List<RequestTicket> typeHfare) async {
    printJson({
      "ticketBegin": trip == 1 ? true : false,
      "ticketEnd": false,
      "worksheetId": worksheetId,
      "busTerminalId": busTerminalId,
      "trip": trip,
      "typeHfare": typeHfare,
    });
    try {
      Response response = await dioClient!.post('/api/ticket/save', data: {
        "ticketBegin": trip == 1 ? true : false,
        "ticketEnd": false,
        "worksheetId": worksheetId,
        "busTerminalId": busTerminalId,
        "trip": trip,
        "typeHfare": typeHfare
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

  static Future<List<TicketTrip>> apiGetTicketByIdNew(
    int worksheetId,
  ) async {
    showLoadding();
    try {
      Response response = await dioClient!
          .get('/api/ticket-trip/find-by-worksheet-id/${worksheetId}');
      if (response.statusCode == 200) {
        List<TicketTrip> responseData = [];
        response.data['data'].forEach((element) {
          responseData.add(TicketTrip.fromJson(element));
        });
        EasyLoading.dismiss();
        return responseData;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<Response> setTimestamp(
      int terminalTimestampId, String terminalTimeDeparture) async {
    printJson({
      "terminalTimestampId": terminalTimestampId,
      "terminalTimeDeparture": terminalTimeDeparture,
    });
    try {
      Response response =
          await dioClient!.post('/api/timestamp/set-timestamp', data: {
        "terminalTimestampId": terminalTimestampId,
        "terminalTimeDeparture": terminalTimeDeparture,
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

  static Future<Response> setTimestampEnd(int terminalTimestampId,
      int worksheetId, String terminalTimeDeparture) async {
    printJson({
      "terminalTimestampId": terminalTimestampId,
      "terminalTimeDeparture": terminalTimeDeparture,
      "worksheetId": worksheetId
    });
    try {
      Response response =
          await dioClient!.post('/api/timestamp/set-timestamp-end', data: {
        "terminalTimestampId": terminalTimestampId,
        "terminalTimeDeparture": terminalTimeDeparture,
        "worksheetId": worksheetId
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

  static Future<List<TicketTrip>> apiGetTicketByIdTimestamp(
    int worksheetId,
  ) async {
    showLoadding();
    try {
      Response response = await dioClient!
          .get('/api/timestamp/find-by-worksheet-id/${worksheetId}');
      if (response.statusCode == 200) {
        List<TicketTrip> responseData = [];
        response.data['data'].forEach((element) {
          responseData.add(TicketTrip.fromJson(element));
        });
        EasyLoading.dismiss();
        return responseData;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<List<Ticket>> apiGetTicketById(
    int worksheetId,
  ) async {
    showLoadding();
    try {
      Response response = await dioClient!.post('/api/ticket/get-by-id', data: {
        "worksheetId": worksheetId,
      });
      if (response.statusCode == 200) {
        List<Ticket> responseData = [];
        response.data['data'].forEach((element) {
          responseData.add(Ticket.fromJson(element));
        });
        EasyLoading.dismiss();
        return responseData;
      } else {
        EasyLoading.dismiss();
        throw Exception('Failed to load service');
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<Response> apiUpdateStatus(
    int worksheetId,
  ) async {
    try {
      Response response =
          await dioClient!.get('/api/worksheet/update-status/${worksheetId}');
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
      String busVehicleNumber) async {
    try {
      printJson({
        "worksheetDate": worksheetDate.toString().split(".")[0],
        "worksheetTimeBegin": worksheetTimeBegin,
        "busVehiclePlateNo": busVehiclePlateNo,
        "worksheetDriver": worksheetDriver,
        "worksheetFarecollect": worksheetFarecollect,
        "busVehicleNumber": busVehicleNumber
      });
      Response response = await dioClient!.post('/api/worksheet/save', data: {
        "worksheetDate": worksheetDate.toString().split(".")[0],
        "worksheetTimeBegin": worksheetTimeBegin,
        "busVehiclePlateNo": busVehiclePlateNo,
        "worksheetDriver": worksheetDriver,
        "worksheetFarecollect": worksheetFarecollect,
        "busVehicleNumber": busVehicleNumber
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

  static Future<List<Driver>> apiGetListFarecollectSuccess() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes =
          await dioClient!.get('/api/driver/farecollect-success');
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

  static Future<List<TerminalAgent>> apiGetListTerminalAgentWaiting() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes = await dioClient!.get('/api/timestamp/waiting');
      if (servicesRes.statusCode == 200) {
        List<TerminalAgent> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(TerminalAgent.fromJson(element));
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

  static Future<List<TerminalAgent>> apiGetListTerminalAgentSuccess() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes = await dioClient!.get('/api/timestamp/success');
      if (servicesRes.statusCode == 200) {
        List<TerminalAgent> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(TerminalAgent.fromJson(element));
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

  static Future<List<TerminalAgent>> apiGetListTerminalAgentEnd() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes = await dioClient!.get('/api/timestamp/end');
      if (servicesRes.statusCode == 200) {
        List<TerminalAgent> response = [];
        servicesRes.data['data'].forEach((element) {
          response.add(TerminalAgent.fromJson(element));
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

  static Future<List<Driver>> apiGetListFarecollectProgress() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes =
          await dioClient!.get('/api/driver/farecollect-progress');
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

  static Future<List<Driver>> apiGetListDriverProgress() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes = await dioClient!.get('/api/driver/driver-progress');
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

  static Future<List<Driver>> apiGetListDriverSuccess() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes = await dioClient!.get('/api/driver/driver-success');
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

  static Future<List<Worksheet>> apiGetListWorksheetSuccess(
      String date, int? id) async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      printJson(
          {"worksheetId": id, "worksheetDate": date.isEmpty ? null : date});
      final servicesRes = await dioClient!
          .post('/api/worksheet/get-list-success', data: {
        "worksheetId": id,
        "worksheetDate": date.isEmpty ? null : date
      });
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

  static Future<List<Worksheet>> apiGetListWorksheetProgress() async {
    try {
      showLoadding();
      await Future.delayed(Duration(milliseconds: 300));
      final servicesRes =
          await dioClient!.post('/api/worksheet/get-list-progress', data: {});
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
