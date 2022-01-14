import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum TransactionStatus { success, failed, processing, none }

class GatewayWebView extends StatefulWidget {
  const GatewayWebView({Key? key}) : super(key: key);

  @override
  _GatewayWebViewState createState() => _GatewayWebViewState();
}

class _GatewayWebViewState extends State<GatewayWebView> {
  TransactionStatus _transactionStatus = TransactionStatus.none;
  var surl = "https://staging.praman.ai/payment/fc_success";
  var furl = "https://staging.praman.ai/payment/fc_failure";
  var amt = "200.65";
  var merchantId = "jfBIfpGoKfWdXD";
  var merchantTxnId = "praman123_04";
  var merchantKey = "b6d214b1-1da9-4a6e-94a4-141a446eed97";
  var checksum = "";
  var response = "";

  late TextEditingController _controllerTxnId, _controllerAmt;

  @override
  void initState() {
    _controllerTxnId = TextEditingController(text: merchantTxnId);
    _controllerAmt = TextEditingController(text: amt);
    super.initState();
  }

  Future<bool> onBackPress() async {
    if (_transactionStatus != TransactionStatus.none) {
      if (_transactionStatus == TransactionStatus.processing) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Transaction cancelled by user...."),
          duration: Duration(seconds: 3),
        ));
      }
      setState(() {
        _transactionStatus = TransactionStatus.none;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _transactionStatus == TransactionStatus.none
              ? Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Freecharge Integration",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                              color: Colors.orange),
                        ),
                        SizedBox(height: 25),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Amount',
                            hintText: 'Enter Amount',
                          ),
                          keyboardType: TextInputType.number,
                          controller: _controllerAmt,
                        ),
                        SizedBox(height: 15),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'MerchantTxnId',
                            hintText: 'Enter MerchantTxnId',
                          ),
                          controller: _controllerTxnId,
                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                            minWidth: double.infinity,
                            color: Colors.orange,
                            child: Text(
                              "Pay Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (_controllerAmt.text.isEmpty ||
                                  double.parse(_controllerAmt.text.trim()) <=
                                      0.0) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Please enter amount greater than zero to proceed..."),
                                  duration: Duration(seconds: 3),
                                ));
                              } else if (_controllerTxnId.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Please enter valid MerchantTxnId to proceed..."),
                                  duration: Duration(seconds: 3),
                                ));
                              } else {
                                makePayment(_controllerAmt.text.trim(),
                                    _controllerTxnId.text.trim());
                              }
                            })
                      ],
                    ),
                  ),
                )
              // _transactionStatus != TransactionStatus.failed &&
              //         _transactionStatus != TransactionStatus.success
              : _transactionStatus == TransactionStatus.processing
                  ? InAppWebView(
                      initialUrlRequest: URLRequest(
                          url: Uri.parse(
                              "https://checkout-sandbox.freecharge.in/api/v1/co/pay/init"),
                          method: 'POST',
                          body: Uint8List.fromList(utf8.encode("amount=$amt&channel=WEB&checksum=$checksum&furl=$furl&merchantId=$merchantId&merchantTxnId=$merchantTxnId&surl=$surl")),
                          headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                          }),
                      onLoadStart: (controller, url) {
                        // _transactionStatus = TransactionStatus.processing;
                        // print("onLoadStart Url : $url");
                      },
                      onLoadStop: (controller, url) async {
                        print("onLoadStop Url : $url");
                        print(
                            "onLoadStop UrlQueryParameters : ${url?.queryParameters}");
                        if (url.toString() == surl || url.toString() == furl) {
                          // var value = await controller.getHtml();
                          var html = await controller.evaluateJavascript(
                              source:
                                  "window.document.getElementsByTagName('pre')[0].innerHTML;");
                          // if (html != null && html.isNotEmpty) return html;
                          print("value : $html");
                          onTransactionCompleted(url, html);
                        }
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        // print("consoleMessage : $consoleMessage");
                      },
                      onWebViewCreated: (controller) {},
                    )
                  : Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                                _transactionStatus == TransactionStatus.failed
                                    ? Icons.error_outline
                                    : Icons.download_done_outlined,
                                size: 50,
                                color: _transactionStatus ==
                                        TransactionStatus.failed
                                    ? Colors.red
                                    : Colors.green),
                            SizedBox(height: 20),
                            Text(
                              _transactionStatus == TransactionStatus.failed
                                  ? "Failed"
                                  : "Success",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22,
                                  color: _transactionStatus ==
                                          TransactionStatus.failed
                                      ? Colors.red
                                      : Colors.green),
                            ),
                            SizedBox(height: 20),
                            Text(
                              response,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: _transactionStatus ==
                                          TransactionStatus.failed
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  void makePayment(String amt1, String merchantTxnId1) {
    amt = amt1;
    merchantTxnId = merchantTxnId1;
    var str = {
      "amount": amt,
      "channel": "WEB",
      "furl": furl,
      "merchantId": merchantId,
      "merchantTxnId": merchantTxnId,
      "surl": surl
    };
    checksum = generateChecksum(json.encode(str), merchantKey);
    setState(() {
      _transactionStatus = TransactionStatus.processing;
    });
  }

  void onTransactionCompleted(Uri? url, String response1) {
    setState(() {
      _transactionStatus = url.toString() == surl
          ? TransactionStatus.success
          : TransactionStatus.failed;
      response = response1;
    });
  }

  String generateChecksum(String jsonString, String merchantKey) {
    var bytes1 = utf8.encode(jsonString + merchantKey); // data being hashed
    var checksum = sha256.convert(bytes1); // Hashing Process
    print("Checksum as bytes: ${checksum.bytes}"); // Print Bytes
    print("Checksum as hex string: $checksum");

    return checksum.toString();
  }
}
