import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/config/assets.dart';

class NetworkCircleAvatar extends StatelessWidget {
  final String url;
  final double radius;
  NetworkCircleAvatar({this.url, this.radius});

  @override
  Widget build(BuildContext context) {
    return url == null
        ? Icon(
            Icons.account_circle_outlined,
            size: radius * 2,
          )
        : CachedNetworkImage(
            placeholder: (context, url) => CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: Image.asset(Assets.loadingImage).image,
                  radius: radius,
                ),
            imageUrl: url,
            imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: radius,
                ));
  }
}
