import 'package:flutter/material.dart';
import 'package:money_land/screens/statistic_page/statistic.dart';
import 'package:money_land/screens/statistic_page/statistics_income.dart';

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
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          swaped = !swaped;
                        });
                      },
                      icon: const Icon(
                        Icons.swap_horiz,
                        color: Colors.black,
                      )),
                ],
              )
            ];
          },
          body: swaped == true ? Statistic() : StatisticIncome(),
        ));
  }
}
