library feed_item;

import 'package:meta/meta.dart';

@immutable
class FeedEntry {
  final String id;
  final String feedId;
  final String url;
  final String title;
  final String author;
  final String content;
  final int date;
  final bool read;
  final bool starred;

  final bool readStateTransitioning;
  final bool starredStateTransitioning;

  FeedEntry(
      this.id,
      this.feedId,
      this.url,
      this.title,
      this.author,
      this.content,
      this.date,
      this.read,
      this.starred,
      this.readStateTransitioning,
      this.starredStateTransitioning);

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is FeedEntry &&
            id == other.id &&
            feedId == other.feedId &&
            url == other.url &&
            title == other.title &&
            author == other.author &&
            content == other.content &&
            date == other.date &&
            read == other.read &&
            starred == other.starred &&
            readStateTransitioning == other.readStateTransitioning &&
            starredStateTransitioning == other.starredStateTransitioning);
  }

  @override
  int get hashCode {
    int result = "FeedItem".hashCode;
    result = 31 * result + id.hashCode;
    result = 31 * result + feedId.hashCode;
    result = 31 * result + url.hashCode;
    result = 31 * result + title.hashCode;
    result = 31 * result + author.hashCode;
    result = 31 * result + content.hashCode;
    result = 31 * result + date.hashCode;
    result = 31 * result + read.hashCode;
    result = 31 * result + starred.hashCode;
    result = 31 * result + readStateTransitioning.hashCode;
    result = 31 * result + starredStateTransitioning.hashCode;
    return result;
  }

  String toString() {
    return 'FeedItem($id, $feedId, $url, $title, $author, $content, $date, $read, $starred, $readStateTransitioning, $starredStateTransitioning)';
  }

  FeedEntry copy(
      {String id,
      String feedId,
      String url,
      String title,
      String author,
      String content,
      String date,
      bool read,
      bool starred,
      bool readStateTransitioning,
      bool starredStateTransitioning}) {
    return new FeedEntry(
        id ?? this.id,
        feedId ?? this.feedId,
        url ?? this.url,
        title ?? this.title,
        author ?? this.author,
        content ?? this.content,
        date ?? this.date,
        read ?? this.read,
        starred ?? this.starred,
        readStateTransitioning ?? this.readStateTransitioning,
        starredStateTransitioning ?? this.starredStateTransitioning);
  }

  static FeedEntry fromJson(json) {
    assert(json is Map);
    return new FeedEntry(
        json['id'],
        json['feedId'],
        json['url'],
        json['title'],
        json['author'],
        json['content'],
        json['date'],
        json['read'],
        json['starred'],
        false,
        false);
  }
}
