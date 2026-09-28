import 'package:instagram_clone/data_source/local_data_source.dart';
import 'package:instagram_clone/data_source/remote_data_source.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/converstion_member_model.dart';
import 'package:instagram_clone/models/domain/conversation_preview.dart';
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

  Future<List<ConversationPreviewModel>> getConversationPreviews(
    String currentUserId,
  ) async {
    if (await connectivityResult.isConnected()) {
      final previews = await remoteDataSource.getConversationPreviews(
        currentUserId,
      );
      for (final preview in previews) {
        await localDataSource.cacheConversation(preview.conversation);
        for (final participant in preview.participants) {
          await localDataSource.cacheUser(participant);
          await localDataSource.cacheConversationMember(
            ConversationMemberModel(
              conversationId: preview.conversation.id,
              userId: participant.id,
            ),
          );
        }
        final lastMessage = preview.lastMessage;
        if (lastMessage != null) {
          await localDataSource.cacheUser(lastMessage.sender);
          await localDataSource.cacheMessage(lastMessage.message);
        }
      }
      return previews;
    }

    return localDataSource.getConversationPreviews(currentUserId);
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
