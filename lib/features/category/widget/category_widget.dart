import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/category/domain/model/category_model.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:provider/provider.dart';
class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final int index;
  final int length;
  const CategoryWidget({super.key, required this.category, required this.index, required this.length});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left : Provider.of<LocalizationProvider>(context, listen: false).isLtr ? Dimensions.homePagePadding : 0,
        right: index+1 == length? Dimensions.paddingSizeDefault : Provider.of<LocalizationProvider>(context, listen: false).isLtr ? 0 : Dimensions.homePagePadding),
      child: Column( children: [
        Container(height: 70, width: 70, decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125),width: .25),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).primaryColor.withOpacity(.125)),
          child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}''/${category.icon}'))),

        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Center(child: SizedBox(width: 70,
            child: Text(category.name!, textAlign: TextAlign.center, maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                  color: ColorResources.getTextTitle(context)))))]),
    );
  }
}
