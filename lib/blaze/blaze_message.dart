import 'package:json_annotation/json_annotation.dart';
import 'package:mixin_bot_sdk_dart/mixin_bot_sdk_dart.dart';
import 'package:uuid/uuid.dart';

import '../constants/constants.dart';
import '../crypto/signal/signal_key_request.dart';
import '../enum/message_category.dart';
import '../enum/message_status.dart';
import '../utils/json.dart';
import 'blaze_message_param_session.dart';
import 'blaze_param.dart';

part 'blaze_message.g.dart';

@JsonSerializable()
class BlazeMessage {
  BlazeMessage({
    required this.id,
    required this.action,
    this.data,
    this.params,
    this.error,
  });

  factory BlazeMessage.fromJson(Map<String, dynamic> json) =>
      _$BlazeMessageFromJson(json);

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'action')
  String action;
  @JsonKey(
    name: 'params',
    toJson: dynamicToJson,
  )
  dynamic params;
  @JsonKey(
    name: 'data',
    toJson: dynamicToJson,
  )
  dynamic data;
  @JsonKey(name: 'error')
  MixinError? error;

  Map<String, dynamic> toJson() => _$BlazeMessageToJson(this);
}

BlazeMessage createParamBlazeMessage(BlazeMessageParam param) =>
    BlazeMessage(id: const Uuid().v4(), action: createMessage, params: param);

BlazeMessage createConsumeSessionSignalKeys(BlazeMessageParam param) =>
    BlazeMessage(
        id: const Uuid().v4(), action: consumeSessionSignalKeys, params: param);

BlazeMessage createSignalKeyMessage(BlazeMessageParam param) => BlazeMessage(
    id: const Uuid().v4(), action: createSignalKeyMessages, params: param);

BlazeMessage createCountSignalKeys() =>
    BlazeMessage(id: const Uuid().v4(), action: countSignalKeys, params: null);

BlazeMessage createSyncSignalKeys(BlazeMessageParam param) =>
    BlazeMessage(id: const Uuid().v4(), action: syncSignalKeys, params: param);

BlazeMessageParam createConsumeSignalKeysParam(
        List<BlazeMessageParamSession> recipients) =>
    BlazeMessageParam(recipients: recipients);

BlazeMessageParam createPlainJsonParam(
        String conversationId, String userId, String encoded,
        {String? sessionId}) =>
    BlazeMessageParam(
        conversationId: conversationId,
        recipientId: userId,
        messageId: const Uuid().v4(),
        candidate: MessageCategory.plainJson.toString(),
        data: encoded,
        status: MessageStatus.sending.toString(),
        sessionId: sessionId);

BlazeMessageParam createSyncSignalKeysParam(SignalKeyRequest? request) =>
    BlazeMessageParam(keys: request);
