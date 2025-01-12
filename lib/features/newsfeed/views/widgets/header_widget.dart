import 'package:boilerplate/core/extensions/image_path.dart';
import 'package:boilerplate/shared/utils/dimensions.dart';
import 'package:boilerplate/shared/utils/styles.dart';
import 'package:boilerplate/shared/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).orientation == Orientation.portrait ? 156 : 100,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
        child: ListTile(
          leading: CustomImage(
            height: 32,
            width: 32,
            imagePath: Images.menuIcon,
          ),
          title: Text(
            'Python Developer Community',
            style: fontMedium.copyWith(color: Theme.of(context).cardColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '#General',
            style: fontRegular.copyWith(
              color: Theme.of(context).cardColor.withAlpha((0.7 * 255).toInt()),
              fontSize: Dimensions.fontSizeSmall,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
