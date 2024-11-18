import 'dart:async';
import 'package:chat_app/bloc/auth/auth_bloc.dart';
import 'package:chat_app/bloc/locale/locale_cubit.dart';
import 'package:chat_app/bloc/user/user_bloc.dart';
import 'package:chat_app/database/services/shared_preference_service.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/page/splash_view.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/message/message_bloc.dart';
import 'bloc/message/message_event.dart';
import 'bloc/request/request_bloc.dart';
import 'bloc/request/request_event.dart';
import 'bloc/request_action/request_action_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(); // Đảm bảo Firebase đã được khởi tạo
//   log('Handling a background message: ${message.messageId}');
//   _showNotification(message);
// }

// Future<void> _showNotification(RemoteMessage message) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your_channel_id',
//     'your_channel_name',
//     channelDescription: 'your_channel_description',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     message.notification?.title ?? 'Default Title',
//     message.notification?.body ?? 'Default Body',
//     platformChannelSpecifics,
//     payload: message.data.toString(),
//   );
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.setLanguageCode("en");
  await SharedPreferencesService.init();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Thiết lập flutter_local_notifications
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');

  // const InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);

  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
              authRepository: AuthRepository(),
              appLocalizations: AppLocalizations.of(context)),
        ),
        BlocProvider(
          create: (context) => UserBloc(
              userRepository: UserRepository(),
              appLocalizations: AppLocalizations.of(context)),
        ),
        BlocProvider(
          create: (context) => LocaleCubit(), // Khởi tạo LocaleCubit
        ),
        BlocProvider<RequestBloc>(
          create: (context) => RequestBloc(AppLocalizations.of(context))
            ..add(RequestGetAllEvent()),
        ),
        BlocProvider<RequestActionBloc>(
          create: (context) => RequestActionBloc(AppLocalizations.of(context)),
        ),
        BlocProvider<MessageBloc>(
          create: (context) =>
              MessageBloc(appLocalizations: AppLocalizations.of(context))
                ..add(MessageGetAllEvent()),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(primaryColor: AppColors.primaryColor),
            supportedLocales: const [
              Locale('en'),
              Locale('vi'),
            ],
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
          );
        },
      ),
    );
  }
}
