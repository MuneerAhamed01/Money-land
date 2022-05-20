import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_land/logic/statistic_change/statistic_change_cubit.dart';
import 'package:money_land/screens/statistic_page/statistic.dart';
import 'package:money_land/screens/statistic_page/statistics_income.dart';
import 'package:money_land/themes/colors/colors.dart';

class SwapInStatics extends StatelessWidget {
  const SwapInStatics({Key? key}) : super(key: key);

 

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
                      context.read<StatisticChangeCubit>().onValueChange();
                    },
                    icon: Icon(
                      Icons.swap_horiz,
                      color: realBlack,
                    )),
              ],
            )
          ];
        }, body: BlocBuilder<StatisticChangeCubit, StatisticChangeState>(
          builder: (context, state) {
            return state.value == true
                ? const Statistic()
                : const StatisticIncome();
          },
        )));
  }
}
