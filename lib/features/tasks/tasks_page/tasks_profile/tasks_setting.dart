import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';
import 'package:get/get.dart';
import '../../tasks_theme/tasks_themecontroller.dart';


class TasksSetting extends StatefulWidget {
  const TasksSetting({Key? key}) : super(key: key);

  @override
  State<TasksSetting> createState() => _TasksSettingState();
}

class _TasksSettingState extends State<TasksSetting> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int isselected = 0;
  final themedata = Get.put(TasksThemecontroler());
  bool isdark = true;
  bool isdark1 = true;
  bool isdark2 = true;
  List type = ["English","Chinese","Japanese","Korean","Russian"];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            splashColor: TasksColor.transparent,
            highlightColor: TasksColor.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: height/20,
              width: height/20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: TasksColor.white,
                  boxShadow: const [
                    BoxShadow(color: TasksColor.textgray,blurRadius: 5)
                  ]
              ),
              child: Padding(
                padding: EdgeInsets.only(left: width/56),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: TasksColor.black,
                ),
              ),
            ),
          ),
        ),
        title: Text("Setting".tr,style: hsSemiBold.copyWith(fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("General".tr,style: hsSemiBold.copyWith(fontSize: 16),),
              SizedBox(height: height/36,),
              Row(
                children: [
                  InkWell(
                      splashColor: TasksColor.transparent,
                      highlightColor: TasksColor.transparent,
                      onTap: () {
                        language();
                      },
                      child: Text("Language".tr,style: hsRegular.copyWith(fontSize: 16),)),
                  const Spacer(),
                  Text("English".tr,style: hsRegular.copyWith(fontSize: 16),),
                  SizedBox(width: width/36,),
                  Icon(Icons.arrow_forward_ios,size: 22,color:themedata.isdark?TasksColor.white:TasksColor.black,)
                ],
              ),
              SizedBox(height: height/46,),
              InkWell(
                splashColor: TasksColor.transparent,
                highlightColor: TasksColor.transparent,
                onTap: () {
                  deleteaccount();
                },
                  child: Text("Delete_Account".tr,style: hsRegular.copyWith(fontSize: 16),)),
              SizedBox(height: height/150,),
              Row(
                children: [
                  Text("Dark_mode".tr,style: hsRegular.copyWith(fontSize: 16),),
                  const Spacer(),
                  Switch(
                    activeColor: TasksColor.appcolor,
                    inactiveTrackColor: TasksColor.textgray,
                    onChanged: (state) {
                      themedata.changeThem(state);
                      setState(() {
                        isdark = state;
                      });
                      themedata.update();
                    },
                    value: themedata.isdark,
                  ),
                ],
              ),
              SizedBox(height: height/56,),
              Text("Notifications".tr,style: hsSemiBold.copyWith(fontSize: 16),),
              SizedBox(height: height/96,),
              Row(
                children: [
                  Text("Allow_Notification".tr,style: hsRegular.copyWith(fontSize: 16),),
                  const Spacer(),
                  Switch(
                    activeColor: TasksColor.appcolor,
                    inactiveTrackColor: TasksColor.textgray,
                    onChanged: (state) {
                      setState(() {
                        isdark1 = state;
                      });
                    },
                    value: isdark1,
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Allow_the_Notification_Rings".tr,style: hsRegular.copyWith(fontSize: 16),),
                  const Spacer(),
                  Switch(
                    activeColor: TasksColor.appcolor,
                    inactiveTrackColor: TasksColor.textgray,
                    onChanged: (state) {
                      setState(() {
                        isdark2 = state;
                      });
                    },
                    value: isdark2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> deleteaccount() async {
    return await showDialog(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/56,vertical: height/96),
              child: Column(
                children: [
                  Text("Delete_Account".tr,style: hsSemiBold.copyWith(fontSize: 22)),
                  SizedBox(height: height/56,),
                  Text("Are_you_sure_to_delete_this_account".tr,textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,style: hsRegular.copyWith(fontSize: 16)),
                  SizedBox(height: height/36,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: TasksColor.transparent,
                          highlightColor: TasksColor.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height/20,
                            width: width/4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: TasksColor.appcolor)
                            ),
                            child: Center(child: Text("Cancel".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.appcolor),)),
                          ),
                        ),
                        SizedBox(width: width/36,),
                        Container(
                          height: height/20,
                          width: width/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: TasksColor.appcolor
                          ),
                          child: Center(child: Text("Sure".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height/56,),
                ],
              ),
            )
          ],
        ),
        context: context);
  }

  Future<bool> language() async {
    return await showDialog(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/56,vertical: height/96),
              child: Column(
                children: [
                  Text("Language".tr,style: hsSemiBold.copyWith(fontSize: 22)),
                  SizedBox(height: height/36,),
                  ListView.builder(
                    itemCount: type.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: height/56),
                        child: InkWell(
                          splashColor: TasksColor.transparent,
                          highlightColor: TasksColor.transparent,
                          onTap: () {
                            setState(() {
                             // isselected = index;
                              isselected = type[index];
                            });
                          },
                          child: Row(
                            children: [
                              Text(type[index],style: hsRegular.copyWith(fontSize: 16,),),
                              const Spacer(),
                              Icon(isselected == index?Icons.check_box_sharp:Icons.check_box_outline_blank,size: 22,color: isselected == index?TasksColor.appcolor:TasksColor.transparent,),
                            ],
                          ),
                        ),
                      );
                    },),
                ],
              ),
            )
          ],
        ),
        context: context);
  }

}
