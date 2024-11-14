import 'package:chat_app/bloc/message/message_event.dart';
import 'package:chat_app/bloc/message/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBloc extends Bloc<MessageEvent,MessageState>{
  MessageBloc() : super(MessageInitial()){
    // on<MessageGetAllEvent>(_onGetAllMessage);
  }


}