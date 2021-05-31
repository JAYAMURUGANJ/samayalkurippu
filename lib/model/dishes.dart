class Dishes {
  String id;
  String image;
  String title;
  int categoryId;
  String youtubeVideoId;
  String message;

  Dishes(
      {this.id,
      this.image,
      this.title,
      this.categoryId,
      this.youtubeVideoId,
      this.message});

  Dishes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    categoryId = json['category_id'];
    youtubeVideoId = json['youtube_video_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['youtube_video_id'] = this.youtubeVideoId;
    data['message'] = this.message;
    return data;
  }
}
