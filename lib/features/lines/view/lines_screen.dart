
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/provider/lines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/widget/lines_widget.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:provider/provider.dart';


class LinesScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const LinesScreen({super.key, this.isBacButtonExist = true});

  @override
  State<LinesScreen> createState() => _LinesScreenState();
}



class _LinesScreenState extends State<LinesScreen> {

  ScrollController scrollController  = ScrollController();
  bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();



  @override
  void initState() {
    if(!isGuestMode){
     // Provider.of<LinesProvider>(context, listen: false).getLinesList(1,'Bekoko');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     appBar: CustomAppBar(title: getTranslated('lines', context), isBackButtonExist: false),
      body:

         const Column(


             children: [
           Expanded(child: LinesWidget(site:'Bekoko')),
            //SizedBox(height: 100.0,),

          // Expanded(child: LinesWidget1(site:'Muyuka'))
])


    );




  }
}




