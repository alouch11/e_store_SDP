import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/helper/price_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/features/home/model/shop_again_from_recent_store_model.dart';
import 'package:flutter_spareparts_store/features/shop/view/shop_screen.dart';
import 'package:provider/provider.dart';

class ShopAgainFromRecentStoreCard extends StatelessWidget {
  final ShopAgainFromRecentStoreModel? shopAgainFromRecentStoreModel;
  final int? length;
  final int? index;
  const ShopAgainFromRecentStoreCard({super.key, this.shopAgainFromRecentStoreModel, this.length,  this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:length == null? const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault):
      EdgeInsets.only(left : Provider.of<LocalizationProvider>(context, listen: false).isLtr ? Dimensions.paddingSizeSmall : 0,
          right: index! +1 == length? Dimensions.paddingSizeDefault : Provider.of<LocalizationProvider>(context, listen: false).isLtr ? 0 : Dimensions.paddingSizeDefault),
      child: Container(width: 260, height: 140,
        margin:  const EdgeInsets.only(right: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          boxShadow: Provider.of<ThemeProvider>(context).darkTheme ? null : [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),
        child: Row(children: [
          Container(width: 100, decoration: const BoxDecoration(shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusSmall), bottomLeft: Radius.circular(Dimensions.radiusSmall))),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(width: 80, height: 80, decoration:  BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.1), width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault),
                    )),
                  child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    child: CustomImage(image: "${Provider.of<SplashProvider>(context, listen: false).configModel?.baseUrls?.productThumbnailUrl}/"
                        "${shopAgainFromRecentStoreModel?.thumbnail}",),
                  ),
                ),

                Text(PriceConverter.convertPrice(context, shopAgainFromRecentStoreModel?.unitPrice),
                    style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),
              ],
              )
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row( mainAxisSize: MainAxisSize.min, children: [
              Container(width: 30, height: 30, decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CustomImage(image: "${Provider.of<SplashProvider>(context, listen: false).configModel?.baseUrls?.shopImageUrl}/"
                    "${shopAgainFromRecentStoreModel?.seller?.shop?.image}",),),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: Text('${shopAgainFromRecentStoreModel?.seller?.shop?.name}', overflow: TextOverflow.ellipsis)),
            ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            OutlinedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(
                sellerId: shopAgainFromRecentStoreModel?.seller?.id,
                temporaryClose: shopAgainFromRecentStoreModel?.seller?.shop?.temporaryClose??false,
                vacationStatus: shopAgainFromRecentStoreModel?.seller?.shop?.vacationStatus,
                vacationEndDate: null,
                vacationStartDate: null,
                name: shopAgainFromRecentStoreModel?.seller?.shop?.name,
                banner: shopAgainFromRecentStoreModel?.seller?.shop?.banner,
                image: shopAgainFromRecentStoreModel?.seller?.shop?.image,)));
            },
                child: Text(getTranslated("visit_again", context)!)),
          ],
          ),
          ),
        ],
        ),
      ),
    );
  }
}
