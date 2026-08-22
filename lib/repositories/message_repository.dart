import 'package:instagram_clone/data_source/remote_data_source.dart';

import '../data/data_constants.dart';
import '../models/message_model.dart';

class MessageRepository {
  RemoteDataSource remoteDataSource = RemoteDataSource();

  Future<List<MessageModel>> getMessages() async {
    return await remoteDataSource.getMessages();
  }
}
