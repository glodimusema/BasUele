import 'package:bloc/bloc.dart';
import 'package:mob_enregistrement_manage/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mob_enregistrement_manage/Themes/themes.dart';


void main() {
  Bloc.observer=SimpleBlocDelegate();
  //BlocObserver.delegate = SimpleBlocDelegate();
  runApp(const AppStateContainer(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { 
    //ProjDoc.createFolder();
    return ScreenUtilInit(
      designSize: Size(361, 428),
      builder: (BuildContext context, Widget? child) {  
        return MaterialApp(
        title: 'Companies Register',
        theme: AppStateContainer.of(context).theme,
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      );
      },
      
    );
  }
}


class SimpleBlocDelegate extends BlocObserver {
  //  @override
  // void onCreate(BlocBase bloc) {
  //   super.onCreate(bloc);
  //   print('onCreate -- ${bloc.runtimeType}');
  // }

  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   super.onEvent(bloc, event);
  //   print('onEvent -- ${bloc.runtimeType}, $event');
  // }

  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   print('onChange -- ${bloc.runtimeType}, $change');
  // }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   print('onTransition -- ${bloc.runtimeType}, $transition');
  // }

  // @override
  // void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
  //   print('onError -- ${bloc.runtimeType}, $error');
  //   super.onError(bloc, error, stackTrace);
  // }

  // @override
  // void onClose(BlocBase bloc) {
  //   super.onClose(bloc);
  //   //print('onClose -- ${bloc.runtimeType}');
  // }
}
/// state is passed down with an inherited widget

class AppStateContainer extends StatefulWidget {
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const AppStateContainer({required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>())!
        .data;
  }
}

class _AppStateContainerState extends State<AppStateContainer> {
  final ThemeData _theme = Themes.getTheme(Themes.LIGHT_THEME_CODE);
  int themeCode = Themes.LIGHT_THEME_CODE;

  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //print(theme.accentColor);
    return _InheritedStateContainer(
      data: this,
      key: null,
      child: widget.child,
    );
  }

  ThemeData get theme => _theme;

  
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  const _InheritedStateContainer({
     Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}