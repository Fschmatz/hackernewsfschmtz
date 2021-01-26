class Story {
  
  final String title; 
  final String url;
  final int storyId;

  Story({this.title,this.url,this.storyId});

  factory Story.fromJSON(Map<String,dynamic> json) {
    return Story(
      storyId: json["id"],
      title: json["title"], 
      url: json["url"],
    );
  }

}

// commentIds: json["kids"] == null ? List<int>() : json["kids"].cast<int>()
//List<int> commentIds = List<int>();