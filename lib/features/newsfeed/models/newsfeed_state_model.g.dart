// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsfeed_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsfeedStateModelImpl _$$NewsfeedStateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NewsfeedStateModelImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      newsFeedList: (json['newsFeedList'] as List<dynamic>?)
          ?.map((e) => NewsFeedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentList: (json['commentList'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reactionList: (json['reactionList'] as List<dynamic>?)
          ?.map((e) => ReactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      parentChildComments:
          (json['parentChildComments'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      isCommentLoading: json['isCommentLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$NewsfeedStateModelImplToJson(
        _$NewsfeedStateModelImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'newsFeedList': instance.newsFeedList,
      'commentList': instance.commentList,
      'reactionList': instance.reactionList,
      'parentChildComments': instance.parentChildComments,
      'isCommentLoading': instance.isCommentLoading,
    };
