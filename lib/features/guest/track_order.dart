
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/custom_textfield.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen.dart';
import 'package:provider/provider.dart';

class GuestTrackOrderScreen extends StatefulWidget {
  const GuestTrackOrderScreen({super.key});


  @override
  State<GuestTrackOrderScreen> createState() => _GuestTrackOrderScreenState();
}

class _GuestTrackOrderScreenState extends State<GuestTrackOrderScreen> {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();


  final singleDropDownKey = GlobalKey<DropdownSearchState>();
  final multipleDropDownKey = GlobalKey<DropdownSearchState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('TRACK_ORDER', context)),
      body: Consumer<OrderProvider>(
        builder: (context, orderTrackingProvider, _) {
          return
            Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: ListView(children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              CustomTextField(controller: orderIdController,
                prefixIcon: Images.orderIdIcon,
                isAmount: false,
                inputType: TextInputType.text,
                hintText: getTranslated('order_Number', context),
                labelText: getTranslated('order_Number', context),),

              const SizedBox(height: Dimensions.paddingSizeDefault),

              const SizedBox(height: Dimensions.paddingSizeExtraLarge),


              if (orderTrackingProvider.searching) const Center(child: CircularProgressIndicator()) else CustomButton(buttonText: '${getTranslated('search_order', context)}', onTap: () async {
                String orderNo = orderIdController.text.trim();
                String phone = phoneNumberController.text.trim();
                if(orderNo.isEmpty){
                  showCustomSnackBar('${getTranslated('order_number_is_required', context)}', context);
                }

                else{
                  await orderTrackingProvider.trackYourOrder(orderNo: orderNo.toString(), phoneNumber: phone).then((value) {
                    if (value.response != null && value.response!.statusCode == 200) {
                      int? orderId = value.response!.data[0]['BLMASKODU'];
                     Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderDetailsScreen(fromTrack: true,
                     orderId: orderId, phone: phone)));
                    }

                  });

                }
              },),

            ],),
          );
        }
      )
    );
  }

}






