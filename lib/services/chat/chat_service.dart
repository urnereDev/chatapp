import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map(
        (doc) {
          final user = doc.data();
          return user;
        },
      ).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
    final currentUser = auth.currentUser;
    return firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .snapshots()
        .asyncMap(
      (snapshot) async {
        final blockedUserIds = snapshot.docs
            .map(
              (doc) => doc.id,
            )
            .toList();
        final usersSnapshot = await firestore.collection("Users").get();
        return usersSnapshot.docs
            .where(
              (doc) =>
                  doc.data()["email"] != currentUser.email &&
                  !blockedUserIds.contains(doc.id),
            )
            .map(
              (doc) => doc.data(),
            )
            .toList();
      },
    );
  }

  Future<void> sendMessage(String receiverId, message) async {
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = auth.currentUser;
    final report = {
      "reportedBy": currentUser!.uid,
      "messageId": messageId,
      "messageOwnerId": userId,
      "timestamp": FieldValue.serverTimestamp()
    };
    await firestore.collection("Reports").add(report);
  }

  Future<void> blockUser(String userId) async {
    final currentUser = auth.currentUser;
    await firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .doc(userId)
        .set({});
    notifyListeners();
  }

  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = auth.currentUser;
    await firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .doc(blockedUserId)
        .delete();
  }

  Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userId) {
    return firestore
        .collection("Users")
        .doc(userId)
        .collection("BlockedUsers")
        .snapshots()
        .asyncMap(
      (snapshot) async {
        final blockedUserIds = snapshot.docs
            .map(
              (doc) => doc.id,
            )
            .toList();
        final userDocs = await Future.wait(blockedUserIds.map(
          (id) => firestore.collection("Users").doc(id).get(),
        ));
        return userDocs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      },
    );
  }
}
