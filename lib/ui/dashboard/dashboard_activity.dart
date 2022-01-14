import 'package:basic_flutter_app/data/models/m_category.dart';
import 'package:basic_flutter_app/data/models/m_group.dart';
import 'package:basic_flutter_app/data/models/m_item.dart';
import 'package:basic_flutter_app/res/color.dart';
import 'package:basic_flutter_app/utils/custom_widgets/customButton.dart';
import 'package:basic_flutter_app/utils/custom_widgets/customText.dart';
import 'package:basic_flutter_app/utils/custom_widgets/editText.dart';
import 'package:basic_flutter_app/utils/logo.dart';
import 'package:basic_flutter_app/utils/video_thumbnail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../multiLanguage/lanuages/language.dart';
import '../../ui/base/BaseActivity.dart';
import '../../ui/login/vmLogin.dart';

import 'i_dashboard.dart';
import 'vm_dashboard.dart';

class DashboardActivity extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends BaseActivity<DashboardActivity, DashboardVM>
    implements IDashboard {
  DashboardVM? viewModel;
  var progress;

  @override
  void onCreate() async {
    super.onCreate();
    var viewModel = getViewModel();
    if (viewModel != null) {
      viewModel.navigator = this;
      Future.delayed(Duration(milliseconds: 100), () {
        viewModel.getCategories(context);
      });
    }
  }

  @override
  void logoutSession() {
    viewModel?.dataManager
        .setRememberCredentials(false)
        .then((value) => clearAllActivities());
  }

  @override
  Widget getWidget(BuildContext buildContext, DashboardVM? vm) {
    this.viewModel = vm;

    // List<Widget> buildList = [];
    // if (viewModel!.mIsLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    // viewModel?.categoryResponse?.categories?.forEach((category) {
    //   buildList.add(_getTileView(context, category));
    // });
    //vm.checkIfAlreadyLoggedIn();
    return Scaffold(
        // backgroundColor: Colors.blue.shade50,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 1,
          title: Logo(
            color: Colors.grey.shade700,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.zero,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  logoutSession();
                },
                child: Text(
                  Language.of(context).logOut,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
          // Container(
          //   padding: EdgeInsets.only(top: 2, bottom: 2),
          //   child: SimpleEditText(
          //     hintText: "Search",
          //     // fillColor: Colors.grey,
          //     suffixIcon: Icon(Icons.search_rounded),
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide.none,
          //       borderRadius: const BorderRadius.all(Radius.circular(20)),
          //     ),
          //   ),
          // ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 6),
            children: [
              // Container(
              //     padding: EdgeInsets.all(5),
              //     child: Column(
              //       children: [
              //         Row(
              //           mainAxisSize: MainAxisSize.max,
              //           children: [
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 Text.rich(TextSpan(text: 'Hi, ',
              //                     // style: TextStyle(
              //                     //   color: Colors.red.shade500,
              //                     // ),
              //                     children: <InlineSpan>[
              //                       TextSpan(
              //                         text: viewModel?.userName,
              //                         style: TextStyle(
              //                             color: Colors.black,
              //                             fontSize: 18,
              //                             fontWeight: FontWeight.bold,
              //                             decoration: TextDecoration.underline),
              //                       )
              //                     ])),
              //                 SizedBox(
              //                   width: 3,
              //                 ),
              //                 Text(
              //                   viewModel!.userEmail,
              //                   style: TextStyle(fontStyle: FontStyle.italic),
              //                 ),
              //               ],
              //             ),
              //             Spacer(),
              //             MaterialButton(
              //               onPressed: () {},
              //               color: Colors.blue,
              //               textColor: Colors.white,
              //               child: Text("D"),
              //               padding: EdgeInsets.all(5),
              //               shape: CircleBorder(),
              //             )
              //           ],
              //         ),
              //         SizedBox(
              //           width: 3,
              //         ),
              //         Container(
              //           color: Colors.grey,
              //           height: 1,
              //         )
              //       ],
              //     )),

              SizedBox(
                height: 10.h,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 120.h,
                  imageUrl:
                      "https://cdn.dribbble.com/users/1464381/screenshots/13500972/media/d3c224181cb1dde072d7e7c1e3e1d1ad.jpg?compress=1&resize=1600x1200&vertical=top",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                viewModel!.userEmail,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Colors.grey.shade800,
                  height: 0.9,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                viewModel!.userPhone,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: Colors.grey.shade800,
                  height: 0.9,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                height: 35.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    color: Colors.blue.shade50),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Select Classes",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Colors.blue,
                        height: 0.9,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 10.sp,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              viewModel?.categoryResponse != null &&
                      viewModel?.categoryResponse?.groups != null
                  ? GridView.builder(
                      itemCount:
                          viewModel!.categoryResponse!.groups!.length - 1,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (cxt, i) {
                        GroupM group = viewModel!.categoryResponse!.groups![i];
                        return GestureDetector(
                          onTap: () {
                            viewModel?.setGroup(context, group);
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 5.w),
                            child: Text(
                              group.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                color: group.id == viewModel!.selectedGroup!.id
                                    ? Colors.blue
                                    : Colors.black,
                                height: 0.9,
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.r)),
                                color: Colors.grey.shade200),
                          ),
                        );
                      })
                  : Container(),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            // padding: EdgeInsets.only(left: 8.w, right: 8.w),
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      viewModel!.selectedGroup != null
                          ? viewModel!.selectedGroup!.name
                          : Language.of(context).categories,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                        color: Colors.grey.shade700,
                        height: 0.9,
                      ),
                    ),
                    if (viewModel?.categoryResponse != null &&
                        viewModel?.categoryResponse!.groups != null)
                      GestureDetector(
                        onTap: () {
                          viewModel?.setGroup(context,
                              viewModel!.categoryResponse!.groups!.last);
                        },
                        child: Text(
                          Language.of(context).viewAll,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color:
                                viewModel!.categoryResponse!.groups!.last.id ==
                                        viewModel!.selectedGroup!.id
                                    ? Colors.grey
                                    : Colors.blue,
                            height: 0.9,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              viewModel!.mIsLoading
                  ? Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Language.of(context).loadingCategory,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                                color: Colors.grey.shade700,
                                height: 0.9,
                              ),
                            ),
                            Center(
                                child: CircularProgressIndicator(
                              color: Colors.amberAccent,
                            ))
                          ],
                        ),
                      ),
                    )
                  : viewModel?.categoryResponse?.categories == null
                      ? Expanded(
                          child: Container(
                            child: Center(
                              child: Text(
                                Language.of(context).noCategoryFound,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  height: 0.9,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: GridView.builder(
                              // physics: NeverScrollableScrollPhysics(),
                              // shrinkWrap: true,
                              // padding: EdgeInsets.symmetric(horizontal: 7),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.2,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 4),
                              itemCount:
                                  vm?.categoryResponse?.categories?.length,
                              itemBuilder: (BuildContext context, int index) {
                                var category =
                                    vm?.categoryResponse?.categories![index];
                                return Card(
                                  elevation: 4,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: GestureDetector(
                                    //padding: EdgeInsets.all(1),
                                    child: Stack(
                                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                            child: new OverflowBox(
                                          minWidth: 0.0,
                                          minHeight: 0.0,
                                          maxWidth: double.infinity,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: category!.imageUrl,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        )),
                                        Positioned(
                                            bottom: 2,
                                            right: 0,
                                            left: 0,
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4.w,
                                                  horizontal: 1.w),
                                              child: Center(
                                                child: Text(
                                                  category.name,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13.sp,
                                                    color: Colors.white,
                                                    height: 0.9,
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                    onTap: () async {
                                      startNamedActivity("/details",
                                          args: category);
                                    },
                                  ),
                                );
                              }),
                        ),
              // Wrap(
              //   children: buildList,
              // ),
            ],
          ),
        ));
  }

  String? checkEmptyValidation(value) {
    if (value.isEmpty) {
      return Language.of(context).requiredWarningText;
    }
    return null;
  }

  @override
  void openLoginActivity() {
    replaceNamedActivity("/");
  }
}
