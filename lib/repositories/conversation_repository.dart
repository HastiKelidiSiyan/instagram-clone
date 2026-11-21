import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/domain/direct_conversation_item.dart';
import 'package:instagram_clone/models/domain/message_with_sender.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class ConversationRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  final ConnectionAvailibility connectivityResult =
      ConnectionAvailibility();

  Future<List<DirectConversationItem>> getDirectConversationItems(
    String currentUserId,
  ) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getDirectConversationItems(
        currentUserId,
      );
    }

    return [];
  }

  Future<List<MessageWithSender>> getConversationMessages(
    String conversationId,
  ) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getConversationMessages(
        conversationId,
      );
    }

    return [];
  }
}