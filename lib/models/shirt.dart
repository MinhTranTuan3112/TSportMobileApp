import 'season_player.dart';
import 'shirt_edition.dart';

class ShirtItem {
  int id;
  String code;
  String description;
  String status;
  int shirtEditionId;
  int seasonPlayerId;
  String createdDate;
  int createdAccountId;
  String modifiedDate;
  int modifiedAccountId;
  SeasonPlayer seasonPlayer;
  ShirtEdition shirtEdition;

  ShirtItem(
      {required this.id,
      required this.code,
      required this.description,
      required this.status,
      required this.shirtEditionId,
      required this.seasonPlayerId,
      required this.createdDate,
      required this.createdAccountId,
      required this.modifiedDate,
      required this.modifiedAccountId,
      required this.seasonPlayer,
      required this.shirtEdition});
    
  factory ShirtItem.fromJson(Map<String, dynamic> json) {
    return ShirtItem(
      id: json['id'],
      code: json['code'],
      description: json['description'],
      status: json['status'],
      shirtEditionId: json['shirtEditionId'],
      seasonPlayerId: json['seasonPlayerId'],
      createdDate: json['createdDate'],
      createdAccountId: json['createdAccountId'],
      modifiedDate: json['modifiedDate'],
      modifiedAccountId: json['modifiedAccountId'],
      seasonPlayer: SeasonPlayer.fromJson(json['seasonPlayer']),
      shirtEdition: ShirtEdition.fromJson(json['shirtEdition']),
    );
  }
}
