import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';
import 'package:zetaton_task/contract/services/i_message_service.dart';
import 'package:zetaton_task/services/connection_service.dart';
import 'package:zetaton_task/services/firebase_service.dart';
import 'package:zetaton_task/services/message_service.dart';

List<SingleChildWidget> provider = [...independentProvider];
List<SingleChildWidget> independentProvider = [
  ListenableProvider<IConnectionService>(create: (_) => ConnectionService()),
  ListenableProvider<IMessageService>(create: (_) => MessageService()),
  ListenableProvider<IFirebaseService>(create: (_) => FirebaseService()),
];