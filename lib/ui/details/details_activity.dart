import 'package:basic_flutter_app/ui/details/video_player.dart';
import 'package:basic_flutter_app/utils/custom_widgets/editText.dart';
import 'package:basic_flutter_app/utils/logo.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../multiLanguage/lanuages/language.dart';
import '../../ui/base/BaseActivity.dart';

import 'i_details.dart';
import 'vm_details.dart';

class DetailsActivity extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends BaseActivity<DetailsActivity, DetailsVM>
    implements IDetails {
  DetailsVM? viewModel;
  var progress;

  @override
  void onCreate() async {
    super.onCreate();
    var viewModel = getViewModel();
    if (viewModel != null) {
      viewModel.navigator = this;
      Future.delayed(Duration(milliseconds: 100), () {
        viewModel.getCategoryDetails(context);
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
  Widget getWidget(BuildContext buildContext, DetailsVM? vm) {
    this.viewModel = vm;

    return Scaffold(
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
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(children: [
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                child: Text(
                  "${viewModel?.category.group.name} -> ${viewModel?.category.name}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Colors.grey.shade700,
                    height: 0.9,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              viewModel!.mIsLoading
                  ? Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Language.of(context).loadingItem,
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
                  : viewModel?.category.items == null
                      ? Expanded(
                          child: Container(
                            child: Center(
                              child: Text(
                                Language.of(context).noItemFound,
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
                          child: ListView.builder(
                            itemCount: viewModel?.category.items!.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = vm?.category.items![index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                child: Column(
                                  children: [
                                    Container(
                                        height: 200.h,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.r),
                                                topLeft: Radius.circular(10.r)),
                                            child: VideoPlayer(
                                                videoId: item!.videoUrl))),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      padding: EdgeInsets.all(2.w),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(10.r),
                                              bottomLeft:
                                                  Radius.circular(10.r))),
                                      child: ExpandablePanel(
                                        header: Text(
                                          item.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp,
                                              color: Colors.grey.shade600),
                                        ),
                                        collapsed: Text(
                                          item.sDesc,
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        expanded: Text(
                                          item.lDesc,
                                          softWrap: true,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
            ])));
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
