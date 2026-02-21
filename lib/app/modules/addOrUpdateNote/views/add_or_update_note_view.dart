import 'package:advdiary/app/modules/app_bar/custom_app_bar.dart';
import 'package:advdiary/common_widgets/app_button.dart';
import 'package:advdiary/common_widgets/custom_body.dart';
import 'package:advdiary/common_widgets/custom_loading_screen.dart';
import 'package:advdiary/common_widgets/custom_text_field.dart';
import 'package:advdiary/common_widgets/my_drawer.dart';
import 'package:advdiary/constraints/dimensions.dart';
import 'package:advdiary/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/add_or_update_note_controller.dart';

class AddOrUpdateNoteView extends GetView<AddOrUpdateNoteController> {
  AddOrUpdateNoteView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(()=>Stack(
        children: [
          Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar(
              title: controller.title.value,
              scaffoldKey: _scaffoldKey,
            ),
            drawer: MyDrawer(),
            body: CustomBody(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: controller.noteTitleController,
                        title: "Title",
                        hintText: "Enter Title",
                        isRequired: true,
                        validatorText: "Required",
                      ),
                       SizedBox(height: AppDimensions.widgetPadding.h),
                      CustomTextField(
                        title: "Note",
                        hintText: "Write your note here",
                        controller: controller.noteContentController,
                        maxLine: 1000,
                        minLine: 20,
                        isRequired: true,
                        validatorText: "Required",
                      ),
                      SizedBox(height: AppDimensions.sectionPadding.h,),
                      AppButton(text: "Save", onTap: (){
                        if(_formKey.currentState?.validate()??false){
                          controller.saveNote();
                        }
                      },bgColor: AppColors.primaryColor,showBorder: false,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          if(controller.isLoading.value)LoadingScreen()
        ],
      )),
    );
  }
}
