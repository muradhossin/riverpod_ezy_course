
import 'package:boilerplate/core/extensions/image_path.dart';
import 'package:boilerplate/shared/utils/dimensions.dart';
import 'package:boilerplate/shared/utils/styles.dart';
import 'package:boilerplate/shared/widgets/custom_button.dart';
import 'package:boilerplate/shared/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class PostInputFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function()? onPressed;

  const PostInputFieldWidget({required this.textEditingController, super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(Dimensions.paddingSizeDefault),
        padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 0.3,
          ),
        ),
        child: Row(
          children: [
            CustomImage(
              height: 60,
              width: 54,
              imagePath: Images.placeHolderMan,
            ),
            SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(
              child: TextField(
                enabled: false,
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Write something here...',
                  border: InputBorder.none,
                  hintStyle: fontRegular.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                ),
              ),
            ),
            CustomButtonWidget(
              buttonText: 'Post',
              onPressed: onPressed,
              width: 80,
              height: 45,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).cardColor,
            ),
          ],
        ),
      ),
    );
  }
}