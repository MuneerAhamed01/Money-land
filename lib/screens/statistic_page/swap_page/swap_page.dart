import 'package:flutter/material.dart';
import 'package:money_land/screens/statistic_page/statistic.dart';
import 'package:money_land/screens/statistic_page/statistics_income.dart';
import 'package:money_land/themes/colors/colors.dart';

class SwapInStatics extends StatefulWidget {
  const SwapInStatics({Key? key}) : super(key: key);

  @override
  State<SwapInStatics> createState() => _SwapInStaticsState();
}

class _SwapInStaticsState extends State<SwapInStatics> {
  bool swaped = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: realWhite,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: realWhite,
                shadowColor: transparent,
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          swaped = !swaped;
                        });
                      },
                      icon: Icon(
                        Icons.swap_horiz,
                        color: realBlack,
                      )),
                ],
              )
            ];
          },
          body: swaped == true ? const Statistic() : const StatisticIncome(),
        ));
  }
}
