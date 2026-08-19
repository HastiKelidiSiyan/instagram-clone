import '../data/data_constants.dart';
import '../models/message.dart';

class MessageRepository {
  List<Message> getMessages() {
    return DataConstants.messages.map((e) => Message.fromJson(e)).toList();
  }
}
