// ignore_for_file: unnecessary_import

import 'package:boilerplate/core/extensions/image_path.dart';
import 'package:boilerplate/features/newsfeed/models/newsfeed_model.dart';
import 'package:boilerplate/features/newsfeed/providers/newsfeed_provider.dart';
import 'package:boilerplate/features/newsfeed/views/widgets/comment_bottom_sheet_widget.dart';
import 'package:boilerplate/shared/utils/dimensions.dart';
import 'package:boilerplate/shared/utils/helpers.dart';
import 'package:boilerplate/shared/utils/reactions.dart';
import 'package:boilerplate/shared/utils/styles.dart';
import 'package:boilerplate/shared/widgets/custom_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';



class PostViewWidget extends ConsumerStatefulWidget {
  final NewsFeedModel newsFeedModel;
  const PostViewWidget({super.key, required this.newsFeedModel});

  @override
  ConsumerState<PostViewWidget> createState() => _PostViewWidgetState();
}

class _PostViewWidgetState extends ConsumerState<PostViewWidget> {
  final GlobalKey reactionKey = GlobalKey();
  Reaction<String>? selectedReaction;

  @override
  Widget build(BuildContext context) {
    ref.watch(newsFeedProvider);
    final newsFeedNotifier = ref.read(newsFeedProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: Dimensions.paddingSizeDefault,
              backgroundImage: NetworkImage(
                widget.newsFeedModel.user?.profilePic ?? '',
              ),
            ),
            title: Text(
              widget.newsFeedModel.user?.fullName ?? '',
              style: fontBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              timeAgo(widget.newsFeedModel.createdAt ?? ''),
              style: fontRegular.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: Dimensions.fontSizeSmall,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      
            trailing: Icon(
                Icons.more_vert,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
          ),
          Divider(
            color: Theme.of(context).hintColor,
            thickness: 0.5,
          ),

          if(widget.newsFeedModel.isBackground) ...[
            Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                gradient: parseLinearGradient(widget.newsFeedModel.bgColor?['backgroundImage'] ?? ''),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              ),
              child: RichText(text: TextSpan(
                  children: _buildTextSpans(widget.newsFeedModel.feedTxt ?? ''),
                  style: fontRegular.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                )),
            ),
          ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: RichText(text: TextSpan(
                  children: _buildTextSpans(widget.newsFeedModel.feedTxt ?? ''),
                  style: fontRegular.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                )),
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                child: CustomImage(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: widget.newsFeedModel.pic ?? '',
                ),
              ),
          ],

          


          const SizedBox(height: Dimensions.paddingSizeDefault),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              InkWell(
                onTap: () {
                  newsFeedNotifier.getReactions(feedId: widget.newsFeedModel.id.toString(), context: context, isUpdate: true);
                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Builder(
                      builder: (context) {
                        return Consumer(
                          builder: (context, watch, child) {
                            final newsFeedState1 = watch.watch(newsFeedProvider);
  
                            return AlertDialog(
                                  title: Text('Reactions'),
                                  content: newsFeedState1.reactionList == null ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(child: CircularProgressIndicator()),
                                    ],
                                  ) : 
                                  newsFeedState1.reactionList!.isEmpty ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Text('No reactions found'),
                                        ),
                                    ],
                                  ) : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: newsFeedState1.reactionList!.map((reaction) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                                          child: Text('${reaction.reactionType} : ${reaction.totalLikes.toString().padLeft(2, '0')}'),
                                        );
                                      }).toList(),
                                    ),
                                  actions: [
                                    TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Close'),
                                    ),
                                  ],
                                );
                          }
                        );
                      }
                    );
                      }
                  );
                },
                child: Row(
                  children: [
                  CustomImage(
                    width: 35,
                    height: 20,
                    imagePath: Images.likeLoveIcon,
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Text(
                    widget.newsFeedModel.likeCount.toString(),
                    style: fontMedium.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  ],
                ),
              ),
                  
              Row(
                children: [
                  CustomImage(
                    width: 16,
                    height: 16,
                    imagePath: Images.commentIcon,
                  ), 
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Text(
                    widget.newsFeedModel.commentCount == 0 
                      ? '0 Comment' 
                      : '${widget.newsFeedModel.commentCount} Comments',
                    style: fontMedium.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: Dimensions.paddingSizeDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Builder(
                builder: (context) {
                  return ReactionButton<String>(
                    toggle: false,
                    direction: ReactionsBoxAlignment.rtl,
                    onReactionChanged: (Reaction<String>? reaction) {
                      setState(() {
                        selectedReaction = reaction;
                      });
                      newsFeedNotifier.createReaction(feedId: widget.newsFeedModel.id.toString(), reactionType: reaction?.value ?? 'like', context: context);
                    },
                    reactions: reactions,
                    placeholder: placeHolder,
                    boxColor: Theme.of(context).cardColor,
                    boxRadius: 50,
                    itemsSpacing: Dimensions.paddingSizeSmall,
                    itemSize: const Size(32, 32),
                    boxPadding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Row(
                      children: [
                        selectedReaction?.icon ??  CustomImage(
                          width: 20,
                          height: 20,
                          imagePath: Images.likeIcon,
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        selectedReaction?.title ?? Text(
                          selectedReaction?.value ?? 'Like',
                          style: fontMedium.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          
              InkWell(
                onTap: () {
                    showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => DraggableScrollableSheet(
                      maxChildSize: 0.8,
                      initialChildSize: 0.8,
                      minChildSize: 0.8,
                      expand: false,
                      builder: (context, scrollController) => CommentBottomSheetWidget(
                        newsFeedModel: widget.newsFeedModel,
                        scrollController: scrollController,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    CustomImage(
                      width: 20,
                      height: 20,
                      imagePath: Images.commentFillIcon,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                      'Comment',
                      style: fontMedium.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          )
       
        ],
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String text) {
    final RegExp linkRegExp = RegExp(
      r'((https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-]*)*(\?[\w\-=&]*)?)',
      caseSensitive: false,
    );

    final List<TextSpan> spans = [];
    final matches = linkRegExp.allMatches(text);

    int start = 0;
    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      final String url = text.substring(match.start, match.end);
      spans.add(
        TextSpan(
          text: url,
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              launchURL(url);
            },
        ),
      );
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return spans;
  }
}



void launchURL(String url) async {
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    url = 'https://$url';
  }

  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw 'Could not launch $url';
  }
}