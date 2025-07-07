// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart'
    as _i224;
import 'package:bloc_clean_architecture/src/common/blocs/indicator/bloc/indicator_bloc.dart'
    as _i257;
import 'package:bloc_clean_architecture/src/common/blocs/localization/bloc/localization_bloc.dart'
    as _i541;
import 'package:bloc_clean_architecture/src/common/blocs/network_manager/bloc/network_manager_bloc.dart'
    as _i738;
import 'package:bloc_clean_architecture/src/common/blocs/sqflite_manager/bloc/sqflite_manager_bloc.dart'
    as _i208;
import 'package:bloc_clean_architecture/src/common/encryption_manager/encrytion_manager.dart'
    as _i182;
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart'
    as _i890;
import 'package:bloc_clean_architecture/src/common/overlay_manager/overlay_manager.dart'
    as _i265;
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart'
    as _i833;
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart'
    as _i32;
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart'
    as _i152;
import 'package:bloc_clean_architecture/src/common/sqflite_manager/sqflite_manager.dart'
    as _i308;
import 'package:bloc_clean_architecture/src/common/theme/bloc/theme_bloc.dart'
    as _i564;
import 'package:bloc_clean_architecture/src/common/utils/contact_picker_helper/contact_picker_helper.dart'
    as _i327;
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/admin_order_detail_bottom_sheet/cubit/admin_order_detail_bottom_sheet_cubit.dart'
    as _i106;
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/order_detail_bottom_sheet/cubit/order_detail_bottom_sheet_cubit.dart'
    as _i965;
import 'package:bloc_clean_architecture/src/common/widgets/bottom_sheets/single_select_bottom_sheet/cubit/single_select_bottom_sheet_cubit.dart'
    as _i352;
import 'package:bloc_clean_architecture/src/data/data_source/local/auth/auth_local_ds.dart'
    as _i290;
import 'package:bloc_clean_architecture/src/data/data_source/local/localization/localization_local_ds.dart'
    as _i807;
import 'package:bloc_clean_architecture/src/data/data_source/local/splash/splash_local_ds.dart'
    as _i305;
import 'package:bloc_clean_architecture/src/data/data_source/remote/address_remote_ds.dart'
    as _i828;
import 'package:bloc_clean_architecture/src/data/data_source/remote/agreement_remote_ds.dart'
    as _i664;
import 'package:bloc_clean_architecture/src/data/data_source/remote/app_version/app_version_info_remote_ds.dart'
    as _i426;
import 'package:bloc_clean_architecture/src/data/data_source/remote/auth_remote_ds.dart'
    as _i321;
import 'package:bloc_clean_architecture/src/data/data_source/remote/cart_item_remote_ds.dart'
    as _i756;
import 'package:bloc_clean_architecture/src/data/data_source/remote/category_remote_ds.dart'
    as _i887;
import 'package:bloc_clean_architecture/src/data/data_source/remote/culture_remote_ds.dart'
    as _i618;
import 'package:bloc_clean_architecture/src/data/data_source/remote/file_remote_ds.dart'
    as _i43;
import 'package:bloc_clean_architecture/src/data/data_source/remote/order_remote_ds.dart'
    as _i912;
import 'package:bloc_clean_architecture/src/data/data_source/remote/payment_remote_ds.dart'
    as _i624;
import 'package:bloc_clean_architecture/src/data/data_source/remote/product_remote_ds.dart'
    as _i875;
import 'package:bloc_clean_architecture/src/data/data_source/remote/resource_remote_ds.dart'
    as _i119;
import 'package:bloc_clean_architecture/src/domain/address/address_repository.dart'
    as _i495;
import 'package:bloc_clean_architecture/src/domain/agreement/agreement_repository.dart'
    as _i1046;
import 'package:bloc_clean_architecture/src/domain/app_version/app_version_info_repository.dart'
    as _i404;
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart'
    as _i291;
import 'package:bloc_clean_architecture/src/domain/cart_item/cart_item_repository.dart'
    as _i66;
import 'package:bloc_clean_architecture/src/domain/category/category_repository.dart'
    as _i713;
import 'package:bloc_clean_architecture/src/domain/culture/culture_repository.dart'
    as _i290;
import 'package:bloc_clean_architecture/src/domain/file/file_repository.dart'
    as _i343;
import 'package:bloc_clean_architecture/src/domain/indicator/indicator_repository.dart'
    as _i752;
import 'package:bloc_clean_architecture/src/domain/localization/localization_repository.dart'
    as _i749;
import 'package:bloc_clean_architecture/src/domain/network_manager/network_manager_repository.dart'
    as _i978;
import 'package:bloc_clean_architecture/src/domain/order/order_repository.dart'
    as _i397;
import 'package:bloc_clean_architecture/src/domain/payment/payment_repository.dart'
    as _i846;
import 'package:bloc_clean_architecture/src/domain/product/product_repository.dart'
    as _i57;
import 'package:bloc_clean_architecture/src/domain/resource/resource_repository.dart'
    as _i260;
import 'package:bloc_clean_architecture/src/domain/splash/splash_repository.dart'
    as _i183;
import 'package:bloc_clean_architecture/src/domain/sqflite_manager/sqflite_manager_repository.dart'
    as _i316;
import 'package:bloc_clean_architecture/src/presentation/account/account/bloc/account_bloc.dart'
    as _i688;
import 'package:bloc_clean_architecture/src/presentation/account/address/address_detail/cubit/address_detail_cubit.dart'
    as _i991;
import 'package:bloc_clean_architecture/src/presentation/account/address/addresses/cubit/address_cubit.dart'
    as _i233;
import 'package:bloc_clean_architecture/src/presentation/account/admin/admin_operations/cubit/admin_operations_cubit.dart'
    as _i994;
import 'package:bloc_clean_architecture/src/presentation/account/admin/admin_orders/cubit/admin_orders_cubit.dart'
    as _i1016;
import 'package:bloc_clean_architecture/src/presentation/account/past_orders/cubit/past_orders_cubit.dart'
    as _i187;
import 'package:bloc_clean_architecture/src/presentation/account/settings/bloc/settings_bloc.dart'
    as _i1013;
import 'package:bloc_clean_architecture/src/presentation/account/update_password/cubit/update_password_cubit.dart'
    as _i1031;
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password/cubit/forgot_password_cubit.dart'
    as _i746;
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password_send_otp_code/cubit/forgot_password_send_otp_code_cubit.dart'
    as _i910;
import 'package:bloc_clean_architecture/src/presentation/auth/login/cubit/login_cubit.dart'
    as _i249;
import 'package:bloc_clean_architecture/src/presentation/auth/splash/bloc/splash_bloc.dart'
    as _i68;
import 'package:bloc_clean_architecture/src/presentation/bottom_navigation_bar/cubit/bottom_navigation_bar_cubit.dart'
    as _i205;
import 'package:bloc_clean_architecture/src/presentation/cart/cart/cubit/cart_cubit.dart'
    as _i47;
import 'package:bloc_clean_architecture/src/presentation/cart/order/cubit/order_cubit.dart'
    as _i286;
import 'package:bloc_clean_architecture/src/presentation/products/cubit/products_cubit.dart'
    as _i690;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i564.ThemeBloc>(() => _i564.ThemeBloc());
    gh.factory<_i352.SingleSelectBottomSheetCubit>(
        () => _i352.SingleSelectBottomSheetCubit());
    gh.factory<_i994.AdminOperationsCubit>(() => _i994.AdminOperationsCubit());
    gh.lazySingleton<_i308.SqfliteManager>(() => _i308.SqfliteManager());
    gh.lazySingleton<_i890.NetworkManager>(() => _i890.NetworkManager());
    gh.lazySingleton<_i182.EncrytionManager>(() => _i182.EncrytionManager());
    gh.lazySingleton<_i152.SharedPreferencesManager>(
        () => _i152.SharedPreferencesManager());
    gh.lazySingleton<_i316.ISqfliteManagerRepository>(
        () => _i316.SqfliteManagerRepository());
    gh.lazySingleton<_i807.ILocalizationLocalDS>(
        () => _i807.LocalizationLocalDS(gh<_i152.SharedPreferencesManager>()));
    gh.lazySingleton<_i426.IAppVersionInfoRemoteDS>(
        () => const _i426.AppVersionInfoRemoteDS());
    gh.lazySingleton<_i752.IIndicatorRepository>(
        () => _i752.IndicatorRepository());
    gh.lazySingleton<_i290.IAuthLocalDS>(
        () => _i290.AuthLocalDS(gh<_i152.SharedPreferencesManager>()));
    gh.lazySingleton<_i978.INetworkManagerRepository>(
        () => _i978.NetworkManagerRepository());
    gh.lazySingleton<_i260.IResourceRepository>(
        () => _i260.ResourceRepository(gh<_i119.ResourceRemoteDS>()));
    gh.lazySingleton<_i208.SqfliteManagerBloc>(
        () => _i208.SqfliteManagerBloc(gh<_i316.ISqfliteManagerRepository>()));
    gh.lazySingleton<_i32.IMyRouterService>(() => _i32.MyRouterService());
    gh.lazySingleton<_i305.ISplashLocalDS>(() => _i305.SplashLocalDS(
          gh<_i308.SqfliteManager>(),
          gh<_i152.SharedPreferencesManager>(),
        ));
    gh.lazySingleton<_i327.IContactPickerHelper>(
        () => _i327.ContactPickerHelper());
    gh.lazySingleton<_i290.ICultureRepository>(
        () => _i290.CultureRepository(gh<_i618.CultureRemoteDS>()));
    gh.lazySingleton<_i887.ICategoryRemoteDS>(
        () => _i887.CategoryRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i756.ICartItemRemoteDS>(
        () => _i756.CartItemRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i404.IAppVersionInfoRepository>(() =>
        _i404.AppVersionInfoRepository(gh<_i426.IAppVersionInfoRemoteDS>()));
    gh.lazySingleton<_i321.IAuthRemoteDS>(
        () => _i321.AuthRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i738.NetworkManagerBloc>(
        () => _i738.NetworkManagerBloc(gh<_i978.INetworkManagerRepository>()));
    gh.lazySingleton<_i624.IPaymentRemoteDS>(
        () => _i624.PaymentRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i66.ICartItemRepository>(
        () => _i66.CartItemRepository(gh<_i756.ICartItemRemoteDS>()));
    gh.lazySingleton<_i618.ICultureRemoteDS>(
        () => _i618.CultureRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i875.IProductRemoteDS>(
        () => _i875.ProductRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i119.IResourceRemoteDS>(
        () => _i119.ResourceRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i846.IPaymentRepository>(
        () => _i846.PaymentRepository(gh<_i624.IPaymentRemoteDS>()));
    gh.lazySingleton<_i912.IOrderRemoteDS>(
        () => _i912.OrderRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i43.IFileRemoteDS>(
        () => _i43.FileRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i664.IAgreementRemoteDS>(
        () => _i664.AgreementRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i183.ISplashRepository>(
        () => _i183.SplashRepository(gh<_i305.ISplashLocalDS>()));
    gh.lazySingleton<_i291.IAuthRepository>(() => _i291.AuthRepository(
          gh<_i321.IAuthRemoteDS>(),
          gh<_i290.IAuthLocalDS>(),
        ));
    gh.lazySingleton<_i828.IAddressRemoteDS>(
        () => _i828.AddressRemoteDS(gh<_i890.NetworkManager>()));
    gh.lazySingleton<_i343.IFileRepository>(
        () => _i343.FileRepository(gh<_i43.IFileRemoteDS>()));
    gh.lazySingleton<_i713.ICategoryRepository>(
        () => _i713.CategoryRepository(gh<_i887.ICategoryRemoteDS>()));
    gh.lazySingleton<_i265.IMyOverlayManager>(
        () => _i265.MyOverlayManager(gh<_i32.IMyRouterService>()));
    gh.lazySingleton<_i257.IndicatorBloc>(
        () => _i257.IndicatorBloc(gh<_i752.IIndicatorRepository>()));
    gh.factory<_i68.SplashBloc>(() => _i68.SplashBloc(
          gh<_i291.IAuthRepository>(),
          gh<_i183.ISplashRepository>(),
        ));
    gh.lazySingleton<_i495.IAddressRepository>(
        () => _i495.AddressRepository(gh<_i828.IAddressRemoteDS>()));
    gh.lazySingleton<_i833.IMyPopupManager>(
        () => _i833.MyPopupManager(gh<_i32.IMyRouterService>()));
    gh.factory<_i205.BottomNavigationBarCubit>(
        () => _i205.BottomNavigationBarCubit(gh<_i66.ICartItemRepository>()));
    gh.factory<_i47.CartCubit>(
        () => _i47.CartCubit(gh<_i66.ICartItemRepository>()));
    gh.lazySingleton<_i397.IOrderRepository>(
        () => _i397.OrderRepository(gh<_i912.IOrderRemoteDS>()));
    gh.factory<_i233.AddressCubit>(
        () => _i233.AddressCubit(gh<_i495.IAddressRepository>()));
    gh.lazySingleton<_i57.IProductRepository>(
        () => _i57.ProductRepository(gh<_i875.IProductRemoteDS>()));
    gh.lazySingleton<_i1046.IAgreementRepository>(
        () => _i1046.AgreementRepository(gh<_i664.IAgreementRemoteDS>()));
    gh.factory<_i286.OrderCubit>(() => _i286.OrderCubit(
          gh<_i397.IOrderRepository>(),
          gh<_i495.IAddressRepository>(),
          gh<_i66.ICartItemRepository>(),
          gh<_i32.IMyRouterService>(),
        ));
    gh.factory<_i991.AddressDetailCubit>(() => _i991.AddressDetailCubit(
          gh<_i495.IAddressRepository>(),
          gh<_i32.IMyRouterService>(),
        ));
    gh.lazySingleton<_i749.ILocalizationRepository>(
        () => _i749.LocalizationRepository(
              gh<_i807.ILocalizationLocalDS>(),
              gh<_i618.ICultureRemoteDS>(),
              gh<_i119.IResourceRemoteDS>(),
            ));
    gh.factory<_i746.ForgotPasswordCubit>(() => _i746.ForgotPasswordCubit(
          gh<_i291.IAuthRepository>(),
          gh<_i32.IMyRouterService>(),
        ));
    gh.factory<_i910.ForgotPasswordSendOtpCodeCubit>(
        () => _i910.ForgotPasswordSendOtpCodeCubit(
              gh<_i291.IAuthRepository>(),
              gh<_i32.IMyRouterService>(),
            ));
    gh.lazySingleton<_i224.AuthBloc>(
        () => _i224.AuthBloc(gh<_i291.IAuthRepository>()));
    gh.factory<_i688.AccountBloc>(
        () => _i688.AccountBloc(gh<_i291.IAuthRepository>()));
    gh.factory<_i1031.UpdatePasswordCubit>(
        () => _i1031.UpdatePasswordCubit(gh<_i291.IAuthRepository>()));
    gh.factory<_i249.LoginCubit>(() => _i249.LoginCubit(
          gh<_i291.IAuthRepository>(),
          gh<_i833.IMyPopupManager>(),
          gh<_i1046.IAgreementRepository>(),
        ));
    gh.factory<_i1013.SettingsBloc>(
        () => _i1013.SettingsBloc(gh<_i749.ILocalizationRepository>()));
    gh.lazySingleton<_i541.LocalizationBloc>(
        () => _i541.LocalizationBloc(gh<_i749.ILocalizationRepository>()));
    gh.factory<_i690.ProductsCubit>(() => _i690.ProductsCubit(
          gh<_i713.ICategoryRepository>(),
          gh<_i57.IProductRepository>(),
          gh<_i66.ICartItemRepository>(),
        ));
    gh.factory<_i965.OrderDetailBottomSheetCubit>(
        () => _i965.OrderDetailBottomSheetCubit(
              gh<_i397.IOrderRepository>(),
              gh<_i833.IMyPopupManager>(),
            ));
    gh.factory<_i1016.AdminOrdersCubit>(() => _i1016.AdminOrdersCubit(
          gh<_i397.IOrderRepository>(),
          gh<_i833.IMyPopupManager>(),
        ));
    gh.factory<_i187.PastOrdersCubit>(() => _i187.PastOrdersCubit(
          gh<_i397.IOrderRepository>(),
          gh<_i833.IMyPopupManager>(),
        ));
    gh.factory<_i106.AdminOrderDetailBottomSheetCubit>(
        () => _i106.AdminOrderDetailBottomSheetCubit(
              gh<_i397.IOrderRepository>(),
              gh<_i833.IMyPopupManager>(),
            ));
    return this;
  }
}
