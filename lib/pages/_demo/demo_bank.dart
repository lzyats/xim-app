import 'package:flutter/material.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/widgets/widget_common.dart';

class DemoBank extends StatefulWidget {
  // 路由地址
  static const String routeName = '/demo_bank';
  const DemoBank({super.key});

  @override
  createState() => _DemoBankCardState();
}

class _DemoBankCardState extends State<DemoBank> {
  List<CreditCardViewModel> creditCardDatas = [
    CreditCardViewModel(
      '建设银行',
      AppImage.bank,
      '储蓄卡',
      '6210  ****  ****  1426',
      [const Color(0xFFF17B68), const Color(0xFFE95F66)],
      '10/27',
    ),
    CreditCardViewModel(
      '招商银行',
      AppImage.bank,
      '储蓄卡',
      '6210  ****  ****  1426',
      [const Color(0xFFF17B68), const Color(0xFFE95F66)],
      '10/27',
    ),
    CreditCardViewModel(
      '招商银行',
      AppImage.bank,
      '信用卡',
      '6210  ****  ****  1426',
      [const Color(0xFFF17B68), const Color(0xFFE95F66)],
      '10/27',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('银行卡'),
      ),
      body: ListView.separated(
        itemCount: creditCardDatas.length,
        separatorBuilder: (BuildContext context, int index) {
          // 构建分割线
          return WidgetCommon.divider();
        },
        itemBuilder: (context, index) {
          return _yinhangka(creditCardDatas[index]);
        },
      ),
    );
  }

  _yinhangka(CreditCardViewModel creditCardData) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 170,
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.only(left: 20, top: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: creditCardData.cardColors,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: 4,
              color: Color.fromARGB(19, 231, 9, 9),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -100,
              bottom: -100,
              child: Image.asset(
                creditCardData.bankLogoUrl,
                width: 250,
                height: 250,
                color: Colors.white10,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          creditCardData.bankLogoUrl,
                          width: 36,
                          height: 36,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            creditCardData.bankName,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            creditCardData.cardType,
                            style: const TextStyle(
                              fontSize: 14,
                              // color: Color.fromARGB(200, 255, 255, 255),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 65, top: 20),
                    child: Text(
                      creditCardData.cardNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Farrington',
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 65, top: 15),
                    child: Text(
                      creditCardData.validDate,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardViewModel {
  /// 银行
  final String bankName;

  /// 银行Logo
  final String bankLogoUrl;

  /// 卡类型
  final String cardType;

  /// 卡号
  final String cardNumber;

  /// 卡片颜色
  final List<Color> cardColors;

  /// 有效期
  final String validDate;

  const CreditCardViewModel(
    this.bankName,
    this.bankLogoUrl,
    this.cardType,
    this.cardNumber,
    this.cardColors,
    this.validDate,
  );
}
