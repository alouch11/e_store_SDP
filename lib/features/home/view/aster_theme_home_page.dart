import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/helper/product_type.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/banner/controllers/banner_controller.dart';
import 'package:flutter_spareparts_store/features/brand/controllers/brand_controller.dart';
import 'package:flutter_spareparts_store/features/category/controllers/category_controller.dart';
import 'package:flutter_spareparts_store/features/product/provider/home_category_product_provider.dart';
import 'package:flutter_spareparts_store/features/notification/provider/notification_provider.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/features/product/provider/product_provider.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/shop/provider/shop_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/features/shop/provider/top_seller_provider.dart';
import 'package:flutter_spareparts_store/features/wishlist/provider/wishlist_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/title_row.dart';
import 'package:flutter_spareparts_store/features/home/shimmer/featured_product_shimmer.dart';
import 'package:flutter_spareparts_store/features/home/shimmer/order_again_shimmer.dart';
import 'package:flutter_spareparts_store/features/home/widget/announcement.dart';
import 'package:flutter_spareparts_store/features/home/widget/aster_theme/find_what_you_need_shimmer.dart';
import 'package:flutter_spareparts_store/features/home/widget/aster_theme/find_what_you_need_view.dart';
import 'package:flutter_spareparts_store/features/home/widget/aster_theme/more_store_view.dart';
import 'package:flutter_spareparts_store/features/home/widget/aster_theme/order_again_view.dart';
import 'package:flutter_spareparts_store/features/banner/widgets/banners_view.dart';
import 'package:flutter_spareparts_store/features/home/widget/notifications_widget_home_page.dart';
import 'package:flutter_spareparts_store/features/product/widget/featured_product_view.dart';
import 'package:flutter_spareparts_store/features/home/shimmer/flash_deal_shimmer.dart';
import 'package:flutter_spareparts_store/features/banner/widgets/single_banner.dart';
import 'package:flutter_spareparts_store/features/product/widget/home_category_product_view.dart';
import 'package:flutter_spareparts_store/features/home/widget/just_for_you/just_for_you.dart';
import 'package:flutter_spareparts_store/features/product/widget/latest_product_view.dart';
import 'package:flutter_spareparts_store/features/shop/widget/more_store_list_view.dart';
import 'package:flutter_spareparts_store/features/product/widget/products_view.dart';
import 'package:flutter_spareparts_store/features/home/widget/search_widget_home_page.dart';
import 'package:flutter_spareparts_store/features/product/view/view_all_product_screen.dart';
import 'package:flutter_spareparts_store/features/search/search_screen.dart';
import 'package:provider/provider.dart';


class AsterThemeHomePage extends StatefulWidget {
  const AsterThemeHomePage({super.key});

  @override
  State<AsterThemeHomePage> createState() => _AsterThemeHomePageState();
}

class _AsterThemeHomePageState extends State<AsterThemeHomePage> {
  final ScrollController _scrollController = ScrollController();


  Future<void> _loadData(bool reload) async {
    await Provider.of<CategoryController>(Get.context!, listen: false).getCategoryList(reload);
    await Provider.of<HomeCategoryProductProvider>(Get.context!, listen: false).getHomeCategoryProductList(reload);
    await Provider.of<TopSellerProvider>(Get.context!, listen: false).getTopSellerList(reload);
    await Provider.of<BrandController>(Get.context!, listen: false).getBrandList(reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false).getLatestProductList(1, reload: reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false).getFeaturedProductList('1', reload: reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false).getLProductList('1', reload: reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false).findWhatYouNeed();
    await Provider.of<ProductProvider>(Get.context!, listen: false).getJustForYouProduct();
    await Provider.of<SellerProvider>(Get.context!, listen: false).getMoreStore();
    await Provider.of<NotificationProvider>(Get.context!, listen: false).getNotificationList(1,'unread');
    if(Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()){
      await Provider.of<ProfileProvider>(Get.context!, listen: false).getUserInfo(Get.context!);
      await Provider.of<ProductProvider>(Get.context!, listen: false).getShopAgainFromRecentStore();
      await Provider.of<WishListProvider>(Get.context!, listen: false).getWishList();

    }
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();

    singleVendor = Provider.of<SplashProvider>(context, listen: false).configModel!.businessMode == "single";
    _loadData(false);


  }


  @override
  Widget build(BuildContext context) {
    //List<String?> types =[getTranslated('new_arrival', context),getTranslated('top_product', context), getTranslated('best_selling', context),  getTranslated('discounted_product', context)];
    List<String?> types =[getTranslated('new_arrival', context),getTranslated('top_product', context)];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadData( true);
            //await Provider.of<FlashDealProvider>(Get.context!, listen: false).getMegaDealList(true, false);
          },
          child: CustomScrollView(controller: _scrollController, slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).highlightColor,
              title: Image.asset(Images.logoWithNameImage, height: 35), actions:  [
              NotificationsWidgetHomePage(),
            ],
            ),

            SliverToBoxAdapter(child: Provider.of<SplashProvider>(context, listen: false).configModel!.announcement!.status == '1'?
            Consumer<SplashProvider>(
              builder: (context, announcement, _){
                return (announcement.configModel!.announcement!.announcement != null && announcement.onOff)?
                AnnouncementScreen(announcement: announcement.configModel!.announcement):const SizedBox();
              },

            ):const SizedBox(),),

            // Search Button
            SliverPersistentHeader(pinned: true,
                delegate: SliverDelegate(
                    child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
                        child: const SearchWidgetHomePage()))),

            SliverToBoxAdapter(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const BannersView(),
                const SizedBox(height: Dimensions.homePagePadding),

                // Find what you need
                Consumer<ProductProvider>(
                  builder: (context, productProvider, _) {
                    return productProvider.findWhatYouNeedModel != null ? (productProvider.findWhatYouNeedModel!.findWhatYouNeed != null && productProvider.findWhatYouNeedModel!.findWhatYouNeed!.isNotEmpty)?
                    Padding(padding:  const EdgeInsets.only(bottom: Dimensions.homePagePadding, top: Dimensions.homePagePadding),
                      child: Column(children: [
                        TitleRow(title: getTranslated('find_what_you_need', context)),
                        const SizedBox(height: Dimensions.homePagePadding),
                        const SizedBox(height: 150, child: FindWhatYouNeedView()),
                      ],
                      ),
                    ):const SizedBox() : const FindWhatYouNeedShimmer();
                  }
                ),



                //Order Again
                (Provider.of<AuthController>(context, listen: false).isLoggedIn())?
                Consumer<OrderProvider>(
                  builder: (context, orderProvider,_) {
                    return orderProvider.deliveredOrderModel != null ? (orderProvider.deliveredOrderModel!.orders != null && orderProvider.deliveredOrderModel!.orders!.isNotEmpty)?
                      const Padding(padding: EdgeInsets.all(Dimensions.homePagePadding),
                      child: OrderAgainView(),
                    ):Consumer<BannerController>(builder: (context, bannerProvider, child){
                      return bannerProvider.sideBarBanner != null?
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.bannerPadding, right: Dimensions.bannerPadding ),
                          child: SingleBannersView(bannerModel : bannerProvider.sideBarBanner, height: MediaQuery.of(context).size.width * 1.2)):const SizedBox();}): const OrderAgainShimmerShimmer();
                  }
                ): Consumer<BannerController>(builder: (context, bannerProvider, child){
                  return bannerProvider.sideBarBanner != null?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.bannerPadding, right: Dimensions.bannerPadding ),
                      child: SingleBannersView(bannerModel : bannerProvider.sideBarBanner, height: MediaQuery.of(context).size.width * 1.2)):const SizedBox();}),
                const SizedBox(height: Dimensions.paddingSizeDefault,),


                //footer banner
                Consumer<BannerController>(builder: (context, footerBannerProvider, child){
                  return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.length>1?
                   Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.homePagePadding, right: Dimensions.homePagePadding ),
                      child: SingleBannersView(bannerModel: footerBannerProvider.footerBannerList?[1],)):const SizedBox();}),




                // Featured Products
                Consumer<ProductProvider>(
                    builder: (context, featured,_) {
                      return  featured.featuredProductList != null?  featured.featuredProductList!.isNotEmpty ?
                      Stack(children: [
                          Padding(padding: const EdgeInsets.only(left: 50, bottom: 25),
                            child: Container(width: MediaQuery.of(context).size.width - 50,
                              height: Dimensions.featuredProductCard,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topLeft : Radius.circular(Dimensions.paddingSizeDefault),
                                      bottomLeft: Radius.circular(Dimensions.paddingSizeDefault)),
                                  color: Theme.of(context).colorScheme.onSecondaryContainer
                              ),),
                          ),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                child: Padding(padding: const EdgeInsets.only(top: 20, left: 50,bottom: Dimensions.paddingSizeSmall),
                                    child: TitleRow( title: getTranslated('featured_products', context),
                                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(productType: ProductType.featuredProduct))))),
                              ),
                              Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                                child: FeaturedProductView(scrollController: _scrollController, isHome: true,),),
                            ],
                          ),
                        ],
                      ):const SizedBox() :  const FeaturedProductShimmer();}),




                //Cyber Monday Banner
                Consumer<BannerController>(builder: (context, bannerProvider, child){
                  return bannerProvider.topSideBarBannerBottom != null?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.bannerPadding, right: Dimensions.bannerPadding ),
                      child: SingleBannersView(bannerModel : bannerProvider.topSideBarBannerBottom, height: MediaQuery.of(context).size.width * 1.2)):const SizedBox();}),


                ///Recommended Product View
                //const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePagePadding),
                //    child: RecommendedProductView(fromAsterTheme: true)),


                // Latest Products

                const LatestProductView(),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                //blackFriday
                Consumer<BannerController>(builder: (context, bannerProvider, child){
                  return bannerProvider.footerBannerList != null && bannerProvider.footerBannerList!.isNotEmpty?
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left:Dimensions.homePagePadding, right: Dimensions.homePagePadding ),
                      child: SingleBannersView(bannerModel : bannerProvider.footerBannerList![0], height: MediaQuery.of(context).size.width * 0.5)):const SizedBox();}),




                //Just For You


                 SizedBox( child: Consumer<ProductProvider>(
                  builder: (context, productProvider,_) {
                    return (productProvider.justForYouProduct != null && productProvider.justForYouProduct!.isNotEmpty)?
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        TitleRow(title: getTranslated('just_for_you', context), onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(productType: ProductType.justForYou)));
                        },),
                        JustForYouView(productList: productProvider.justForYouProduct),
                      ],
                    ):const SizedBox();
                  }
                )),


                //More Store
                Consumer<SellerProvider>(
                  builder: (context, moreStoreProvider, _) {

                    return moreStoreProvider.moreStoreList.isNotEmpty ?
                    Padding(padding:  const EdgeInsets.fromLTRB(0, Dimensions.paddingSizeSmall, 0, Dimensions.paddingSizeSmall,),
                      child: Column(children: [
                        TitleRow(title: getTranslated('more_store', context),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  MoreStoreViewListView(title: getTranslated('more_store', context),)))
                        ),
                        const SizedBox(height: Dimensions.homePagePadding),
                        const SizedBox(height: 100, child: MoreStoreView(isHome: true,)),
                      ],
                      ),
                    ):const SizedBox();
                  }
                ),





                //Home category
                const Padding(padding: EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  child: HomeCategoryProductView(isHomePage: true),
                ),
                const SizedBox(height: Dimensions.homePagePadding),


                Consumer<BannerController>(builder: (context, footerBannerProvider, child){
                  return footerBannerProvider.mainSectionBanner != null?
                  SingleBannersView(bannerModel: footerBannerProvider.mainSectionBanner, height: MediaQuery.of(context).size.width/4,):const SizedBox();}),
                // const SizedBox(height: Dimensions.homePagePadding),




                //Category filter
                Consumer<ProductProvider>(
                    builder: (ctx,prodProvider,child) {
                      return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeSmall, Dimensions.paddingSizeExtraSmall),
                        child: Row(children: [
                          Expanded(child: Text(prodProvider.title == 'xyz' ? getTranslated('new_arrival',context)!:prodProvider.title!, style: titleHeader)),
                          prodProvider.latestProductList != null ? PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(value: ProductType.newArrival, textStyle: textRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ), child: Text(getTranslated('new_arrival',context)!)),
                                  PopupMenuItem(value: ProductType.topProduct, textStyle: textRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ), child: Text(getTranslated('top_product',context)!)),
                                //  PopupMenuItem(value: ProductType.bestSelling, textStyle: textRegular.copyWith(
                                //    color: Theme.of(context).hintColor,
                               //   ), child: Text(getTranslated('best_selling',context)!)),
                               //   PopupMenuItem(value: ProductType.discountedProduct, textStyle: textRegular.copyWith(
                              //      color: Theme.of(context).hintColor,
                               //   ), child: Text(getTranslated('discounted_product',context)!)),
                                ];
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                              child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical:Dimensions.paddingSizeSmall ),
                                  child: Image.asset(Images.dropdown, scale: 3)),
                              onSelected: (dynamic value) {
                                if(value == ProductType.newArrival){
                                  Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[0]);
                                }else if(value == ProductType.topProduct){
                                  Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[1]);
                                }else if(value == ProductType.bestSelling){
                                  Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[2]);
                                }else if(value == ProductType.discountedProduct){
                                  Provider.of<ProductProvider>(context, listen: false).changeTypeOfProduct(value, types[3]);
                                }

                                ProductView(isHomePage: false, productType: value, scrollController: _scrollController);
                                Provider.of<ProductProvider>(context, listen: false).getLatestProductList(1, reload: true);


                              }
                          ) : const SizedBox(),
                        ]),
                      );
                    }),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
                  child: ProductView(isHomePage: false, productType: ProductType.newArrival, scrollController: _scrollController),
                ),
                const SizedBox(height: Dimensions.homePagePadding),

              ],
              ),
            )
          ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}
