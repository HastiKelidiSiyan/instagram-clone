import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/converstion_member_model.dart';
import 'package:instagram_clone/models/domain/direct_conversation_item.dart';
import 'package:instagram_clone/database/database.dart';
import 'package:instagram_clone/models/domain/message_with_sender.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class ConversationRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  // final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<MessageWithSender>> getConversationMessages(
    String conversationId,
  ) async {
    if (await connectivityResult.isConnected()) {
      return await remoteDataSource.getConversationMessages(conversationId);
    }

    return [];
  }
}
