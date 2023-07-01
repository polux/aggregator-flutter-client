library feed_info;

import 'package:meta/meta.dart';

@immutable
class FeedInfo {
  final String id;
  final String origin;
  final int unreadCount;
  final String title;

  FeedInfo(String id, String origin, int unreadCount, String title)
      : this.id = id,
        this.origin = origin,
        this.unreadCount = unreadCount,
        this.title = title;

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is FeedInfo &&
            id == other.id &&
            origin == other.origin &&
            unreadCount == other.unreadCount &&
            title == other.title);
  }

  @override
  int get hashCode {
    int result = "FeedInfo".hashCode;
    result = 31 * result + id.hashCode;
    result = 31 * result + origin.hashCode;
    result = 31 * result + unreadCount.hashCode;
    result = 31 * result + title.hashCode;
    return result;
  }

  String toString() {
    return 'FeedInfo($id, $origin, $unreadCount, $title)';
  }

  FeedInfo copy({String id, String origin, int unreadCount, String title}) {
    return new FeedInfo(
        (id != null) ? id : this.id,
        (origin != null) ? origin : this.origin,
        (unreadCount != null) ? unreadCount : this.unreadCount,
        (title != null) ? title : this.title);
  }

  static FeedInfo fromJson(json) {
    assert(json is Map);
    return new FeedInfo(
        json['id'], json['origin'], json['unreadCount'], json['title']);
  }
}
