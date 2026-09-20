import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/message_model.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class MessageRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<MessageModel>> getMessages([String conversationId = '']) async {
    if (conversationId.isEmpty) {
      return const [];
    }

    if (await connectivityResult.isConnected()) {
      final messages = await remoteDataSource.getMessages(conversationId);
      for (final message in messages) {
        await localDataSource.sendMessage(message);
      }
      return messages;
    }

    return localDataSource.getMessages(conversationId);
  }

  Future<List<MessageModel>> getConversationMessages(
    String conversationId,
  ) async {
    if (conversationId.isEmpty) return const [];

    if (await connectivityResult.isConnected()) {
      final messages = await remoteDataSource.getConversationMessages(
        conversationId,
      );
      for (final message in messages) {
        await localDataSource.cacheMessage(message);
      }
      return messages;
    }

    return localDataSource.getConversationMessages(conversationId);
  }

  Future<MessageModel> sendMessage(MessageModel message) async {
    if (await connectivityResult.isConnected()) {
      final sentMessage = await remoteDataSource.sendMessage(message);
      await localDataSource.sendMessage(sentMessage);
      return sentMessage;
    }

    await localDataSource.sendMessage(message);
    return message;
  }

  Future<void> deleteMessage(String messageId) async {
    if (await connectivityResult.isConnected()) {
      await remoteDataSource.deleteMessage(messageId);
    }

    await localDataSource.deleteMessage(messageId);
  }
}
