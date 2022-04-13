
class Post {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  Post(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Post.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? path;
  String? userId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? favoritesCount;
  String? commentsCount;
  String? descriptionData;
  String? descriptionIframe;
  bool? isFavorite;
  List<Comments>? comments;
  User? user;

  Data(
      {this.id,
        this.title,
        this.description,
        this.path,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.favoritesCount,
        this.commentsCount,
        this.descriptionData,
        this.descriptionIframe,
        this.isFavorite,
        this.comments,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    path = json['path'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    favoritesCount = json['favorites_count'];
    commentsCount = json['comments_count'];
    descriptionData = json['description_data'];
    descriptionIframe = json['description_iframe'];
    isFavorite = json['is_favorite'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['path'] = this.path;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['favorites_count'] = this.favoritesCount;
    data['comments_count'] = this.commentsCount;
    data['description_data'] = this.descriptionData;
    data['description_iframe'] = this.descriptionIframe;
    data['is_favorite'] = this.isFavorite;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Comments {
  int? id;
  String? userId;
  String? description;
  String? postId;
  var postCommentId;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  bool? isFavorite;
  User? user;
  List<String>? attachments;

  Comments(
      {this.id,
        this.userId,
        this.description,
        this.postId,
        this.postCommentId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isFavorite,
        this.user,
        this.attachments});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    postId = json['post_id'];
    postCommentId = json['post_comment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isFavorite = json['is_favorite'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((v) {
        attachments!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['post_id'] = this.postId;
    data['post_comment_id'] = this.postCommentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_favorite'] = this.isFavorite;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? avatar;
  String? createdAt;
  String? emailNotification;
  String? smsNotification;
  String? description;
  bool? isFollow;

  User(
      {this.id,
        this.name,
        this.avatar,
        this.createdAt,
        this.emailNotification,
        this.smsNotification,
        this.description,
        this.isFollow});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    emailNotification = json['email_notification'];
    smsNotification = json['sms_notification'];
    description = json['description'];
    isFollow = json['is_follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    data['email_notification'] = this.emailNotification;
    data['sms_notification'] = this.smsNotification;
    data['description'] = this.description;
    data['is_follow'] = this.isFollow;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
