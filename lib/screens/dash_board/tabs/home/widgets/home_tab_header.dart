import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: AppSizes.pagePadding, bottom: 30),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/icons/logo.svg',
                  color: Theme.of(context).primaryColor),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LettutorRoutes.history);
                },
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Icon(
                    Icons.history,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    AppLocalizations.of(context).history,
                    style: TextStyle(
                      fontSize: AppSizes.normalTextSize,
                    ),
                  )
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Row(children: [
                Icon(
                  Icons.timer,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${AppLocalizations.of(context).totalLearnedTime}: 36 ${AppLocalizations.of(context).hours} 12 ${AppLocalizations.of(context).minutes}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.normalTextSize,
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
