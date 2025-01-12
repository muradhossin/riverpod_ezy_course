
import 'package:boilerplate/core/extensions/image_path.dart';
import 'package:boilerplate/shared/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

final List<Reaction<String>> reactions = [
  Reaction<String>(
    value: 'Like',
    icon: CustomImage(
      width: 20,
      height: 20,
      imagePath: Images.likeIcon,
    ),
    title: Text('Like'),
  ),
  Reaction<String>(
    value: 'Love',
    icon: CustomImage(
      width: 20,
      height: 20,
      imagePath: Images.loveIcon,
    ),
    title: Text('Love'),
  ),
  Reaction<String>(
    value: 'Haha',
    icon: CustomImage(
      width: 20,
      height: 20,
      imagePath: Images.hahaIcon,
    ),
    title: Text('Haha'),
  ),
  Reaction<String>(
    value: 'Wow',
    icon: CustomImage(
      width: 20,
      height: 20,
      imagePath: Images.wowIcon,
    ),
    title: Text('Wow'),
  ),
  Reaction<String>(
    value: 'Sad',
    icon: CustomImage(
      width: 20,
      height: 20,
      imagePath: Images.sadIcon,
    ),
    title: Text('Sad'),
  ),
  Reaction<String>(
    value: 'Angry',
    icon: CustomImage(
      width: 20,
      height: 20,
      imagePath: Images.angryIcon,
    ),
    title: Text('Angry'),
  ),
];

final Reaction<String> placeHolder = Reaction<String>(
  value: 'Like',
  icon: CustomImage(
    width: 20,
    height: 20,
    imagePath: Images.likeIcon,
  ),
  title: Text('Like'),
);