class Profile {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? avatar;
  String? createdAt;
  String? emailNotification;
  String? smsNotification;
  Null? description;
  String? postsCount;
  String? postCommentsCount;
  String? postFavoritesCount;
  String? commentFavoritesCount;
  bool? isFollow;

  Profile(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.avatar,
        this.createdAt,
        this.emailNotification,
        this.smsNotification,
        this.description,
        this.postsCount,
        this.postCommentsCount,
        this.postFavoritesCount,
        this.commentFavoritesCount,
        this.isFollow});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    emailNotification = json['email_notification'];
    smsNotification = json['sms_notification'];
    description = json['description'];
    postsCount = json['posts_count'];
    postCommentsCount = json['post_comments_count'];
    postFavoritesCount = json['post_favorites_count'];
    commentFavoritesCount = json['comment_favorites_count'];
    isFollow = json['is_follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    data['email_notification'] = this.emailNotification;
    data['sms_notification'] = this.smsNotification;
    data['description'] = this.description;
    data['posts_count'] = this.postsCount;
    data['post_comments_count'] = this.postCommentsCount;
    data['post_favorites_count'] = this.postFavoritesCount;
    data['comment_favorites_count'] = this.commentFavoritesCount;
    data['is_follow'] = this.isFollow;
    return data;
  }
}
