// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:math';

import 'package:addistutor_student/Wallet/topuppage.dart';
import 'package:addistutor_student/controller/walletcontroller.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

final WalletContoller walletContoller = Get.put(WalletContoller());

class _EditProfilePageState extends State<WalletPage> {
  late Balance? balance;
  var ids;
  @override
  void initState() {
    _fetchUser();

    super.initState();
  }

  late int ran;
  void _fetchUser() async {
    ran = Random().nextInt(100);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["student_id"] != null) {
        setState(() {
          ids = body["student_id"];
          walletContoller.getbalance(ids);
          walletContoller.gettransaction(ids);
        });
      } else {
        var noid = "noid";
      }
    } else {}
  }

  var balancewallet = 10;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      // _getlocation();
      _fetchUser();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => walletContoller.isfetchedtransaction.value
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,

            //cheak pull_to_refresh
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                color: kPrimaryColor,
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              walletContoller.wallet == "null"
                                  ? Text(
                                      "ETB - " +
                                          walletContoller.wallet.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 29,
                                          fontWeight: FontWeight.w700),
                                    )
                                  : Text(
                                      "ETB - " + "0",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 29,
                                          fontWeight: FontWeight.w700),
                                    ),
                              Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: Image.network(
                                        'https://nextgeneducation.et/api/student-profile-picture/${ids}?$ran',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            "Your Current Balance",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.blue[100]),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          const TopUpPage(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(243, 245, 248, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      child: Icon(
                                        Icons.trending_up,
                                        color: Colors.blue[900],
                                        size: 30,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Attach deposit slip",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.blue[100]),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(243, 245, 248, 1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      const Text(
                                        "Recent  Transactions",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Transaction transaction =
                                        walletContoller.listtransaction[index];
                                    return transaction.status == "1"
                                        ? Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 32),
                                            padding: const EdgeInsets.all(16),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              children: <Widget>[
                                                Stack(children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 4,
                                                            color: Theme.of(
                                                                    context)
                                                                .scaffoldBackgroundColor),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              spreadRadius: 2,
                                                              blurRadius: 10,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.1),
                                                              offset:
                                                                  const Offset(
                                                                      0, 10))
                                                        ],
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    18))),
                                                    child: const Icon(
                                                      Icons
                                                          .account_balance_wallet,
                                                      color: kPrimaryLightColor,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                  ),
                                                ]),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        "Payment submitted",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors
                                                                .grey[900]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      transaction.amount
                                                              .toString() +
                                                          " Birr",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors
                                                              .lightGreen),
                                                    ),
                                                    Text(
                                                      transaction.date,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Colors.grey[500]),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : transaction.status == "0"
                                            ? Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 32),
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Row(
                                                  children: <Widget>[
                                                    Stack(children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                border: Border.all(
                                                                    width: 4,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .scaffoldBackgroundColor),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      spreadRadius:
                                                                          2,
                                                                      blurRadius:
                                                                          10,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.1),
                                                                      offset:
                                                                          const Offset(
                                                                              0,
                                                                              10))
                                                                ],
                                                                color: Colors
                                                                    .grey[100],
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            18))),
                                                        child: Icon(
                                                          Icons
                                                              .account_balance_wallet,
                                                          color: Colors
                                                              .lightBlue[900],
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                      ),
                                                    ]),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            "payment declined",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey[900]),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          transaction.amount
                                                                  .toString() +
                                                              " Birr",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                        Text(
                                                          transaction.date,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 32),
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Row(
                                                  children: <Widget>[
                                                    Stack(children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                border: Border.all(
                                                                    width: 4,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .scaffoldBackgroundColor),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      spreadRadius:
                                                                          2,
                                                                      blurRadius:
                                                                          10,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.1),
                                                                      offset:
                                                                          const Offset(
                                                                              0,
                                                                              10))
                                                                ],
                                                                color: Colors
                                                                    .grey[100],
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            18))),
                                                        child: Icon(
                                                          Icons
                                                              .account_balance_wallet,
                                                          color: Colors
                                                              .lightBlue[900],
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                      ),
                                                    ]),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            "Deposit approval \n pending",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey[900]),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          transaction.amount
                                                                  .toString() +
                                                              " Birr",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .yellow),
                                                        ),
                                                        Text(
                                                          transaction.date,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: 16,
                                  ),
                                  itemCount:
                                      walletContoller.listtransaction.length,
                                  padding: const EdgeInsets.all(8),
                                ),
                              ],
                            ),
                            controller: scrollController,
                          ),
                        );
                      },
                      initialChildSize: 0.65,
                      minChildSize: 0.65,
                      maxChildSize: 1,
                    )
                  ],
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
  }
}
