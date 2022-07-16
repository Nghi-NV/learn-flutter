import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learn_flutter/core/app_config/cubit/language_cubit.dart';
import 'package:learn_flutter/core/generated/l10n.dart';
import 'package:learn_flutter/di/inject_container.dart';
import 'package:learn_flutter/model_views/login/cubit/login_cubit.dart';
import 'package:learn_flutter/routes/routes.dart';

void main() async {
  await InjectContainer().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => sl(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => sl(),
        ),
      ],
      child:
          BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: Routes.routes.routeInformationParser,
          routerDelegate: Routes.routes.routerDelegate,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback: ((locale, supportedLocales) {
            if (supportedLocales
                .map((e) => e.languageCode)
                .contains(locale?.languageCode)) {
              return locale;
            }

            return const Locale('en', '');
          }),
          locale: Locale(state.language, ''),
        );
      }),
    );
  }
}
