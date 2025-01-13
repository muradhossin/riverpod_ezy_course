
import 'package:boilerplate/features/newsfeed/models/comment_model.dart';
import 'package:boilerplate/features/newsfeed/models/newsfeed_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'newsfeed_state_model.freezed.dart';
part 'newsfeed_state_model.g.dart';

@freezed
class NewsfeedStateModel with _$NewsfeedStateModel {
  const factory NewsfeedStateModel({
    @Default(false) bool isLoading,
    List<NewsFeedModel>? newsFeedList,
    List<CommentModel>? commentList,
    List<ReactionModel>? reactionList,
    Map<String, List<CommentModel>>? parentChildComments,
    @Default(false) bool isCommentLoading,
    @Default(false) bool isParentChildDataLoad,
  }) = _NewsfeedStateModel;

  factory NewsfeedStateModel.fromJson(Map<String, dynamic> json) => _$NewsfeedStateModelFromJson(json);
}