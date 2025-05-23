import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/helper/product_type.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/features/product/widget/products_view.dart';

class AllProductScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ProductType productType;
  AllProductScreen({super.key, required this.productType});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: productType == ProductType.featuredProduct ? '${getTranslated('featured_product', context)}':productType == ProductType.justForYou ?'${getTranslated('just_for_you', context)}':'${getTranslated('latest_product', context)}'),

      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: ProductView(isHomePage: false , productType: productType, scrollController: _scrollController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
