import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:islamic_quizs_game/consts/views/assets.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PrivacyPolicy extends StatefulWidget {
  static String  path = '/privacy' ;

  PrivacyPolicy({Key? key }) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PrivacyPolicy> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
   var  controller = WebViewController()
 
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
  NavigationDelegate(
  onProgress: (int progress) {
  // Update loading bar.
  },
  onPageStarted: (String url) {},
  onPageFinished: (String url) {},
  onWebResourceError: (WebResourceError error) {},
  onNavigationRequest: (NavigationRequest request) {

  return NavigationDecision.navigate;
  },
  ),
  )
  ..loadRequest(Uri.parse('https://zeftawyapps.blogspot.com/2023/12/blog-post.html'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}