import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tracking_project_app/core/app_data.dart';
import 'package:tracking_project_app/core/utils/http_client.dart';
import 'package:tracking_project_app/views/screens/add_screen.dart';
import 'package:tracking_project_app/views/screens/update_screen.dart';
import 'package:tracking_project_app/views/widgets/base_widgets/custom_floating_action_button.dart';
import 'package:tracking_project_app/views/widgets/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Color> colors = [
    Colors.red.shade50,
    Colors.green.shade50,
    Colors.blue.shade50,
    Colors.orange.shade50,
    Colors.purple.shade50,
    Colors.amber.shade50,
    Colors.teal.shade50,
    Colors.indigo.shade50,
    Colors.cyan.shade50,
    Colors.lime.shade50,
  ];

  bool _isLoading = true;
  List itemList = [];

  @override
  void initState() {
    _callData();
    super.initState();
  }

  _callData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      customToast(
          msg: 'Please check your internet connection', color: Colors.red);
      setState(() {
        _isLoading = false;
      });
    } else {
      itemList = await projectTrackingListRequest();
      if (mounted) {
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
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Tracking Project',
          style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu_rounded,
                size: 25.sp,
                color: blackClr,
              )),
          Gap(8.w),
        ],
      ),
      body: Container(
        height: double.infinity.h,
        width: double.infinity.w,
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
        child: _isLoading == true
            ? Center(child: customCircularProgressIndicator)
            : RefreshIndicator(
                color: greenClr,
                onRefresh: () async {
                  _callData();
                },
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final item = itemList[index];
                      final groupColorIndex = index % colors.length;
                      return Card(
                        elevation: 3,
                        color: colors[groupColorIndex],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Container(
                          width: double.infinity.w,
                          padding: EdgeInsets.only(
                              right: 8.w, left: 8.w, bottom: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: colors[groupColorIndex],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Project Name: ',
                                        style: myTextStyle(
                                            fSize: 20.sp,
                                            fWeight: FontWeight.bold,
                                            clr: greyColor),
                                        children: [
                                          TextSpan(
                                            text: '${item["project_name"]}',
                                            style: myTextStyle(
                                                fSize: 20.sp,
                                                fWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateScreen(
                                                id: item["id"],
                                                startDate: item["start_date"],
                                                endDate: item["end_date"],
                                                projectName:
                                                    item["project_name"],
                                                projectUpdate:
                                                    item["project_update"],
                                                assignedEngineer:
                                                    item["assigned_engineer"],
                                                assignedTechnician: item[
                                                    "assigned_technician"]),
                                          ));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      size: 25.sp,
                                      color: blackClr,
                                    ),
                                    padding: EdgeInsets.zero,
                                  )
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Assigned Engineer: ',
                                  style: myTextStyle(
                                      fSize: 16.sp,
                                      fWeight: FontWeight.bold,
                                      clr: greyColor),
                                  children: [
                                    TextSpan(
                                        text: '${item["assigned_engineer"]}',
                                        style: myTextStyle(
                                            fSize: 16.sp,
                                            fWeight: FontWeight.normal)),
                                  ],
                                ),
                              ),
                              Gap(8.h),
                              RichText(
                                text: TextSpan(
                                  text: 'Assigned Technician: ',
                                  style: myTextStyle(
                                      fSize: 16.sp,
                                      fWeight: FontWeight.bold,
                                      clr: greyColor),
                                  children: [
                                    TextSpan(
                                        text: '${item["assigned_technician"]}',
                                        style: myTextStyle(
                                            fSize: 16.sp,
                                            fWeight: FontWeight.normal)),
                                  ],
                                ),
                              ),
                              Gap(16.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: whiteClr),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: blackClr,
                                            size: 20.sp,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Start Date",
                                                style: myTextStyle(
                                                    fSize: 12.sp,
                                                    fWeight: FontWeight.bold,
                                                    clr: greyColor),
                                              ),
                                              Gap(8.h),
                                              Text(
                                                "${item['start_date']}",
                                                style: myTextStyle(
                                                    fSize: 12.sp,
                                                    fWeight: FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Gap(32.w),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: whiteClr),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: blackClr,
                                            size: 20.sp,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "End Date",
                                                style: myTextStyle(
                                                    fSize: 12.sp,
                                                    fWeight: FontWeight.bold,
                                                    clr: greyColor),
                                              ),
                                              Gap(8.h),
                                              Text(
                                                "${item['end_date']}",
                                                style: myTextStyle(
                                                    fSize: 12.sp,
                                                    fWeight: FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(16.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Duration',
                                    style: myTextStyle(
                                        fSize: 12.sp,
                                        fWeight: FontWeight.normal,
                                        clr: greyColor),
                                  ),
                                  Gap(8.w),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Transform.rotate(
                                        angle: pi / 4,
                                        child: Container(
                                          height: 25.h,
                                          width: 25.w,
                                          decoration: const BoxDecoration(
                                            color: greenClr,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${item["duration"]}",
                                        style: myTextStyle(
                                            fSize: 10.sp,
                                            fWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Gap(8.h),
                    itemCount: itemList.length),
              ),
      ),
      floatingActionButton: CustomFloatingActionButton(onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ));
      }),
    );
  }
}
