import 'package:boilerplate/core/constants/app_constants.dart';
import 'package:boilerplate/core/data/api/api_client.dart';
import 'package:http/http.dart';

class NewsfeedRepo {
  final ApiClient apiClient;
  NewsfeedRepo({required this.apiClient});

  Future<Response> getNewsFeed ({String? lastFeedId}) async {
    Map<String, String> body = {
      'community_id': '2914',
      'space_id': '5883',
      'more' : lastFeedId ?? '',
    };

    return apiClient.postData('${AppConstants.newsfeedUri}?status=feed&', body);
  }

  Future<Response> createPost ({required String feedText, required int selectedIndex }) async {
    Map<String, String> body = {
      'feed_txt': feedText,
      'community_id': '2914',
      'space_id' : '5883',
      'uploadType' : 'text',
      'activity_type' : 'group',
      'is_background' : selectedIndex != 0 ? '1' : '0',

    };
    if(selectedIndex != 0) {
      body.addAll({'bg_color' : _feedBackGroundGradientColors[selectedIndex - 1]});
    }

    return apiClient.postData(AppConstants.createPostUri, body);
  }

  Future<Response> getComments ({required String feedId}) async {
    return apiClient.getData(AppConstants.getCommentUri + feedId); 
  }

  Future<Response> createComment ({required String feedId, required String feedUserId, required String commentText, String? parrentId}) async {
    Map<String, String> body = {
      'feed_id': feedId,
      'feed_user_id': feedUserId,
      'comment_txt' : commentText,
      'commentSource' : 'COMMUNITY',
    };
    if(parrentId != null) {
      body.addAll({'parrent_id' : parrentId});
    }
    return apiClient.postData(AppConstants.createCommentUri, body);
  }


  Future<Response> createReaction ({required String feedId, required String reactionType}) async {
    Map<String, String> body = {
      'feed_id': feedId,
      'reaction_type' : reactionType.toUpperCase(),
      'action' : 'deleteOrCreate',
      'reactionSource' : 'COMMUNITY'
    };
    return apiClient.postData(AppConstants.createReactionUri, body);
  }

  Future<Response> getReactions ({required String feedId}) async {
    return apiClient.getData(AppConstants.getReeactionUri + feedId);
  }

  Future<Response> fetchReply ({required String parentId}) async {
    return apiClient.getData(AppConstants.fetchReplyUri + parentId);
  }






}

final List _feedBackGroundGradientColors = [
  "{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 115, 0) 0%, rgb(255, 0, 234) 100%)\"}",
  "{\"backgroundImage\":\"linear-gradient(135deg, rgb(143, 199, 173), rgb(72, 229, 169))\"}",
  "{\"backgroundImage\":\"linear-gradient(135deg, rgb(116, 167, 126), rgb(24, 175, 78))\"}",
  "{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 127, 17) 0%, rgb(255, 127, 17) 100%)\"}",
  "{\"backgroundImage\":\"linear-gradient(45deg, rgb(233, 255, 66) 0%, rgb(0, 255, 225) 100%)\"}"
];

