import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final String _facebookIconPath = 'assets/images/facebook_icon.svg';
final String _googleIconPath = 'assets/images/google_icon.svg';

class AppIcons {
  static final Widget facebookIcon = SvgPicture.asset(_facebookIconPath);
  static final Widget googleIcon = SvgPicture.asset(_googleIconPath);
}
