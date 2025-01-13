import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/features/newsfeed/models/comment_model.dart';
import 'package:boilerplate/features/newsfeed/models/newsfeed_model.dart';
import 'package:boilerplate/features/newsfeed/models/newsfeed_state_model.dart';
import 'package:boilerplate/features/newsfeed/repositories/newsfeed_repo.dart';
import 'package:boilerplate/shared/providers/api_client_provider.dart';
import 'package:boilerplate/shared/widgets/custom_snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsfeedNotifier extends StateNotifier<NewsfeedStateModel> {
  final NewsfeedRepo newsfeedRepo;
  NewsfeedNotifier(this.newsfeedRepo) : super(NewsfeedStateModel());

  Future<void> getNewsfeedList({bool isUpdate = true, String? lastFeedId}) async {
    if (isUpdate) state = state.copyWith(isLoading: true);
    final response = await newsfeedRepo.getNewsFeed(lastFeedId: lastFeedId);
    if (response.statusCode == 200) {
      final newNewsfeedList = List<NewsFeedModel>.from(jsonDecode(response.body).map((x) => NewsFeedModel.fromJson(x)));

      if(isUpdate) {
        state = state.copyWith(newsFeedList: newNewsfeedList, isLoading: false);
        return;
      }

      final Map<String, NewsFeedModel> newsFeedMap = {
        for (var item in state.newsFeedList ?? []) item.id.toString(): item
      };

      for (var item in newNewsfeedList) {
        newsFeedMap[item.id.toString()] = item;
      }

      final updatedNewsfeedList = newsFeedMap.values.toList();

      state = state.copyWith(
        newsFeedList: updatedNewsfeedList,
        isLoading: false,
      );
    } else {
      state = state.copyWith(isLoading: false, newsFeedList: []);
    }
  }

  Future<bool> createPost({required BuildContext context, required String post, required int selectedIndex}) async {
    state = state.copyWith(isLoading:  true);
    bool isSuccess = false;
    final response = await newsfeedRepo.createPost(feedText: post, selectedIndex: selectedIndex);
    if(response.statusCode == 200) {
      await getNewsfeedList(isUpdate: true);
      if(context.mounted) {
        showCustomSnackbar(context: context, message: 'Post created successfully');
      }
      isSuccess = true;
    } else {
      if(context.mounted) {
        showCustomSnackbar(context: context, message: 'Failed to create post', isError: true);
      }
      isSuccess = false;
    }

    state = state.copyWith(isLoading:  false);
    return isSuccess;
  }

    Future<void> getComments({required BuildContext context, required String feedId, bool isUpdate = true}) async {
    if(isUpdate) state = state.copyWith(commentList: null, isLoading: false);
    state = state.copyWith(isParentChildDataLoad: true);

    final response = await newsfeedRepo.getComments(feedId: feedId);
    if (response.statusCode == 200) {
      log(response.body.toString(), name: 'NewsfeedController');
      state = state.copyWith(commentList: List<CommentModel>.from(jsonDecode(response.body).map((x) => CommentModel.fromJson(x))), isLoading: false);
      log('Comments fetched: ${state.commentList?.length}', name: 'NewsfeedController'); 
      if(context.mounted) {
        await divideParentChildComments(state.commentList, context);
      }
    } else {
      state = state.copyWith(isLoading: false, commentList: [], isParentChildDataLoad: false);
      if(context.mounted) {
        showCustomSnackbar(context: context, message: 'Failed to fetch comments', isError: true);
      }
    }
   
  }

  Future<void> divideParentChildComments(List<CommentModel>? commentList, BuildContext context) async {
    state = state.copyWith(parentChildComments: {});
    if (commentList == null || commentList.isEmpty) {
      state = state.copyWith(isParentChildDataLoad: false);
      return;
    }

    for (var comment in commentList) {
      state = state.copyWith(parentChildComments: {
        ...state.parentChildComments!,
        comment.id.toString(): [],
      });
    }

    for (var parentId in state.parentChildComments!.keys) {
      await fetchReply(context: context, parentId: parentId);
    }
  }


  Future<void> fetchReply({required BuildContext context, required String parentId}) async {
    state = state.copyWith(isLoading: false);
    final response = await newsfeedRepo.fetchReply(parentId: parentId);
    if (response.statusCode == 200) {
      log(response.body.toString(), name: 'NewsfeedController');
      List<CommentModel> replies = List<CommentModel>.from(jsonDecode(response.body).map((x) => CommentModel.fromJson(x)));
      if (replies.isNotEmpty) {
        state = state.copyWith(parentChildComments: {
          ...state.parentChildComments!,
          parentId: [...state.parentChildComments![parentId]!, ...replies],
        });
      }
    } else {
      if(context.mounted) {
        showCustomSnackbar(context: context, message: 'Failed to fetch replies', isError: true);
      }
    }

    log('length Parent: ${state.parentChildComments?.length}', name: 'NewsfeedController'); 

    state = state.copyWith(isLoading: false, isParentChildDataLoad: false);
  }

  Future<bool> createComment({required BuildContext context, required String feedId, required String feedUserId, required String commentText, String? parentId}) async {
    state = state.copyWith(isCommentLoading: true);
    bool isSuccess = false;
    final response = await newsfeedRepo.createComment(feedId: feedId, feedUserId: feedUserId, commentText: commentText, parrentId: parentId);
    if(response.statusCode == 200) {
      if(context.mounted) {
        showCustomSnackbar(context: context, message: 'Comment created successfully');
      }
      isSuccess = true;
      await getComments(context: context, feedId: feedId, isUpdate: false);
      await getNewsfeedList(isUpdate: false);
    } else {
      if(context.mounted) {
        showCustomSnackbar(context: context, message: 'Failed to create comment', isError: true);
      }
      isSuccess = false;
    }

    state = state.copyWith(isCommentLoading: false);
    return isSuccess;
  }

  Future<bool> createReaction({required BuildContext context, required String feedId, required String reactionType}) async {
    state = state.copyWith(isLoading: false);
    bool isSuccess = false;
    final response = await newsfeedRepo.createReaction(feedId: feedId, reactionType: reactionType);
    if(response.statusCode == 200) {
      if(context.mounted) {
        showCustomSnackbar(context: context, message: 'Reaction created successfully');
      }
      isSuccess = true;
      await getNewsfeedList(isUpdate: false);
    } else {
      if(context.mounted) {
        showCustomSnackbar(context: context, message: 'Failed to create reaction', isError: true);
      }
      isSuccess = false;
    }

    state = state.copyWith(isLoading: false);
    return isSuccess;
  }

  Future<void> getReactions({required BuildContext context, required String feedId, bool isUpdate = true}) async {
    if(isUpdate) state = state.copyWith(reactionList: null, isLoading: false);
    final response = await newsfeedRepo.getReactions(feedId: feedId);
    if(response.statusCode == 200) {
      log(response.body.toString(), name: 'NewsfeedController');
      state = state.copyWith(reactionList: List<ReactionModel>.from(jsonDecode(response.body).map((x) => ReactionModel.fromJson(x))), isLoading: false);
    } else {
      if(context.mounted) {
        showCustomSnackbar(context: context, message: 'Failed to get reactions', isError: true);
      }
      state = state.copyWith(isLoading: false, reactionList: []);
    }

    state = state.copyWith(isLoading: false);

    log('length: ${state.reactionList?.length}', name: 'NewsfeedController');
  }

}


final newsfeedRepoProvider = Provider<NewsfeedRepo>((ref) {
  return NewsfeedRepo(
    apiClient: ref.read(apiClientProvider),
  );
});

final newsFeedProvider = StateNotifierProvider<NewsfeedNotifier, NewsfeedStateModel>((ref) {
  return NewsfeedNotifier(ref.watch(newsfeedRepoProvider));
});