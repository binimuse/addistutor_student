import 'dart:async';
import 'dart:io';

import 'package:addistutor_student/constants.dart';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivecypolicyPage extends StatefulWidget {
  const PrivecypolicyPage({Key? key}) : super(key: key);

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<PrivecypolicyPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final GlobalKey _globalKey = GlobalKey();
  late WebViewController goback;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBack2,
        child: Scaffold(
          key: _globalKey,
          backgroundColor: Colors.white,

          appBar: AppBar(
            toolbarHeight: 30,
            backgroundColor: const Color(0xFF074760),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(),
              ),
            ),
          ),
          // We're using a Builder here so we have a context that is below the Scaffold
          // to allow calling Scaffold.of(context) so we can show a snackbar.
          body: Builder(builder: (BuildContext context) {
            return Stack(children: <Widget>[
              Expanded(
                child: WebView(
                  initialUrl: 'https://nextgeneducation.et/policy',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                    goback = webViewController;
                  },
                  onWebResourceError: (WebResourceError webviewerrr) {},
                  onProgress: (int progress) {
                    const CircularProgressIndicator(
                      color: kPrimaryColor,
                      strokeWidth: 8,
                    );
                  },
                  javascriptChannels: <JavascriptChannel>{
                    _toasterJavascriptChannel(context),
                  },
                  navigationDelegate: (NavigationRequest request) {
                    const CircularProgressIndicator(
                      color: kPrimaryColor,
                      strokeWidth: 8,
                    );

                    setState(() {
                      isLoading = true;
                    });
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  gestureNavigationEnabled: true,
                  backgroundColor: const Color(0x00000000),
                ),
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(),
            ]);
          }),
        ));
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          // Scaffold.of(context).showSnackBar(
          //   SnackBar(content: Text(message.message)),
          // );
        });
  }

  Future<bool> _onBack2() async {
    DateTime now = DateTime.now();
    var value = await goback.canGoBack(); // check webview can go back
    print(value);
    if (value) {
      goback.goBack(); // perform webview back operation

      isLoading = true;

      await Future.delayed(const Duration(milliseconds: 1000));
      isLoading = true;
      return false;
    } else {
      // late BackEventNotifier _notifier;
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              ElevatedButton(
                child: const Text('Yes'),
                onPressed: () {
                  exit(0);
                },
              )
            ],
          );
        },
      );
      //Navigator.pop(_globalKey.currentState!.context);

      return false;
    }
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture, {Key? key})
      : super(key: key);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.replay,
                color: kPrimaryColor,
              ),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller!.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}

enum MenuOptions {
  clearCookies,
  blindMood,

  clearCache,
}

class SampleMenu extends StatelessWidget {
  SampleMenu(this.controller, {Key? key}) : super(key: key);

  final Future<WebViewController> controller;
  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          key: const ValueKey<String>('ShowPopupMenu'),
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.clearCookies:
                _onClearCookies(context);
                break;
              case MenuOptions.blindMood:
                _onBlindMood(context);
                break;
              case MenuOptions.clearCache:
                _onClearCache(controller.data!, context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.blindMood,
              child: Text('Blind Mood'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCookies,
              child: Text('Clear cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCache,
              child: Text('Clear cache'),
            ),
          ],
          icon: const Icon(
            Icons.more_vert,
            color: kPrimaryColor,
          ),
        );
      },
    );
  }

  Future<void> _onClearCache(
      WebViewController controller, BuildContext context) async {
    await controller.clearCache();
    // ignore: deprecated_member_use
    // Scaffold.of(context).showSnackBar(const SnackBar(
    //   content: Text('Cache cleared.'),
    // ));
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    if (!hadCookies) {}
    // ignore: deprecated_member_use
    // Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text(message),
    // ));
  }

  Future<void> _onBlindMood(BuildContext context) async {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => BlindMood()));
  }
}
