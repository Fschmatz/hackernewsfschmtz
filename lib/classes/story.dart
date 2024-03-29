import 'package:timeago/timeago.dart' as timeago;

class Story {
  
  final String? title;
  final String? url;
  final int? storyId;
  final int? score;
  final int? commentsCount;
  final int? time; //UnixTime
  bool? lido;

  Story({this.title,this.url,this.storyId,this.commentsCount,this.score,this.time,this.lido});


  String get timeAgo{
    return timeago.format(DateTime.fromMillisecondsSinceEpoch(time! * 1000));
  }

  factory Story.fromJSON(Map<String,dynamic> json) {
    return Story(
      storyId: json["id"],
      title: json["title"], 
      url: json["url"],
      score: json["score"],
      commentsCount: json["descendants"],
      time: json["time"],
    );
  }


}

