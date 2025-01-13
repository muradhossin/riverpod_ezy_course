
import 'package:boilerplate/core/extensions/image_path.dart';
import 'package:boilerplate/features/newsfeed/models/newsfeed_model.dart';
import 'package:boilerplate/features/newsfeed/providers/newsfeed_provider.dart';
import 'package:boilerplate/shared/utils/dimensions.dart';
import 'package:boilerplate/shared/utils/styles.dart';
import 'package:boilerplate/shared/widgets/custom_image.dart';
import 'package:boilerplate/shared/widgets/custom_snackbar.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CommentBottomSheetWidget extends ConsumerStatefulWidget {
  final NewsFeedModel newsFeedModel;
  final ScrollController? scrollController;
  const CommentBottomSheetWidget({super.key, this.scrollController, required this.newsFeedModel});

  @override
  ConsumerState<CommentBottomSheetWidget> createState() => _CommentBottomSheetWidgetState();
}

class _CommentBottomSheetWidgetState extends ConsumerState<CommentBottomSheetWidget> {
  TextEditingController commentController = TextEditingController();
  String? parentId;
  String? replyingTo;

  @override
  void initState() {
    super.initState();
    Future(() {
      getComments();
    });
  }

  Future<void> getComments() async {
    final newsFeedController = ref.read(newsFeedProvider.notifier);
    await newsFeedController.getComments(feedId: widget.newsFeedModel.id?.toString() ?? "", isUpdate: false, context: context);
  }

  @override
  Widget build(BuildContext context) {
    final newsfeedNotifier = ref.read(newsFeedProvider.notifier);
    final newsFeedState = ref.watch(newsFeedProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusLarge),
                topRight: Radius.circular(Dimensions.radiusLarge),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Theme.of(context).colorScheme.error, size: 18,),
                    SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Text(
                      '${widget.newsFeedModel.likeCount}',
                      style: fontMedium
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Consumer(
                  builder: (context, watch, child) {
                    if (newsFeedState.isLoading || newsFeedState.parentChildComments == null || newsFeedState.isParentChildDataLoad) {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (!newsFeedState.isLoading && newsFeedState.parentChildComments!.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text('No comments found'),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          controller: widget.scrollController,
                          child: Column(
                            children: newsFeedState.parentChildComments!.entries.toList().reversed.map((entry) {
                              final parentCommentId = entry.key;
                              final parentComment = newsFeedState.commentList?.firstWhere(
                                (comment) => comment.id.toString() == parentCommentId.toString(),
                              );
                              final childComments = entry.value;

                              if (parentComment == null) {
                                return SizedBox.shrink(); 
                              }

                              return CommentTreeWidget<Comment, Comment>(
                                Comment(
                                  avatar: parentComment.user?.profilePic ?? '',
                                  userName: parentComment.user?.fullName ?? '',
                                  content: parentComment.commentTxt ?? '',
                                ),
                                childComments.map((e) => Comment(
                                  avatar: e.user?.profilePic ?? '',
                                  userName: e.user?.fullName ?? '',
                                  content: e.commentTxt ?? '',
                                )).toList(),
                                treeThemeData: TreeThemeData(lineColor: Theme.of(context).primaryColor, lineWidth: 3),
                                avatarRoot: (context, data) => PreferredSize(
                                  preferredSize: Size.fromRadius(18),
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(
                                      data.avatar ?? Images.placeHolderMan,
                                    ),
                                  ),
                                ),
                                avatarChild: (context, data) => PreferredSize(
                                  preferredSize: Size.fromRadius(12),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(
                                      data.avatar ?? Images.placeHolderMan,
                                    ),
                                  ),
                                ),
                                contentChild: (context, data) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.userName ?? '',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  fontWeight: FontWeight.w600, color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              '${data.content}',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  fontWeight: FontWeight.w300, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DefaultTextStyle(
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: Colors.grey[700], fontWeight: FontWeight.bold),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text('Like'),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    parentId = parentCommentId;
                                                    replyingTo = data.userName;

                                                  });
                                                
                                                },
                                                child: Text('Reply'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                contentRoot: (context, data) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.userName ?? '',
                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                  fontWeight: FontWeight.w600, color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              '${data.content}',
                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                  fontWeight: FontWeight.w300, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DefaultTextStyle(
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: Colors.grey[700], fontWeight: FontWeight.bold),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text('Like'),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    parentId = parentCommentId;
                                                    replyingTo = data.userName;

                                                  });
                                                
                                                },
                                                child: Text('Reply'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }
                  }
                ),

                Column(
                  children: [
                    if (replyingTo != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall, top: Dimensions.paddingSizeSmall),
                        child: Row(
                          children: [
                            Text(
                              'Replying to $replyingTo',
                              style: fontMedium.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                            SizedBox(width: Dimensions.paddingSizeDefault),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  parentId = null;
                                  replyingTo = null;
                                });
                              },
                              child: Icon(Icons.close, color: Theme.of(context).hintColor, size: 22),
                            ),
                          ],
                        ),
                      ),
                    ],
                    Container(
                      margin: EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFF0F2F5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                              child: CustomImage(
                                height: 40,
                                width: 40,
                                imagePath: Images.placeHolderMan,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                hintStyle: fontRegular.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                                hintText: 'Write a Comment',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                    
                          Consumer(
                            builder: (context, watch, child) {
                              return InkWell(
                                onTap: () async {
                                  if (commentController.text.isNotEmpty) {
                                    await newsfeedNotifier.createComment(
                                      context: context,
                                      feedId: widget.newsFeedModel.id?.toString() ?? "",
                                      feedUserId: widget.newsFeedModel.userId?.toString() ?? "",
                                      commentText: commentController.text,
                                      parentId: parentId
                                    );
                                    commentController.clear();
                                    setState(() {
                                      parentId = null;
                                      replyingTo = null;
                                    });
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    Navigator.pop(context);
                                    showCustomSnackbar(message: 'Write something', isError: true, context: context);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: newsFeedState.isCommentLoading ? Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).secondaryHeaderColor),
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ) : CustomImage(
                                    height: 24,
                                    width: 24,
                                    imagePath: Images.sentIcon,
                                    fit: BoxFit.contain,
                                  )
                                ),
                              );
                            }
                          ),
                        
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}