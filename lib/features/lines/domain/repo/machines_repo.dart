
import 'package:flutter_spareparts_store/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_spareparts_store/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class MachinesRepo {
  final DioClient? dioClient;

  MachinesRepo({required this.dioClient});



  Future<ApiResponse> getMachineEmergencyList(int machineid,int? level) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineEmergencyUri}$machineid&level=$level');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getMachineTechnicalDocList(int machineid) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineTechnicalDocUri}$machineid');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> getMachineParametersList(int machineid) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineParametersUri}$machineid');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getMachineMaintenanceList(int machineid,int? maintenance) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineMaintenanceUri}$machineid&maintenance=$maintenance');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getMachineAssemblyList(int machineid) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineAssemblyListUri}$machineid');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getMachineAssemblyParts(int machineid,String assemblycode) async {
    try {

      final response = await dioClient!.get('${AppConstants.machineAssemblyPartsUri}$machineid&assemblycode=$assemblycode');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
