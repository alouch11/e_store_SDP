import 'dart:io';
import 'package:flutter_spareparts_store/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_spareparts_store/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/service_body.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class ProductDetailsRepo {
  final DioClient? dioClient;
  ProductDetailsRepo({required this.dioClient});

  Future<ApiResponse> getProduct(String productID) async {
    try {
      final response = await dioClient!.get('${AppConstants.productDetailsUri}$productID?guest_id=1');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getProductByCode(String productCode) async {
    try {
      final response = await dioClient!.get('${AppConstants.productDetailsByCodeUri}$productCode?guest_id=1');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getReviews(String productID) async {
    try {
      final response = await dioClient!.get(AppConstants.productReviewUri+productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCount(String productID) async {
    try {
      final response = await dioClient!.get(AppConstants.counterUri+productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSharableLink(String productID) async {
    try {
      final response = await dioClient!.get(AppConstants.socialLinkUri+productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> submitService(ServiceBodySale serviceBody, List<File> files, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.submitNoteUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    for(int index=0; index <files.length ; index++) {
      if(files[index].path.isNotEmpty) {
        request.files.add(http.MultipartFile(
          'fileUpload[$index]',
          files[index].readAsBytes().asStream(),
          files[index].lengthSync(),
          filename: files[index].path.split('/').last,
        ));
      }
    }
    //request.fields.addAll(<String, String>{'product_id': reviewBody.productId!, 'comment': reviewBody.comment!, 'rating': reviewBody.rating!});
    request.fields.addAll(<String, String>{'sale_details_id': serviceBody.salId!.toString(),'product_id': serviceBody.productId!, 'comment': serviceBody.comment!});
    http.StreamedResponse response = await request.send();
    return response;
  }
}