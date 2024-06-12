// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:billboard/ui/views/addpass/addpass_view.dart' as _i9;
import 'package:billboard/ui/views/addpic/addpic_view.dart' as _i8;
import 'package:billboard/ui/views/admin/admin_view.dart' as _i18;
import 'package:billboard/ui/views/billboardowner/billboardowner_view.dart'
    as _i10;
import 'package:billboard/ui/views/booking/booking_view.dart' as _i12;
import 'package:billboard/ui/views/chat/allchats/allchats_view.dart' as _i16;
import 'package:billboard/ui/views/chat/chating/chating_view.dart' as _i17;
import 'package:billboard/ui/views/home/home_view.dart' as _i2;
import 'package:billboard/ui/views/login/login_view.dart' as _i4;
import 'package:billboard/ui/views/orders/orders_view.dart' as _i13;
import 'package:billboard/ui/views/otp/otp_view.dart' as _i6;
import 'package:billboard/ui/views/reviews/reviews_view.dart' as _i19;
import 'package:billboard/ui/views/sigin/sigin_view.dart' as _i5;
import 'package:billboard/ui/views/signup/signup_view.dart' as _i7;
import 'package:billboard/ui/views/startup/startup_view.dart' as _i3;
import 'package:billboard/ui/views/uploadbillboard/uploadbillboard_view.dart'
    as _i11;
import 'package:billboard/ui/views/wallet/wallet_view.dart' as _i14;
import 'package:billboard/ui/views/wishlist/wishlist_view.dart' as _i15;
import 'package:flutter/material.dart' as _i20;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i21;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const loginView = '/login-view';

  static const siginView = '/sigin-view';

  static const otpView = '/otp-view';

  static const signupView = '/signup-view';

  static const addpicView = '/addpic-view';

  static const addpassView = '/addpass-view';

  static const billboardownerView = '/billboardowner-view';

  static const uploadbillboardView = '/uploadbillboard-view';

  static const bookingView = '/booking-view';

  static const ordersView = '/orders-view';

  static const walletView = '/wallet-view';

  static const wishlistView = '/wishlist-view';

  static const allchatsView = '/allchats-view';

  static const chatingView = '/chating-view';

  static const adminView = '/admin-view';

  static const reviewsView = '/reviews-view';

  static const all = <String>{
    homeView,
    startupView,
    loginView,
    siginView,
    otpView,
    signupView,
    addpicView,
    addpassView,
    billboardownerView,
    uploadbillboardView,
    bookingView,
    ordersView,
    walletView,
    wishlistView,
    allchatsView,
    chatingView,
    adminView,
    reviewsView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i4.LoginView,
    ),
    _i1.RouteDef(
      Routes.siginView,
      page: _i5.SiginView,
    ),
    _i1.RouteDef(
      Routes.otpView,
      page: _i6.OtpView,
    ),
    _i1.RouteDef(
      Routes.signupView,
      page: _i7.SignupView,
    ),
    _i1.RouteDef(
      Routes.otpView,
      page: _i6.OtpView,
    ),
    _i1.RouteDef(
      Routes.addpicView,
      page: _i8.AddpicView,
    ),
    _i1.RouteDef(
      Routes.addpassView,
      page: _i9.AddpassView,
    ),
    _i1.RouteDef(
      Routes.billboardownerView,
      page: _i10.BillboardownerView,
    ),
    _i1.RouteDef(
      Routes.uploadbillboardView,
      page: _i11.UploadbillboardView,
    ),
    _i1.RouteDef(
      Routes.bookingView,
      page: _i12.BookingView,
    ),
    _i1.RouteDef(
      Routes.ordersView,
      page: _i13.OrdersView,
    ),
    _i1.RouteDef(
      Routes.walletView,
      page: _i14.WalletView,
    ),
    _i1.RouteDef(
      Routes.wishlistView,
      page: _i15.WishlistView,
    ),
    _i1.RouteDef(
      Routes.allchatsView,
      page: _i16.AllchatsView,
    ),
    _i1.RouteDef(
      Routes.chatingView,
      page: _i17.ChatingView,
    ),
    _i1.RouteDef(
      Routes.adminView,
      page: _i18.AdminView,
    ),
    _i1.RouteDef(
      Routes.reviewsView,
      page: _i19.ReviewsView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.LoginView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginView(),
        settings: data,
      );
    },
    _i5.SiginView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SiginView(),
        settings: data,
      );
    },
    _i6.OtpView: (data) {
      final args = data.getArgs<OtpViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.OtpView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i7.SignupView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.SignupView(),
        settings: data,
      );
    },
    _i8.AddpicView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.AddpicView(),
        settings: data,
      );
    },
    _i9.AddpassView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.AddpassView(),
        settings: data,
      );
    },
    _i10.BillboardownerView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.BillboardownerView(),
        settings: data,
      );
    },
    _i11.UploadbillboardView: (data) {
      final args = data.getArgs<UploadbillboardViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.UploadbillboardView(
            key: args.key, data: args.data, update: args.update),
        settings: data,
      );
    },
    _i12.BookingView: (data) {
      final args = data.getArgs<BookingViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.BookingView(
            key: args.key, data: args.data, isadmin: args.isadmin),
        settings: data,
      );
    },
    _i13.OrdersView: (data) {
      final args = data.getArgs<OrdersViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.OrdersView(key: args.key, user: args.user),
        settings: data,
      );
    },
    _i14.WalletView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.WalletView(),
        settings: data,
      );
    },
    _i15.WishlistView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.WishlistView(),
        settings: data,
      );
    },
    _i16.AllchatsView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.AllchatsView(),
        settings: data,
      );
    },
    _i17.ChatingView: (data) {
      final args = data.getArgs<ChatingViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i17.ChatingView(key: args.key, id: args.id, did: args.did),
        settings: data,
      );
    },
    _i18.AdminView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.AdminView(),
        settings: data,
      );
    },
    _i19.ReviewsView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.ReviewsView(data: {},),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class OtpViewArguments {
  const OtpViewArguments({
    this.key,
    required this.id,
  });

  final _i20.Key? key;

  final String id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }

  @override
  bool operator ==(covariant OtpViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

class UploadbillboardViewArguments {
  const UploadbillboardViewArguments({
    this.key,
    required this.data,
    required this.update,
  });

  final _i20.Key? key;

  final Map<dynamic, dynamic> data;

  final bool update;

  @override
  String toString() {
    return '{"key": "$key", "data": "$data", "update": "$update"}';
  }

  @override
  bool operator ==(covariant UploadbillboardViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.data == data && other.update == update;
  }

  @override
  int get hashCode {
    return key.hashCode ^ data.hashCode ^ update.hashCode;
  }
}

class BookingViewArguments {
  const BookingViewArguments({
    this.key,
    required this.data,
    this.isadmin = false,
  });

  final _i20.Key? key;

  final Map<dynamic, dynamic> data;

  final bool isadmin;

  @override
  String toString() {
    return '{"key": "$key", "data": "$data", "isadmin": "$isadmin"}';
  }

  @override
  bool operator ==(covariant BookingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.data == data && other.isadmin == isadmin;
  }

  @override
  int get hashCode {
    return key.hashCode ^ data.hashCode ^ isadmin.hashCode;
  }
}

class OrdersViewArguments {
  const OrdersViewArguments({
    this.key,
    required this.user,
  });

  final _i20.Key? key;

  final bool user;

  @override
  String toString() {
    return '{"key": "$key", "user": "$user"}';
  }

  @override
  bool operator ==(covariant OrdersViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.user == user;
  }

  @override
  int get hashCode {
    return key.hashCode ^ user.hashCode;
  }
}

class ChatingViewArguments {
  const ChatingViewArguments({
    this.key,
    required this.id,
    required this.did,
  });

  final _i20.Key? key;

  final String id;

  final String did;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id", "did": "$did"}';
  }

  @override
  bool operator ==(covariant ChatingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id && other.did == did;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode ^ did.hashCode;
  }
}

extension NavigatorStateExtension on _i21.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSiginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.siginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOtpView({
    _i20.Key? key,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.otpView,
        arguments: OtpViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddpicView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addpicView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddpassView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addpassView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBillboardownerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.billboardownerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUploadbillboardView({
    _i20.Key? key,
    required Map<dynamic, dynamic> data,
    required bool update,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.uploadbillboardView,
        arguments:
            UploadbillboardViewArguments(key: key, data: data, update: update),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBookingView({
    _i20.Key? key,
    required Map<dynamic, dynamic> data,
    bool isadmin = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bookingView,
        arguments: BookingViewArguments(key: key, data: data, isadmin: isadmin),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrdersView({
    _i20.Key? key,
    required bool user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.ordersView,
        arguments: OrdersViewArguments(key: key, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWalletView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.walletView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWishlistView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.wishlistView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllchatsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allchatsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatingView({
    _i20.Key? key,
    required String id,
    required String did,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chatingView,
        arguments: ChatingViewArguments(key: key, id: id, did: did),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAdminView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.adminView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToReviewsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.reviewsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSiginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.siginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOtpView({
    _i20.Key? key,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.otpView,
        arguments: OtpViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddpicView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addpicView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddpassView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addpassView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBillboardownerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.billboardownerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUploadbillboardView({
    _i20.Key? key,
    required Map<dynamic, dynamic> data,
    required bool update,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.uploadbillboardView,
        arguments:
            UploadbillboardViewArguments(key: key, data: data, update: update),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBookingView({
    _i20.Key? key,
    required Map<dynamic, dynamic> data,
    bool isadmin = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bookingView,
        arguments: BookingViewArguments(key: key, data: data, isadmin: isadmin),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrdersView({
    _i20.Key? key,
    required bool user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.ordersView,
        arguments: OrdersViewArguments(key: key, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWalletView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.walletView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWishlistView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.wishlistView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllchatsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allchatsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatingView({
    _i20.Key? key,
    required String id,
    required String did,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chatingView,
        arguments: ChatingViewArguments(key: key, id: id, did: did),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAdminView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.adminView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithReviewsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.reviewsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
