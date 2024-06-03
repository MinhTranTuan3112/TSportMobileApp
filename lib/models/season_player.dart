import 'package:tsport_mobile_app/models/player.dart';
import 'package:tsport_mobile_app/models/season.dart';

class SeasonPlayer {
  int id;
  int seasonId;
  int playerId;
  Player player;
  Season season;

  SeasonPlayer(
      {required this.id,
      required this.seasonId,
      required this.playerId,
      required this.player,
      required this.season});

  factory SeasonPlayer .fromJson(Map<String, dynamic> json) {
    return SeasonPlayer(
      id: json['id'],
      seasonId: json['seasonId'],
      playerId: json['playerId'],
      player: Player.fromJson(json['player']),
      season: Season.fromJson(json['season']),
    );
  }
}
