import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/order/widget/order_widget.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_provider.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/basewidget/product_shimmer.dart';
import 'package:flutter_spareparts_store/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ShopProductViewList extends StatefulWidget {
  final ScrollController scrollController;
  final int sellerId;
  const ShopProductViewList({super.key, required this.scrollController, required this.sellerId});

  @override
  State<ShopProductViewList> createState() => _ShopProductViewListState();
}

class _ShopProductViewListState extends State<ShopProductViewList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        return productProvider.sellerProduct != null ? (productProvider.sellerProduct!.products != null && productProvider.sellerProduct!.products!.isNotEmpty)?
        PaginatedListView(scrollController: widget.scrollController,
            onPaginate: (offset) async{
          await productProvider.getSellerProductList(widget.sellerId.toString(), offset!, context);
            },
            totalSize: productProvider.sellerProduct?.totalSize,
            offset: productProvider.sellerProduct?.offset,
            itemView: MasonryGridView.count(
              itemCount: productProvider.sellerProduct?.products?.length,
              crossAxisCount: 2,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ProductWidget(productModel: productProvider.sellerProduct!.products![index]);
              },
            )): const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noProduct, message: 'no_product',): const ProductShimmer(isEnabled: true, isHomePage: false);
      }
    );
  }
}
