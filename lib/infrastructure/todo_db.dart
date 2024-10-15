import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_firebase_ui_template/core/core.dart';
import 'package:todo_firebase_ui_template/domain/todo_model.dart';
import 'package:todo_firebase_ui_template/domain/user_model.dart';

Future<void> registerUser(UserModel user) async {
  final userAuth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.userEmail, password: user.userPassword);
  if (userAuth != null) {
    await addUser(userAuth.user!.uid, user);
  }
}

Future<void> addUser(String userId, UserModel user) async {
  final firestore =
      await FirebaseFirestore.instance; //firestore is a variable name
  await firestore.collection('user').doc(userId).set({
    'name': user.userName,
    'email': user.userEmail,
    'mobile': user.userMobile,
    'address': user.userAddress
  }); //collection is a table
}

Future<bool> checkLogin(UserModel user) async {
  bool flag = false;
  try {
    final userAuth = FirebaseAuth.instance;
    UserCredential userCredential = await userAuth.signInWithEmailAndPassword(
        //UserCredential is a class and userCredential is the variable
        email: user.userEmail,
        password: user.userPassword);
    if (userCredential.user != null) {
      flag = true;
      globalUserId = userCredential.user!
          .uid; //value of user uid seen is the site is stored to this globalUserId
    }
  } catch (_) {
    return Future.value(flag);
  }
  return Future.value(flag);
  /*final userAuth = FirebaseAuth.instance;
  UserCredential userCredential = await userAuth.signInWithEmailAndPassword(  //UserCredential is a class and userCredential is the variable
      email: user.userEmail, password: user.userPassword);*/
}

Future<String> getUserName(String userId) async {
  String userName = '';
  if (userId != null) {
    final userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        //checking if there is anything in documentSnapshot
        final userData = documentSnapshot
            .data(); //map from documentSnapshot stored ot userData
        userName = userData!['name'];
      }
    });
  }
  return Future.value(userName);
}

Future<void> loadDatabase() async {
  //print(globalUserId);
  final firebaseFirestore = FirebaseFirestore.instance
      .collection('tasks')
      .where('userId', isEqualTo: globalUserId)
      .get()
      .then((querySnapshot) {
    globalTodoList.clear();
    for (var doc in querySnapshot.docs) {
      TodoModel t = TodoModel(
          id: doc.id,
          todoName: doc['name'],
          userId: doc['userId'],
          todoStatus: doc['status']);
      globalTodoList.add(t);
      print(globalTodoList);
    }
  });
}

Future<void> addTask(TodoModel t) async {
  await FirebaseFirestore.instance.collection('tasks').add({
    'name': t.todoName,
    'status': t.todoStatus,
    'userId': globalUserId
  }).then((_) async {
    await loadDatabase();
  });
}

Future<void> deleteTask(String taskId) async {
  await FirebaseFirestore.instance
      .collection('tasks')
      .doc(taskId)
      .delete()
      .then((_) {
    loadDatabase();
  });
}
