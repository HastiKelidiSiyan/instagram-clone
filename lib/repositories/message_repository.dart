import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

import '../models/message_model.dart';

class MessageRepository {
  RemoteDataSource remoteDataSource = RemoteDataSource();
  LocalDataSource localDataSource = LocalDataSource();
  ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<MessageModel>> getMessages() async {
    if (await connectivityResult.isConnected()) {
      final messages = await remoteDataSource.getMessages();
      await localDataSource.cacheMessages(messages);
      return messages;
    } else {
      return await localDataSource.getMessages();
    }
  }
}
