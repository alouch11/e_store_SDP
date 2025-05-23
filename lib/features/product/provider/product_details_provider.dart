import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/sale/domain/model/service_body.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/data/model/response_model.dart';
import 'package:flutter_spareparts_store/features/order/domain/model/review_model.dart';
import 'package:flutter_spareparts_store/features/product/domain/repo/product_details_repo.dart';
import 'package:flutter_spareparts_store/features/product/domain/model/product_details_model.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_provider.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final ProductDetailsRepo? productDetailsRepo;
  ProductDetailsProvider({required this.productDetailsRepo});

  List<ReviewModel>? _reviewList;
  int? _imageSliderIndex;
  bool _wish = false;
  int? _quantity = 0;
  int? _variantIndex;
  List<int>? _variationIndex;
  int _rating = 0;
  bool _isLoading = false;
  int? _orderCount;
  int? _saleCount;
  String? _qtyblock;
  String? _qtyorder;
  int? _wishCount;
  String? _sharableLink;
  String? _errorText;
  bool _hasConnection = true;
  bool _isDetails = false;
  bool get isDetails =>_isDetails;
  bool _isDetailsByCode = false;
  bool get isDetailsByCode =>_isDetailsByCode;

  List<ReviewModel>? get reviewList => _reviewList;
  int? get imageSliderIndex => _imageSliderIndex;
  bool get isWished => _wish;
  int? get quantity => _quantity;
  int? get variantIndex => _variantIndex;
  List<int>? get variationIndex => _variationIndex;
  int get rating => _rating;
  bool get isLoading => _isLoading;
  int? get orderCount => _orderCount;
  int? get saleCount => _saleCount;
  String? get qtyorder => _qtyorder;
  String? get qtyblock => _qtyblock;
  int? get wishCount => _wishCount;
  String? get sharableLink => _sharableLink;
  String? get errorText => _errorText;
  bool get hasConnection => _hasConnection;
  ProductDetailsModel? _productDetailsModel;
  ProductDetailsModel? get productDetailsModel => _productDetailsModel;


  ProductDetailsByCodeModel? _productDetailsModelByCode;
  ProductDetailsByCodeModel? get productDetailsModelByCode => _productDetailsModelByCode;


  Future<void> getProductDetails(BuildContext context, String productId) async {

    _isDetails = true;
    ApiResponse apiResponse = await productDetailsRepo!.getProduct(productId);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isDetails = false;
      _productDetailsModel = ProductDetailsModel.fromJson(apiResponse.response!.data);


    } else {
      _isDetails = false;
      if(context.mounted){}
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    _isDetails = false;
    notifyListeners();
  }



  Future<void> getProductDetailsByCode(BuildContext context, String productCode) async {

    _isDetailsByCode = true;
    _productDetailsModelByCode = null;
    ApiResponse apiResponse = await productDetailsRepo!.getProductByCode(productCode);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isDetailsByCode = false;
      _productDetailsModelByCode = ProductDetailsByCodeModel.fromJson(apiResponse.response!.data);
    } else {
      _isDetailsByCode = false;
      if(context.mounted){}
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    _isDetailsByCode = false;
    notifyListeners();
  }


/*  MachineMaintenanceModel? machineMaintenance;
  Future<void> getMachineMaintenanceList(int offset,int machineid,int? maintenance) async {

    ApiResponse apiResponse = await machinesRepo!.getMachineMaintenanceList(machineid,maintenance);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      machineMaintenance = MachineMaintenanceModel.fromJson(apiResponse.response?.data);
    }
    else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }*/



  Future<void> initProduct(int? productId,String? productSlug, BuildContext context) async {
    _hasConnection = true;
    _variantIndex = 0;
    //ApiResponse reviewResponse = await productDetailsRepo!.getReviews(productId.toString());
    //if (reviewResponse.response != null && reviewResponse.response!.statusCode == 200) {
      _reviewList = [];
      //reviewResponse.response!.data.forEach((reviewModel) => _reviewList!.add(ReviewModel.fromJson(reviewModel)));
      _imageSliderIndex = 0;
      _quantity = 1;
 /*   } else {
      if(context.mounted){}
      ApiChecker.checkApi( reviewResponse);
    }*/
    notifyListeners();
  }


  void initData(ProductDetailsModel product, int? minimumOrderQuantity, BuildContext context) {
    _variantIndex = 0;
    _quantity = minimumOrderQuantity;
    _variationIndex = [];
    for (int i=0; i<= product.choiceOptions!.length; i++) {
      _variationIndex!.add(0);
    }
  }

  void removePrevReview() {
    _reviewList = null;
    _sharableLink = null;
  }

  void getCount(String productID, BuildContext context) async {
    ApiResponse apiResponse = await productDetailsRepo!.getCount(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _orderCount = apiResponse.response!.data['order_count'];
      _saleCount = apiResponse.response!.data['sale_count'];
      _wishCount = apiResponse.response!.data['wishlist_count'];
      _qtyblock = apiResponse.response!.data['qty_block'].toString();
      _qtyorder = apiResponse.response!.data['qty_order'].toString();

    } else {
      if(context.mounted){}
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  void getSharableLink(String productID, BuildContext context) async {
    ApiResponse apiResponse = await productDetailsRepo!.getSharableLink(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _sharableLink = apiResponse.response!.data;
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  void setErrorText(String? error) {
    _errorText = error;
    notifyListeners();
  }

  void removeData() {
    _errorText = null;
    _rating = 0;
    notifyListeners();
  }

  void setImageSliderSelectedIndex(int selectedIndex) {
    _imageSliderIndex = selectedIndex;
    notifyListeners();
  }

  void changeWish() {
    _wish = !_wish;
    notifyListeners();
  }

  void setQuantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  void setCartVariantIndex(int? minimumOrderQuantity,int index, BuildContext context) {
    _variantIndex = index;
    _quantity = minimumOrderQuantity;
    notifyListeners();
  }

  void setCartVariationIndex(int? minimumOrderQuantity, int index, int i, BuildContext context) {
    _variationIndex![index] = i;
    _quantity = minimumOrderQuantity;
    notifyListeners();
  }

  void setRating(int rate) {
    _rating = rate;
    notifyListeners();
  }

  Future<ResponseModel> submitService(ServiceBodySale serviceBody, List<File> files, String token) async {
    _isLoading = true;
    notifyListeners();

    http.StreamedResponse response = await productDetailsRepo!.submitService(serviceBody, files, token);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      Provider.of<SaleProvider>(Get.context!, listen: false).serviceImages = [];
     // _rating = 0;
      responseModel = ResponseModel('${getTranslated('Review submitted successfully', Get.context!)}', true);
      _errorText = null;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('${response.statusCode} ${response.reasonPhrase}');
      }
      responseModel = ResponseModel('${response.statusCode} ${response.reasonPhrase}', false);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  bool isValidYouTubeUrl(String url) {
    RegExp regex = RegExp(
      r'^https?:\/\/(?:www\.)?(youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
    );

    return regex.hasMatch(url);
  }

}
