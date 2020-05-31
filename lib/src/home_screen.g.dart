// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supply _$SupplyFromJson(Map<String, dynamic> json) {
  return Supply(
    itemDescription: json['itemDescription'] as String,
    spotted: DateTime.fromMillisecondsSinceEpoch(-1 * (json['spotted'] as int)),
    username: json['username'] as String,
    address: json['address'] as String,
    store: Store.fromJson(Map<String, dynamic>.from(json['store'])),
    imageURL: json['imageURL'] as String,
  );
}

Map<String, dynamic> _$SupplyToJson(Supply instance) => <String, dynamic>{
      'itemDescription': instance.itemDescription,
      'spotted': -1 * instance.spotted.millisecondsSinceEpoch,
      'username': instance.username,
      'address': instance.address,
      'store': instance.store.toJson(),
      'imageURL': instance.imageURL,
    };

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    name: json['name'] as String,
    locationName: json['locationName'] as String,
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'name': instance.name,
      'locationName': instance.locationName,
    };
