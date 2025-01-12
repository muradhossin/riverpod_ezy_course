import 'dart:convert';

class NewsFeedModel {
  int? id;
  int? schoolId;
  int? userId;
  int? communityId;
  String? feedTxt;
  String? status;
  String? slug;
  String? title;
  String? activityType;
  int? isPinned;
  String? fileType;
  int? likeCount;
  int? commentCount;
  int? shareCount;
  int? shareId;
  String? createdAt;
  String? updatedAt;
  String? feedPrivacy;
  bool isBackground = false;
  Map<String, dynamic>? bgColor;
  String? publishDate;
  bool? isFeedEdit;
  String? name;
  String? pic;
  int? uid;
  int? isPrivateChat;
  User? user;
  List<LikeType>? likeType;

  NewsFeedModel({
  this.id, 
  this.schoolId, 
  this.userId, 
  this.communityId,  
  this.feedTxt, 
  this.status, 
  this.slug, 
  this.title, 
  this.activityType, 
  this.isPinned, 
  this.fileType, 
  this.likeCount, 
  this.commentCount, 
  this.shareCount, 
  this.shareId, 
  this.createdAt, 
  this.updatedAt, 
  this.feedPrivacy, 
  this.isBackground = false,
  this.bgColor,
  });

  NewsFeedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    userId = json['user_id'];
    communityId = json['community_id'];
    feedTxt = json['feed_txt'];
    status = json['status'];
    slug = json['slug'];
    title = json['title'];
    activityType = json['activity_type'];
    isPinned = json['is_pinned'];
    fileType = json['file_type'];
    likeCount = json['like_count'];
    commentCount = json['comment_count'];
    shareCount = json['share_count'];
    shareId = json['share_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    feedPrivacy = json['feed_privacy'];
    isBackground = json['is_background'] == 1;
    try {
      bgColor = json['bg_color'] != null ? jsonDecode(json['bg_color']) : null;
    } catch (e) {
      bgColor = null;
    }
    publishDate = json['publish_date'];
    isFeedEdit = json['is_feed_edit'];
    name = json['name'];
    pic = json['pic'];
    uid = json['uid'];
    isPrivateChat = json['is_private_chat'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['likeType'] != null) {
      likeType = <LikeType>[];
      json['likeType'].forEach((v) { likeType!.add(LikeType.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['school_id'] = schoolId;
    data['user_id'] = userId;
    data['community_id'] = communityId;
    data['feed_txt'] = feedTxt;
    data['status'] = status;
    data['slug'] = slug;
    data['title'] = title;
    data['activity_type'] = activityType;
    data['is_pinned'] = isPinned;
    data['file_type'] = fileType;
    data['like_count'] = likeCount;
    data['comment_count'] = commentCount;
    data['share_count'] = shareCount;
    data['share_id'] = shareId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['feed_privacy'] = feedPrivacy;
    data['is_background'] = isBackground;
    data['bg_color'] = bgColor;
    data['publish_date'] = publishDate;
    data['is_feed_edit'] = isFeedEdit;
    data['name'] = name;
    data['pic'] = pic;
    data['uid'] = uid;
    data['is_private_chat'] = isPrivateChat;
    if (user != null) {
    data['user'] = user!.toJson();
  }

    if (likeType != null) {
    data['likeType'] = likeType!.map((v) => v.toJson()).toList();
  }
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? profilePic;
  int? isPrivateChat;
  String? userType;
  

  User({this.id, this.fullName, this.profilePic, this.isPrivateChat});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    isPrivateChat = json['is_private_chat'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['profile_pic'] = profilePic;
    data['is_private_chat'] = isPrivateChat;

    return data;
  }
}

class LikeType {
  String? reactionType;
  int? feedId;
  LikeType({this.reactionType, this.feedId});

  LikeType.fromJson(Map<String, dynamic> json) {
    reactionType = json['reaction_type'];
    feedId = json['feed_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reaction_type'] = reactionType;
    data['feed_id'] = feedId;
    return data;
  }
}

class Meta {
  int? views;

  Meta({this.views});

  Meta.fromJson(Map<String, dynamic> json) {
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['views'] = views;
    return data;
  }
}


class ReactionModel {
	int? totalLikes;
	String? reactionType;
	ReactionModel({this.totalLikes, this.reactionType});

	ReactionModel.fromJson(Map<String, dynamic> json) {
		totalLikes = json['total_likes'];
		reactionType = json['reaction_type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['total_likes'] = totalLikes;
		data['reaction_type'] = reactionType;
		return data;
	}
}