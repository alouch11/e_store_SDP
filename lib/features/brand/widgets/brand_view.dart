import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/brand/controllers/brand_controller.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/features/product/view/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BrandView extends StatelessWidget {
  final bool isHomePage;
  const BrandView({super.key, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandController>(
      builder: (context, brandProvider, child) {

        return brandProvider.brandList != null ? brandProvider.brandList!.isNotEmpty?
        isHomePage?
        ConstrainedBox(
          constraints:  const BoxConstraints(maxHeight: 75, minHeight: 0),
          child: ListView.builder(
            padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: brandProvider.brandList?.length,
              itemBuilder: (ctx,index){

                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                      isBrand: true,
                      id: brandProvider.brandList![index].id.toString(),
                      name: brandProvider.brandList![index].name,
                      image: brandProvider.brandList![index].image,
                      count: brandProvider.brandList![index].brandProductsCount,
                    )));
                  },
                  child: Padding(padding: EdgeInsets.only(left : Provider.of<LocalizationProvider>(context, listen: false).isLtr ?
                  Dimensions.paddingSizeDefault : 0,
                      right: brandProvider.brandList!.length == index + 1? Dimensions.paddingSizeDefault :
                      Provider.of<LocalizationProvider>(context, listen: false).isLtr ? 0 : Dimensions.paddingSizeDefault),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Container(width: 50, height: 50,
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: Theme.of(context).highlightColor,
                            boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme ? null :
                            [BoxShadow(color: Colors.grey.withOpacity(0.12), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))]),

                          child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.brandImageUrl!}/${brandProvider.brandList![index].image!}')),
                        ),
                      ],
                    ),

                  ),



                );

              }),
        ):

        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: (1/1.3),
            mainAxisSpacing: 10,
            crossAxisSpacing: 5,
          ),
          padding: EdgeInsets.zero,
          itemCount:  brandProvider.brandList?.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {

            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                  isBrand: true,
                  id: brandProvider.brandList![index].id.toString(),
                  name: brandProvider.brandList![index].name,
                  image: brandProvider.brandList![index].image,
                  count: brandProvider.brandList![index].brandProductsCount,
                )));
              },

                child: Stack(children: [
                Container(margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraExtraSmall,
                    left: Dimensions.paddingSizeExtraExtraSmall, right: Dimensions.paddingSizeExtraExtraSmall),
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraExtraSmall),
                decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 0))],),

              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraExtraSmall),
                      child: Container(decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraExtraSmall)),
                        child: CustomImage(image:'${Provider.of<SplashProvider>(context,listen: false).baseUrls!.brandImageUrl!}/${brandProvider.brandList![index].image!}'),),)),

                  SizedBox(height: (MediaQuery.of(context).size.width/4) * 0.3,
                    child: Center(child: Text(brandProvider.brandList![index].name!, maxLines: 1, overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))),

              ],

              ),

                ),
                  //Positioned(top: 2, left: 90, child: Container(
                   Positioned(top: 0, right: 0, child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                      child: Text("${brandProvider.brandList![index].brandProductsCount}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Colors.white))
                  )),
                ]
                )
            );

          },
        ) :const SizedBox(): BrandShimmer(isHomePage: isHomePage);

      },
    );
  }
}

class BrandShimmer extends StatelessWidget {
  final bool isHomePage;
  const BrandShimmer({super.key, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: (1/1.3),
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: isHomePage ? 8 : 30,
      shrinkWrap: true,
      physics: isHomePage ? const NeverScrollableScrollPhysics() : null,
      itemBuilder: (BuildContext context, int index) {

        return Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Colors.grey[100]!,
          enabled: true,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(child: Container(decoration: const BoxDecoration(color: ColorResources.white, shape: BoxShape.circle))),
            Container(height: 10, color: ColorResources.white, margin: const EdgeInsets.only(left: 25, right: 25)),
          ]),
        );

      },
    );
  }
}
