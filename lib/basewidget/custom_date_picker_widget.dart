import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/styles.dart';

class CustomDatePickerWidget extends StatefulWidget {
  final String? text;
  final String? image;
  final bool requiredField;
  final Function? selectDate;
  final bool isFromHistory;
  const CustomDatePickerWidget({super.key, this.text,this.image, this.requiredField = false,this.selectDate, this.isFromHistory = false});

  @override
  State<CustomDatePickerWidget> createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.selectDate as void Function()?,
      child: Container(
        margin:  const EdgeInsets.only(left: Dimensions.paddingSizeSmall,right: Dimensions.paddingSizeSmall),
        child: Container(
          height: 40,
          padding:  const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall,Dimensions.paddingSizeExtraSmall,0,Dimensions.paddingSizeExtraSmall),

          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Text(widget.text!, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                color: widget.text == 'yyyy-mm-dd hh:mm'? Theme.of(context).hintColor: widget.isFromHistory?
                Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).cardColor: null),),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            SizedBox(width: Dimensions.iconSizeMedium, height: Dimensions.iconSizeMedium, child: Image.asset(widget.image!,
                color: widget.isFromHistory? Theme.of(context).cardColor: null)),

          ],
          ),
        ),
      ),
    );
  }
}



