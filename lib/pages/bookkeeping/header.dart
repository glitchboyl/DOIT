import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bookkeeping_statistics.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class BookkeepingHeader extends StatelessWidget {
  const BookkeepingHeader({super.key});

  @override
  Widget build(BuildContext context) => Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 182,
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/images/bookkeeping_bg.svg',
                fit: BoxFit.scaleDown,
              ),
              BookkeepingStatistics(incomes: 2000.8, expenses: 123.32),
            ],
          ),
        ),
      );
}
