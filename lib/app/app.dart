import 'package:billboard/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:billboard/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:billboard/ui/views/home/home_view.dart';
import 'package:billboard/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:billboard/services/fire_service.dart';
import 'package:billboard/services/sharedpref_service.dart';
import 'package:billboard/ui/views/login/login_view.dart';
import 'package:billboard/ui/views/sigin/sigin_view.dart';
import 'package:billboard/ui/views/otp/otp_view.dart';
import 'package:billboard/ui/views/signup/signup_view.dart';
import 'package:billboard/ui/views/otp/otp_view.dart';
import 'package:billboard/ui/views/addpic/addpic_view.dart';
import 'package:billboard/ui/views/addpass/addpass_view.dart';
import 'package:billboard/ui/views/billboardowner/billboardowner_view.dart';
import 'package:billboard/ui/views/uploadbillboard/uploadbillboard_view.dart';
import 'package:billboard/ui/views/booking/booking_view.dart';
import 'package:billboard/ui/views/orders/orders_view.dart';
import 'package:billboard/ui/views/wallet/wallet_view.dart';
import 'package:billboard/ui/views/wishlist/wishlist_view.dart';
import 'package:billboard/ui/views/chat/allchats/allchats_view.dart';
import 'package:billboard/ui/views/chat/chating/chating_view.dart';
import 'package:billboard/ui/views/admin/admin_view.dart';
import 'package:billboard/ui/views/reviews/reviews_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SiginView),
    MaterialRoute(page: OtpView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: OtpView),
    MaterialRoute(page: AddpicView),
    MaterialRoute(page: AddpassView),
    MaterialRoute(page: BillboardownerView),
    MaterialRoute(page: UploadbillboardView),
    MaterialRoute(page: BookingView),
    MaterialRoute(page: OrdersView),
    MaterialRoute(page: WalletView),
    MaterialRoute(page: WishlistView),
    MaterialRoute(page: AllchatsView),
    MaterialRoute(page: ChatingView),
    MaterialRoute(page: AdminView),
    MaterialRoute(page: ReviewsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FireService),
    LazySingleton(classType: SharedprefService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
