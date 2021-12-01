import 'package:basic_flutter_app/res/color.dart';
import 'package:basic_flutter_app/utils/custom_widgets/customButton.dart';
import 'package:basic_flutter_app/utils/custom_widgets/customText.dart';
import 'package:basic_flutter_app/utils/custom_widgets/editText.dart';
import 'package:basic_flutter_app/utils/logo.dart';
import 'package:basic_flutter_app/utils/video_thumbnail.dart';
import 'package:flutter/material.dart';
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
  }

  @override
  Widget getWidget(BuildContext buildContext, DashboardVM? vm) {
    this.viewModel = vm;
    //vm.checkIfAlreadyLoggedIn();
    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(top: 2, bottom: 2),
            child: SimpleEditText(
              hintText: "Search",
              fillColor: Colors.white,
              suffixIcon: Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.blue.shade50,
          child: ListView(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(text: 'Hi, ',
                                  // style: TextStyle(
                                  //   color: Colors.red.shade500,
                                  // ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: 'Demo User',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    )
                                  ])),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                "Demo@email.com",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Spacer(),
                          MaterialButton(
                            onPressed: () {},
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text("D"),
                            padding: EdgeInsets.all(5),
                            shape: CircleBorder(),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 1,
                      )
                    ],
                  )),
              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      title: Text("Class ${index + 1}"),
                      // icon: menu.image,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  }),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, int index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      // Container(
                      //   color: Colors.grey,
                      //   height: 150,
                      // ),
                      Container(
                        height: 220,
                        child: VideoThumbnailImage(
                          path:
                              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border)),
                          ),
                          Expanded(
                            flex: 4,
                            child: MaterialButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.insert_comment_outlined),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    SimpleText("Comment"),
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.forward_outlined)),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
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
