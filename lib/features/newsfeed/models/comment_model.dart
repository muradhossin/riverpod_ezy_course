class CommentModel {
	int? id;
	int? schoolId;
	int? feedId;
	int? userId;
	int? replyCount;
	int? likeCount;
	String? commentTxt;
	int? parrentId;
	String? createdAt;
	String? updatedAt;
	int? isAuthorAndAnonymous;
	User? user;

	CommentModel({this.id, this.schoolId, this.feedId, this.userId, this.replyCount, this.likeCount, this.commentTxt, this.parrentId, this.createdAt, this.updatedAt, this.isAuthorAndAnonymous, this.user});

	CommentModel.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		schoolId = json['school_id'];
		feedId = json['feed_id'];
		userId = json['user_id'];
		replyCount = json['reply_count'];
		likeCount = json['like_count'];
		commentTxt = json['comment_txt'];
		parrentId = json['parrent_id'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		isAuthorAndAnonymous = json['is_author_and_anonymous'];
		user = json['user'] != null ? User.fromJson(json['user']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['school_id'] = schoolId;
		data['feed_id'] = feedId;
		data['user_id'] = userId;
		data['reply_count'] = replyCount;
		data['like_count'] = likeCount;
		data['comment_txt'] = commentTxt;
		data['parrent_id'] = parrentId;
		data['created_at'] = createdAt;
		data['updated_at'] = updatedAt;
		data['is_author_and_anonymous'] = isAuthorAndAnonymous;
		if (user != null) {
      data['user'] = user!.toJson();
    }
		return data;
	}
}

class User {
	int? id;
	String? fullName;
	String? profilePic;
	String? userType;

	User({this.id, this.fullName, this.profilePic, this.userType});

	User.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		fullName = json['full_name'];
		profilePic = json['profile_pic'];
		userType = json['user_type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['full_name'] = fullName;
		data['profile_pic'] = profilePic;
		data['user_type'] = userType;

		return data;
	}
}
