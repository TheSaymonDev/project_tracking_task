import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tracking_project_app/core/app_data.dart';
import 'package:tracking_project_app/core/utils/http_client.dart';
import 'package:tracking_project_app/core/utils/validators.dart';
import 'package:tracking_project_app/views/screens/home_screen.dart';
import 'package:tracking_project_app/views/widgets/base_widgets/custom_elevated_button.dart';
import 'package:tracking_project_app/views/widgets/base_widgets/custom_text_form_field.dart';
import 'package:tracking_project_app/views/widgets/styles.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _projectNameController = TextEditingController();
  final _projectUpdateController = TextEditingController();
  final _assignedEngineerController = TextEditingController();
  final _assignedTechnicianController = TextEditingController();

  final Map<String, String> _formValues = {
    "start_date": "",
    "end_date": "",
    "project_name": "",
    "project_update": "",
    "assigned_engineer": "",
    "assigned_technician": ""
  };
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  void _formOnSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      _formValues["start_date"] = _startDateController.text.trim();
      _formValues["end_date"] = _endDateController.text.trim();
      _formValues["project_name"] = _projectNameController.text.trim();
      _formValues["project_update"] = _projectUpdateController.text.trim();
      _formValues["assigned_engineer"] =
          _assignedEngineerController.text.trim();
      _formValues["assigned_technician"] =
          _assignedTechnicianController.text.trim();
      bool addSuccess = await addElementRequest(_formValues);
      if (addSuccess == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: blackClr,
              size: 25.sp,
            )),
        title: Text(
          'Add An Element',
          style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.infinity.h,
        width: double.infinity.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(16.h),
                Text(
                  'Start Date',
                  style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.normal, clr: greyColor),
                ),
                Gap(8.h),
                CustomTextFormField(
                  hintText: 'Please enter start date',
                  controller: _startDateController,
                  validator: startDateValidator,
                  suffixIcon: IconButton(
                      onPressed: () async{
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          _startDateController.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                        }
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        size: 20.sp,
                        color: greyColor,
                      )),
                  readOnly: true,
                ),
                Gap(16.h),
                Text(
                  'End Date',
                  style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.normal, clr: greyColor),
                ),
                Gap(8.h),
                CustomTextFormField(
                  hintText: 'Please enter end date',
                  controller: _endDateController,
                  validator: endDateValidator,
                  suffixIcon: IconButton(
                      onPressed: () async{
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025, 12, 31),
                        );
                        if (selectedDate != null) {
                          _endDateController.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                        }
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        size: 20.sp,
                        color: greyColor,
                      )),
                  readOnly: true,
                ),
                Gap(16.h),
                Text(
                  'Project Name',
                  style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.normal, clr: greyColor),
                ),
                Gap(8.h),
                CustomTextFormField(
                  hintText: 'Please enter project name',
                  controller: _projectNameController,
                  validator: projectNameValidator,
                ),
                Gap(16.h),
                Text(
                  'Project Update',
                  style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.normal, clr: greyColor),
                ),
                Gap(8.h),
                CustomTextFormField(
                  hintText: 'Please enter project update',
                  controller: _projectUpdateController,
                  validator: projectUpdateValidator,
                ),
                Gap(16.h),
                Text(
                  'Assigned Engineer',
                  style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.normal, clr: greyColor),
                ),
                Gap(8.h),
                CustomTextFormField(
                  hintText: 'Please enter assigned engineer name',
                  controller: _assignedEngineerController,
                  validator: assignedEngineerValidator,
                ),
                Gap(16.h),
                Text(
                  'Assigned Technician',
                  style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.normal, clr: greyColor),
                ),
                Gap(8.h),
                CustomTextFormField(
                  hintText: 'Please enter assigned technician name',
                  controller: _assignedTechnicianController,
                  validator: assignedTechnicianValidator,
                ),
                Gap(32.h),
                _isLoading == true
                    ? Center(
                        child: customCircularProgressIndicator,
                      )
                    : CustomElevatedButton(
                        onPressed: () async{
                          var connectivityResult = await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.none) {
                            customToast(msg: 'Please check your internet connection', color: Colors.red);
                          }else{
                            _formOnSubmit();
                          }
                        },
                        buttonName: 'Save'),
                Gap(32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
