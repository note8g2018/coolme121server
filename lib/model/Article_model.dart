

class Article
{
  String title;
  String body;
  String author;
  DateTime writingTimeUTC;
  bool isPublic;

  Article({
    this.title,
    this.body,
    this.author,
    this.writingTimeUTC,
    this.isPublic,
  });

  factory Article.fromJson(dynamic jsonObj)
  {
//    DateTime _dateTime;
//    if(jsonObj["writeTimeUTC"] == null)
//    {
//      _dateTime = null;
//    }
//    else
//    {
//      _dateTime = DateTime.fromMillisecondsSinceEpoch(jsonObj["writeTimeUTC"] as int).toUtc();
//    }
//      int kk = jsonObj["writeTimeUTC"] as int;
    return Article(
      title: jsonObj["title"] as String,
      body: jsonObj["body"] as String,
      author: jsonObj["author"] as String,
      isPublic: jsonObj["isPublic"] as bool,
      writingTimeUTC: DateTime.parse(jsonObj["writingTimeUTC"] as String),
      //writingTimeUTC: DateTime.parse(jsonObj["writeTimeUTC"] as String),
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      "title": title,
      "body": body,
      "author": author,
      "writingTimeUTC": writingTimeUTC?.toUtc()?.toString(),
      "isPublic": isPublic,
    };
  }
}