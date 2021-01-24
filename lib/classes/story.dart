class Comment {
  String text = ""; 
  final int commentId;
  Story story; 
  Comment({this.commentId,this.text});

  factory Comment.fromJSON(Map<String,dynamic> json) {
    return Comment(
      commentId: json["id"],
      text: json["text"]
    );
  }

}

class Story {
  
  final String title; 
  final String url; 
  List<int> commentIds = List<int>();

  final int storyId;

  Story({this.title,this.url,this.commentIds,this.storyId});

  factory Story.fromJSON(Map<String,dynamic> json) {
    return Story(
      storyId: json["id"],
      title: json["title"], 
      url: json["url"], 
      commentIds: json["kids"] == null ? List<int>() : json["kids"].cast<int>()
    );
  }

}