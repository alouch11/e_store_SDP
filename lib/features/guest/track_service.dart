
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/basewidget/custom_button.dart';
import 'package:flutter_spareparts_store/basewidget/custom_textfield.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';
import '../sale/provider/sale_provider.dart';
import '../sale/view/sale_details_screen.dart';

class GuestTrackServiceScreen extends StatefulWidget {
  const GuestTrackServiceScreen({super.key});


  @override
  State<GuestTrackServiceScreen> createState() => _GuestTrackServiceScreenState();
}

class _GuestTrackServiceScreenState extends State<GuestTrackServiceScreen> {
  TextEditingController saleIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('TRACK_SERVICE', context)),
      body: Consumer<SaleProvider>(
        builder: (context, saleTrackingProvider, _) {
          return
            Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: ListView(children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              CustomTextField(controller: saleIdController,
                prefixIcon: Images.serviceIcon,
                isAmount: false,
                inputType: TextInputType.text,
                hintText: getTranslated('service_number', context),
                labelText: getTranslated('service_number', context),),

              const SizedBox(height: Dimensions.paddingSizeDefault),

              if (saleTrackingProvider.searching) const Center(child: CircularProgressIndicator()) else CustomButton(buttonText: '${getTranslated('search_service', context)}', onTap: () async {
                String saleNumber = saleIdController.text.trim();
                if(saleNumber.isEmpty){
                  showCustomSnackBar('${getTranslated('service_number_is_required', context)}', context);
                }
                else{
                  await saleTrackingProvider.trackYourSale(saleNo: saleNumber.toString()).then((value) {
                    if (value.response != null && value.response!.statusCode == 200) {
                      int? saleId = value.response!.data[0]['BLMASKODU'];
                     Navigator.push(context, MaterialPageRoute(builder: (_)=> SaleDetailsScreen(fromTrack: true,
                     saleId: saleId)));
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






