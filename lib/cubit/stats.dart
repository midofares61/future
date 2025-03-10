abstract class AppStats {}

class AppInitialStats extends AppStats{}

class ChangeIndexState extends AppStats{}

class AppChangeBottomSheetState extends AppStats{}

class OnLoadingAddOrderState extends AppStats{}

class CreateOrderSuccessState extends AppStats{}

class CreateOrderErrorState extends AppStats{}

class DeleteOrderSuccessState extends AppStats{}

class DeleteGiftSuccessState extends AppStats{}

class RemoveParametersSuccessState extends AppStats{}

class OnLoadingGetOrderState extends AppStats{}

class GetOrderSuccessState extends AppStats{}

class GetOrderErrorState extends AppStats{}

class OnLoadingEditOrderState extends AppStats{}

class EditOrderSuccessState extends AppStats{}

class EditOrderErrorState extends AppStats{}

class OnLoadingAddMattressState extends AppStats{}

class CreateMattressSuccessState extends AppStats{}

class CreateMattressErrorState extends AppStats{}

class OnLoadingGetMattressState extends AppStats{}

class GetMattressSuccessState extends AppStats{}

class GetMattressErrorState extends AppStats{}

class OnLoadingAddMandobeState extends AppStats{}

class CreateMandobeSuccessState extends AppStats{}

class CreateMandobeErrorState extends AppStats{}

class OnLoadingUpdateMandobeState extends AppStats{}

class UpdateMandobeSuccessState extends AppStats{}

class UpdateMandobeErrorState extends AppStats{}

class OnLoadingDeleteMandobeState extends AppStats{}

class DeleteMandobeSuccessState extends AppStats{}

class DeleteMandobeErrorState extends AppStats{}

class OnLoadingGetMandobeState extends AppStats{}

class GetMandobeSuccessState extends AppStats{}

class GetMandobeErrorState extends AppStats{}

class OnLoadingAddCodeState extends AppStats{}

class CreateCodeSuccessState extends AppStats{}

class CreateCodeErrorState extends AppStats{}

class OnLoadingGetCodeState extends AppStats{}

class GetCodeSuccessState extends AppStats{}

class GetCodeErrorState extends AppStats{}

class OnLoadingAddMoneyState extends AppStats{}

class CreateMoneySuccessState extends AppStats{}

class CreateMoneyErrorState extends AppStats{}

class OnLoadingGetMoneyState extends AppStats{}

class GetMoneySuccessState extends AppStats{}

class GetMoneyErrorState extends AppStats{}


class OnLoadingAddGiftState extends AppStats{}

class CreateGiftSuccessState extends AppStats{}

class CreateGiftErrorState extends AppStats{}

class OnLoadingAddGiftPendingState extends AppStats{}

class CreateGiftPendingSuccessState extends AppStats{}

class CreateGiftPendingErrorState extends AppStats{}

class OnLoadingAddShippingPriceState extends AppStats{}

class CreateShippingPriceSuccessState extends AppStats{}

class CreateShippingPriceErrorState extends AppStats{}

class OnLoadingGetGiftState extends AppStats{}

class GetGiftSuccessState extends AppStats{}

class GetGiftErrorState extends AppStats{}

class OnLoadingGetGiftPendingState extends AppStats{}

class GetGiftPendingSuccessState extends AppStats{}

class GetGiftPendingErrorState extends AppStats{}

class OnLoadingGetShippingPriceState extends AppStats{}

class GetShippingPriceSuccessState extends AppStats{}

class GetShippingPriceErrorState extends AppStats{}


class OnLoadingAddEmployeeState extends AppStats{}

class CreateEmployeeSuccessState extends AppStats{}

class CreateEmployeeErrorState extends AppStats{}

class OnLoadingGetEmployeeState extends AppStats{}

class GetEmployeeSuccessState extends AppStats{}

class GetEmployeeErrorState extends AppStats{}

class OnLoadingAddSuppliersState extends AppStats{}

class CreateSuppliersSuccessState extends AppStats{}

class CreateSuppliersErrorState extends AppStats{}

class OnLoadingGetSuppliersState extends AppStats{}

class GetSuppliersSuccessState extends AppStats{}

class GetSuppliersErrorState extends AppStats{}

class DeleteSuppliersSuccessState extends AppStats{}
class ChangeSuppliersNameState extends AppStats{}

class OnLoadingAddSuppliersMoneyState extends AppStats{}

class CreateSuppliersMoneySuccessState extends AppStats{}

class CreateSuppliersMoneyErrorState extends AppStats{}

class OnLoadingUpdateSuppliersMoneyState extends AppStats{}

class UpdateSuppliersMoneySuccessState extends AppStats{}

class UpdateSuppliersMoneyErrorState extends AppStats{}

class OnLoadingDeleteSuppliersMoneyState extends AppStats{}

class DeleteSuppliersMoneySuccessState extends AppStats{}

class DeleteSuppliersMoneyErrorState extends AppStats{}

class OnLoadingGetSuppliersMoneyState extends AppStats{}

class GetSuppliersMoneySuccessState extends AppStats{}

class GetSuppliersMoneyErrorState extends AppStats{}

class OnLoadingGetOrderSuppliersState extends AppStats{}

class GetOrderSuppliersSuccessState extends AppStats{}

class GetOrderSuppliersErrorState extends AppStats{}

class GetAddToListState extends AppStats{}

class GetRemoveFromListState extends AppStats{}

class UpdateGiftSuccessState extends AppStats{}

class UpdateGiftAddSuccessState extends AppStats{}

class OnLoadingUpdateShippingPriceState extends AppStats{}
class UpdateShippingPriceSuccessState extends AppStats{}

class UpdateGiftErrorState extends AppStats{}

class UpdateGiftAddErrorState extends AppStats{}

class UpdateMattressSuccessState extends AppStats{}

class UpdateMattressErrorState extends AppStats{}


class OnLoadingGetDaysState extends AppStats{}

class GetDaysSuccessState extends AppStats{}

class GetDaysErrorState extends AppStats{}

class OnLoadingGetMonthsState extends AppStats{}

class GetMonthsSuccessState extends AppStats{}

class GetMonthsErrorState extends AppStats{}

class ChangeYearMandobeState extends AppStats{}

class ChangeMonthMandobeState extends AppStats{}

class ChangeStatusMandobeState extends AppStats{}

class GetFilterMandobeSuccessState extends AppStats{}

class GetMonthsMandobeSuccessState extends AppStats{}

class GetYearMandobeSuccessState extends AppStats{}

class GetStatusMandobeSuccessState extends AppStats{}

class GetDayMandobeSuccessState extends AppStats{}

class GetLastDayMandobeSuccessState extends AppStats{}

class GetFilterOrderCodeState extends AppStats{}

class ChangeYearCodeState extends AppStats{}

class ChangeMonthCodeState extends AppStats{}

class ChangeStatusCodeState extends AppStats{}

class ChangeStatusSellsState extends AppStats{}

class ChangeChooseCityState extends AppStats{}

class InitializeFilteredOrdersState extends AppStats{}

class ChangeFilteredOrdersChooseState extends AppStats{}

class ChangeLengthOrdersChooseState extends AppStats{}

class ChangeMenuState extends AppStats{}

class ChangeMonthValueState extends AppStats{}

class AddMandobeMoneyState extends AppStats{}

class RemoveMandobeMoneyState extends AppStats{}

class AddSelectedOrderState extends AppStats{}

class RemoveSelectedOrderState extends AppStats{}

class AddSelectedOrderAllState extends AppStats{}

class RemoveSelectedOrderAllState extends AppStats{}


class OnLoadingRemoveMandobeState extends AppStats{}

class RemoveMandobeSuccessState extends AppStats{}

class ChangeMessageStatusState extends AppStats{}

class SocialRegisterOnLoadingState extends AppStats{}

class SocialRegisterErrorState extends AppStats{
  final String error;
  SocialRegisterErrorState(this.error);
}
class SocialUserCreateSuccessState extends AppStats{
  final String uId;
  SocialUserCreateSuccessState(this.uId);
}
class SocialUserCreateErrorState extends AppStats{
  final String error;
  SocialUserCreateErrorState(this.error);
}

class SocialOnLoadingGetUserState extends AppStats{}

class SocialGetUserSuccessState extends AppStats{}

class SocialGetUserErrorState extends AppStats{}

class SocialOnLoadingUpdateUserState extends AppStats{}

class SocialUpdateUserSuccessState extends AppStats{}

class ShowAllState extends AppStats{}

class OnLoadingGetAllUsersState extends AppStats{}

class OnLoadingCreateUserState extends AppStats{}

class GetAllUsersSuccessState extends AppStats{}

class GetAllUsersErrorState extends AppStats{}

class UpdateOrderCodeSuccessState extends AppStats{}

class UpdateOrderCodeOnLoadingState extends AppStats{}

class GetOrderCodeSuccessState extends AppStats{}

class GetOrderCodeOnLoadingState extends AppStats{}

class OnLoadingGetMonthState extends AppStats{}

class GetMonthSuccessState extends AppStats{}

class GetMonthErrorState extends AppStats{}

class DeleteUserOnLoadingState extends AppStats{}

class DeleteUserSuccessState extends AppStats{}

class DeleteUserErrorState extends AppStats{}

class ChangeLocationState extends AppStats{}

class AddConsoleState extends AppStats{}

class PickImageSuccessful extends AppStats{}

class ImagePickedSuccessState extends AppStats{}

class ImagePickedErrorState extends AppStats{}

class OnLoadingCheckOut extends AppStats{}

class CheckOutSuccessful extends AppStats{}

class CheckOutSError extends AppStats{}

class OnLoadingAddRequest extends AppStats{}

class AddRequestSuccessful extends AppStats{}

class AddRequestSError extends AppStats{}

class OnLoadingGetRequest extends AppStats{}

class GetRequestSuccessful extends AppStats{}

class GetRequestSError extends AppStats{}

class OnLoadingGetRequestDelay extends AppStats{}

class GetRequestDelaySuccessful extends AppStats{}

class GetRequestDelaySError extends AppStats{}

class OnLoadingWhistlingAdmin extends AppStats{}

class WhistlingAdminSuccessful extends AppStats{}

class WhistlingAdminError extends AppStats{}

class OnLoadingRequestConfirm extends AppStats{}

class RequestConfirmSuccessful extends AppStats{}

class RequestConfirmError extends AppStats{}

class OnLoadingRequestRefuse extends AppStats{}

class RequestRefuseSuccessful extends AppStats{}

class RequestRefuseError extends AppStats{}