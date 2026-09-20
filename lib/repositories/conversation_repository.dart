import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/converstion_member_model.dart';
import 'package:instagram_clone/models/domain/direct_conversation_item.dart';
import 'package:instagram_clone/database/database.dart';
import 'package:instagram_clone/services/connection_availability%20.dart';

class ConversationRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  final LocalDataSource localDataSource = LocalDataSource();
  final ConnectionAvailibility connectivityResult = ConnectionAvailibility();

  Future<List<ConversationModel>> getUserConversations(String userId) async {
    if (await connectivityResult.isConnected()) {
      final conversations = await remoteDataSource.getUserConversations(userId);
      for (final conversation in conversations) {
        await localDataSource.createConversation(conversation);
      }
      return conversations;
    }

    return localDataSource.getUserConversations(userId);
  }

  Future<List<DirectConversationItem>> getDirectConversationItems() async {
    final db = AppDatabase.instance;
    final users = await (db.select(db.users)).get();
    if (users.isEmpty) return [];

    final currentUserId = users.first.id;

    if (await connectivityResult.isConnected()) {
      final items = await remoteDataSource.getDirectConversationItems(
        currentUserId,
      );
      for (final item in items) {
        await localDataSource.cacheConversation(item.conversation);
        await localDataSource.cacheUser(item.otherParticipant);
        if (item.latestMessage != null)
          await localDataSource.cacheMessage(item.latestMessage!);
      }
      return items;
    }

    return localDataSource.getDirectConversationItems(currentUserId);
  }

  Future<List<ConversationMemberModel>> getConversationMembers(
    String conversationId,
  ) async {
    if (await connectivityResult.isConnected()) {
      return remoteDataSource.getConversationMembers(conversationId);
    }

    return localDataSource.getConversationMembers(conversationId);
  }

  Future<ConversationModel> createConversation(
    ConversationModel conversation,
  ) async {
    if (await connectivityResult.isConnected()) {
      final createdConversation = await remoteDataSource.createConversation(
        conversation,
      );
      await localDataSource.createConversation(createdConversation);
      return createdConversation;
    }

    await localDataSource.createConversation(conversation);
    return conversation;
  }

  Future<ConversationMemberModel> addConversationMember(
    ConversationMemberModel member,
  ) async {
    if (await connectivityResult.isConnected()) {
      final createdMember = await remoteDataSource.addConversationMember(
        member,
      );
      await localDataSource.addConversationMember(createdMember);
      return createdMember;
    }

    await localDataSource.addConversationMember(member);
    return member;
  }
}
