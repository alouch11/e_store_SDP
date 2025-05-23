import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/wishlist/provider/wishlist_provider.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/not_logged_in_bottom_sheet.dart';
import 'package:provider/provider.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;

  final int? productId;
  const FavouriteButton({super.key, this.backgroundColor = Colors.black, this.productId});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();


    return Consumer<WishListProvider>(
      builder: (context, wishProvider,_) {
        return GestureDetector(
          onTap: () {
            if (isGuestMode) {
             showModalBottomSheet(backgroundColor: Colors.transparent,
                 context: context, builder: (_)=> const NotLoggedInBottomSheet());
            }else if(wishProvider.isLoading){
            }
            else {
              wishProvider.addedIntoWish.contains(productId)?
              wishProvider.removeWishList(productId,) :
              wishProvider.addWishList(productId);
            }
          },
          child: Container(width: 40, height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.125), spreadRadius: 1, blurRadius: 1, offset: const Offset(0,0))]
            ),
            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Icon( wishProvider.addedIntoWish.contains(productId) ? CupertinoIcons.star_fill : CupertinoIcons.star,
                  color: wishProvider.addedIntoWish.contains(productId) ? const Color(
                      0xFFFAD805): Theme.of(context).primaryColor, size: 25),
            ),
          ),
        );
      }
    );
  }
}
