import 'package:bookstore/core/bloc/bloc_proovider.dart';
import 'package:bookstore/core/route/app_route.dart';
import 'package:bookstore/features/splash/splash_page.dart';
import 'package:bookstore/generated/l10n.dart';
import 'package:bookstore/shared/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) {
        return  
        MultiBlocProvider(
          providers: appBlocProviders,
          child:
           MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: AppThemes.lightTheme,
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
            onGenerateRoute: AppRoute.generateRoute,
           ),
         );

      },
    );
  }
}
