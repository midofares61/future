import 'dart:convert';
import 'package:future/model/request_model.dart';
import 'package:future/modules/accountant/accountant_screen.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/cubit/stats.dart';
import 'package:future/model/gift_model.dart';
import 'package:future/model/money_model.dart';
import 'package:future/modules/setting/setting_screen.dart';
import 'package:future/shared/constant/constant.dart';
import 'package:image_picker/image_picker.dart';
import '../model/code_commission_model.dart';
import '../model/combined_model.dart';
import '../model/employee_model.dart';
import '../model/gift_details_model.dart';
import '../model/itemCollectionModel.dart';
import '../model/location_model.dart';
import '../model/mandobe_model.dart';
import '../model/mandobe_money_model.dart';
import '../model/matress_model.dart';
import '../model/moneys_details_model.dart';
import '../model/order_code_model.dart';
import '../model/order_details_model.dart';
import '../model/order_model.dart';
import '../model/order_suppliers_model.dart';
import '../model/suppliers_model.dart';
import '../model/suppliers_money_models.dart';
import '../model/user_model.dart';
import '../modules/code/code_screen.dart';
import '../modules/locations/location_screen.dart';
import '../modules/mandobe/mandobe_screen.dart';
import '../modules/merchants/merchants_screen.dart';
import '../modules/my_balance/my_balance_screen.dart';
import '../modules/my_balance_admin/my_balance_admin_screen.dart';
import '../modules/orders/orders_screen.dart';
import '../modules/requsts/requests_screen.dart';
import '../modules/store/pending_store_screen.dart';
import '../modules/store/store_screen.dart';
import 'package:future/shared/widgets/sut_excel.dart'
    if (dart.library.html) 'package:future/shared/widgets/web_export.dart'
    if (dart.library.io) 'package:future/shared/widgets/non_web_export.dart';

class AppCubit extends Cubit<AppStats> {
  AppCubit() : super(AppInitialStats());

  static AppCubit get(context) => BlocProvider.of(context);
//######### Start Variable ########
  int currentIndex = 0;
  List<Widget> screen = [
    const OrderScreen(),
    const MandobeScreen(),
    const LocationScreen(),
    const StoreScreen(),
    const PendingStoreScreen(),
    const CodeScreen(),
    const MerchantsScreen(),
    const MyBalanceAdminScreen(),
    const MyBalanceScreen(),
    const AccountantScreen(),
    const RequestsScreen(),
    const SettingScreen()
  ];
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var phoneControllerTow = TextEditingController();
  var addressController = TextEditingController();
  var totalController = TextEditingController();
  var codeController = TextEditingController();
  var codeProductController = TextEditingController();
  var quantityController = TextEditingController(text: "1");
  var priceController = TextEditingController();
  var detailsController = TextEditingController();
  var locationController = TextEditingController();
  UserModel? mandobeValue;
  UserModel? codeValue;
  String labelAppBar = "الاوردرات";
  MattressModel? mattressValue;
  GiftModel? giftValue;
  GiftModel? orderSuppliersValue;
  String? cityValue;
  int cityPrice = 0;
  SuppliersModel? suppliersValue;
  bool menu = false;
  bool menuText = false;
  String? selectNameSuppliers;
  SuppliersModel? selectSuppliers;
  String? selectIdSuppliers;
  // List<String> shippingPrices = [
  //   'القاهرة',
  //   'الجيزة',
  //   'الإسكندرية',
  //   'البحيرة',
  //   'الساحل الشمالي',
  //   'الإسماعيلية',
  //   'السويس',
  //   'بورسعيد',
  //   'الشرقية',
  //   'الغربية',
  //   'المنوفية',
  //   'المنصورة',
  //   'الدقهلية',
  //   'دمياط',
  //   'بني سويف',
  //   'الفيوم',
  //   'المنيا',
  //   'أسيوط',
  //   'سوهاج',
  //   'قنا',
  //   'الغردقة',
  //   'مرسى مطروح',
  //   'الأقصر',
  //   'أسوان',
  // ];

  List<MattressModel> mattressList = [];
  List<OrderDetailsModel> giftList = [];
  List<String> uIdNames = [];
  List<OrderDetailsModel> orderSuppliersList = [];
  List<String> listStatus = [
    "مع شركة الشحن",
    "تم تسليم العميل",
    "مرتجع",
    "في المكتب",
    "مؤجل",
  ];
  List<String> listStatusOrder = [
    "مع شركة الشحن",
    "تم تسليم العميل",
    "مرتجع",
    "في المكتب",
    "مؤجل",
    "كل الاوردرات",
  ];
  String? monthValueMandobe = "${DateTime.now().month}";
  String? yearValueMandobe = "${DateTime.now().year}";
  int dayMandobe = DateTime.now().day;
  int? lastDayMandobe;
  bool dayStatus = false;
  bool showAll = false;
  String statusValueMandobe = "مع شركة الشحن";
  List<OrderModel>? filteredMandobeOrders;
  List<OrderModel>? filteredMandobeOrdersAcoountant;
  String? statusCodeValue = "تم تسليم العميل";
  String statusSellsValue = "unPaid";
  List<OrderModel>? filteredCodeOrders;
  String? monthValueCode = "${DateTime.now().month}";
  String? yearValueCode = "${DateTime.now().year}";
  String chooseCity = "القاهرة";
  String? chooseMandobe = "معتز سالم";
  String? chooseMandobeAccountant = "معتز سالم";
  List<OrderModel>? filteredOrdersChoose;
  int? lengthOrdersChoose;
  String? statusOrderFilter = "كل الاوردرات";
  List<MandobeMoneyModel> mandobeMoney = [];
  List<OrderModel> selectedOrder = [];
  String? monthValue = "${DateTime.now().month}";
  String? yearValue = "${DateTime.now().year}";
  int day = DateTime.now().day;
  int? lastDay;
  List<OrderModel>? filteredOrders;
  List<OrderModel>? filteredOrdersAccountant;
  List<String> uniqueMonth = [];
  List<String> uniqueYears = [];
  int total = 0;
  List<String> consoleLogs = [];
//######### End Variable ########

//######### Start Main Function ########
  void sumTotal() {
    total = giftList.fold(0, (sum, order) => sum + order.total!) + cityPrice;
  }

  void changeLocation(String value, int price) {
    cityValue = value;
    cityPrice = price;
    locationController.text=value;
    sumTotal();
    emit(ChangeLocationState());
  }

  void showAllChanges(bool show) {
    showAll = show;
    emit(ShowAllState());
  }

  void removeSelectedAll() {
    selectedOrder.clear();
    emit(RemoveSelectedOrderState());
  }

  void changeSelectedNameSuppliers({
    required String name,
    required String id,
    required SuppliersModel suppliers,
  }) {
    selectNameSuppliers = name;
    selectIdSuppliers = id;
    selectSuppliers = suppliers;
    getSuppliersMoney();
    getOrdersSuppliers(name: name);
    getCombinedOrder(name: name);
    emit(ChangeSuppliersNameState());
  }

  void changeMonthValue(String month) {
    monthValue = month;
    getfilteredOrders();
    changeFilteredOrdersChoose(city: chooseCity);
    emit(ChangeMonthValueState());
  }

  void changeMenu() {
    menu = !menu;
    changeMenuText(menu);
    emit(ChangeMenuState());
  }

  void changeMenuText(menul) {
    if (!menul) {
      menuText = menul;
      emit(ChangeMenuState());
    } else {
      Future.delayed(const Duration(milliseconds: 100)).whenComplete(() {
        menuText = menul;
        emit(ChangeMenuState());
      });
    }
  }

  void addSelectedOrder({
    required OrderModel order,
  }) {
    selectedOrder.add(order);
    emit(AddSelectedOrderState());
  }

  void removeSelectedOrder({
    required String id,
  }) {
    selectedOrder.removeWhere((order) => order.id == id);
    emit(RemoveSelectedOrderState());
  }

  void addSelectedOrderAll({
    required List<OrderModel> order,
  }) {
    selectedOrder.addAll(order);
    emit(AddSelectedOrderAllState());
  }

  void removeSelectedOrderAll({
    required List<OrderModel> order,
  }) {
    for (var item in order) {
      selectedOrder.removeWhere((order) => order.id == item.id);
    }
    emit(RemoveSelectedOrderAllState());
  }

  void addToList({
    required OrderDetailsModel orderDetailsModel,
  }) {
    giftList.add(orderDetailsModel);
    if(!uIdNames.contains(orderDetailsModel.uid)){
      uIdNames.add(orderDetailsModel.uid!);
    }
    print(uIdNames);
    sumTotal();
    emit(GetAddToListState());
  }

  void removeFromList({
    required int index,
    required List list,
  }) {
    list.removeAt(index);
    sumTotal();
    emit(GetRemoveFromListState());
  }

  void addToSuppliersList({
    required OrderDetailsModel orderDetailsModel,
  }) {
    orderSuppliersList.add(orderDetailsModel);
    emit(GetAddToListState());
  }

  void removeFromSuppliersList({
    required int index,
    required List list,
  }) {
    list.removeAt(index);
    emit(GetRemoveFromListState());
  }

  void getYear() {
    for (var order in orders!) {
      DateTime orderDate = DateTime.parse(order.dateTime!);
      String day = orderDate.year
          .toString(); // يمكنك استخدام weekday للحصول على اليوم كرقم
      if (!uniqueYears.contains(day)) {
        uniqueYears.add(day);
      }
    }
    // Check and add current month if not present
    DateTime now = DateTime.now();
    String currentYear = now.year.toString();
    if (!uniqueYears.contains(currentYear)) {
      uniqueYears.add(currentYear);
    }
  }

  void getMonth() {
    orders!.forEach((order) {
      DateTime orderDate = DateTime.parse(order.dateTime!);
      String month = orderDate.month.toString();
      if (!uniqueMonth.contains(month)) {
        uniqueMonth.add(month);
      }
    });

    // Check and add current month if not present
    DateTime now = DateTime.now();
    String currentMonth = now.month.toString();
    if (!uniqueMonth.contains(currentMonth)) {
      uniqueMonth.add(currentMonth);
    }
  }
//######### End Main Function ########

  //######### Start Order Function ########
  void changeStatusOrderFilter(status) {
    statusOrderFilter = status;
    getfilteredOrders();
    changeFilteredOrdersChoose(city: chooseCity);
    emit(ChangeStatusCodeState());
  }

  void updateNotesOrder({
    required String notes,
    required String id,
  }) async {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(id)
        .update({"notes": notes});
    // getOrders();
  }

  void initializeFilteredOrdersChoose() {
    filteredOrdersChoose = filteredOrders!;
    changeLengthOrdersChoose(lengthOrders: filteredOrdersChoose!.length);
    emit(InitializeFilteredOrdersState());
  }

  void changeChooseMandobeValue({required String mandobe}) {
    chooseMandobe = mandobe;
    emit(ChangeChooseCityState());
  }

  void changeChooseCityValue({required String city}) {
    chooseCity = city;
    emit(ChangeChooseCityState());
  }

  void changeFilteredOrdersChoose({required String city}) {
    Map<String, List<String>> cityGroups = {
      "القاهرة": ["القاهرة", "الجيزة"],
      "سويس بورسعيد": [
        "السويس",
        "بورسعيد",
        "الإسماعيلية",
        "المنوفية",
        "الشرقية"
      ],
      "اسكندرية والساحل": [
        "الإسكندرية",
        "البحيرة",
        "الساحل الشمالي",
        'مرسى مطروح'
      ],
      "غربيه ومنصوره ودمياط": ["دمياط", "المنصورة", "الغربية", 'الدقهلية'],
      "المنيا وبني سويف": ["المنيا", "بني سويف", 'الغردقة', 'الفيوم'],
      "الصعيد": ["أسوان", "الأقصر", "قنا", "سوهاج", "أسيوط"],
    };

    // فلترة الطلبات بناءً على المدينة
    if (cityGroups.containsKey(city)) {
      filteredOrdersChoose = filteredOrders!
          .where((order) => cityGroups[city]!.contains(order.city!.trim()))
          .toList();
      changeLengthOrdersChoose(lengthOrders: filteredOrdersChoose!.length);
      filteredOrdersChoose!.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
    }

    emit(ChangeFilteredOrdersChooseState());
  }

  void changeLengthOrdersChoose({required int? lengthOrders}) {
    lengthOrdersChoose = lengthOrders;
    emit(ChangeLengthOrdersChooseState());
  }

  void addOrder(
      {required String name,
      required String phone,
      required String phoneTow,
      required String address,
      required String city,
      required int priceCity,
      required String mandobeName,
      required String uIdMandobeName,
      required String code,
      required String uIdCode,
      required String total,
      required String dateTime,
      required List<OrderDetailsModel> orderDetails}) async {
    emit(OnLoadingAddOrderState());
    removeParameter();
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("orders");
    String newId = collectionRef.doc().id;
    OrderModel model = OrderModel(
        orderCode: orderCode.orderCode.toString()??"1",
        name: name,
        phone: phone,
        phoneTow: phoneTow,
        address: address,
        city: city,
        mandobeName: mandobeName,
        code: code,
        total: total,
        dateTime: dateTime,
        id: newId,
        details: orderDetails,
        status: "في المكتب",
        sells: false,
        mandobe: false,
        uIdNames: uIdNames,
        nameAdd: usermodel!.name!,
        uIdCode: uIdCode,
        uIdMandobeName:uIdMandobeName ,
        priceCity: priceCity,
        nameEdit: "");

    try {
      collectionRef.doc(newId).set(model.toMap()).then((value) {
        giftList.clear();
        cityValue = null;
        codeValue = null;
        this.total = 0;
        getGift();
        // getOrders();
        updateOrderCode(id: orderCode.id!);
        emit(CreateOrderSuccessState());
      });
    } catch (error) {
      emit(CreateOrderErrorState());
    }
  }

  void deleteOrder({required String id}) {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(id)
        .delete()
        .then((value) => emit(DeleteOrderSuccessState()));
    // getOrders()
  }

  void removeParameter() {
    nameController.text = "";
    phoneController.text = "";
    addressController.text = "";
    totalController.text = "";
    codeController.text = "";
    phoneControllerTow.text = "";
    mandobeValue = null;
    codeValue = null;
  }

  List<OrderModel>? orders;
  void getOrders() {
    emit(OnLoadingGetOrderState());

    DateTime startOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime endOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
            .subtract(const Duration(seconds: 1));

    String startOfMonthString = startOfMonth.toString();
    String endOfMonthString = endOfMonth.toString();

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, // تفعيل التخزين المؤقت
    );


    var query = FirebaseFirestore.instance
        .collection("orders")
        .orderBy("dateTime", descending: true);

    if (usermodel != null && usermodel!.type == "مسوق الكتروني") {
      query = query.where("code", isEqualTo: usermodel!.name);
    }

    if (usermodel != null && usermodel!.type == "شركة شحن") {
      query = query.where("mandobeName", isEqualTo: usermodel!.name);
    }

    if (usermodel != null && usermodel!.type == "تاجر") {
      query =  query.where("uIdNames", arrayContains:usermodel!.uId);
    }

    // جلب البيانات من التخزين المؤقت أولاً
    query.get(const GetOptions(source: Source.cache)).then((snapshot) {
      orders =
          snapshot.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
      getfilteredOrders();
      getfilteredOrdersAccountant();
      getYear();
      getMonth();

      if (filteredOrdersChoose == null) {
        initializeFilteredOrdersChoose();
      } else {
        changeFilteredOrdersChoose(city: chooseCity);
      }

      emit(GetOrderSuccessState());

      // البدء بالاستماع للتحديثات في حال توفر اتصال
      query.snapshots().listen((event) {
        orders =
            event.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();

        getfilteredOrders();
        getYear();
        getMonth();

        if (filteredOrdersChoose == null) {
          initializeFilteredOrdersChoose();
        } else {
          changeFilteredOrdersChoose(city: chooseCity);
        }

        emit(GetOrderSuccessState());
      });
    }).catchError((error) {
      // التعامل مع الخطأ في حال عدم توفر البيانات في التخزين المؤقت
      emit(GetOrderErrorState());
    });
  }

  void editOrder({
    required String id,
    required String name,
    required String phone,
    required String phoneTow,
    required String address,
    required String city,
    required String mandobeName,
    required String code,
    required String total,
    required String dateTime,
    required List<OrderDetailsModel> giftList,
  }) {
    emit(OnLoadingEditOrderState());
    List<Map<String, dynamic>> listOfMaps =
        giftList.map((orderDetails) => orderDetails.toMap()).toList();
    FirebaseFirestore.instance.collection("orders").doc(id).update({
      "name": name,
      "phone": phone,
      "address": address,
      "city": city,
      "mandobeName": mandobeName,
      "code": code,
      "total": total,
      "dateTime": dateTime,
      "id": id,
      "phoneTow": phoneTow,
      "details": listOfMaps
    }).then((value) {
      // getOrders();
      emit(EditOrderSuccessState());
    }).catchError((error) {
      emit(EditOrderErrorState());
    });
  }

  void updateStatus({
    required String lastStatus,
    required String status,
    required String id,
    required List<OrderDetailsModel> list,
    required OrderModel order,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    // تحديث حالة الطلب
    batch.update(firestore.collection("orders").doc(id), {"status": status});

    // تحديث المخزون
    void updateProductStock(int multiplier) {
      for (var gift in list) {
        batch.update(firestore.collection("product").doc(gift.id), {
          'count': FieldValue.increment(gift.count! * multiplier)
        });
      }
    }

    // تحديث رصيد المستخدمين
    void updateUserBalances(int multiplier) {
      for (var gift in list) {
        var totalTager = gift.tagerPrice! * gift.count! * multiplier;
        var totalSells = (gift.price! - gift.oldPrice!) * gift.count! * multiplier;
        var totalAdmin = (gift.oldPrice! - gift.tagerPrice!) * gift.count! * multiplier;

        batch.update(firestore.collection("users").doc(gift.uid), {
          'total_balance': FieldValue.increment(totalTager)
        });
        batch.update(firestore.collection("users").doc(order.uIdCode), {
          'total_balance': FieldValue.increment(totalSells)
        });
        batch.update(firestore.collection("userAdmin").doc(usersAdmin[0].uId), {
          'total_balance': FieldValue.increment(totalAdmin)
        });
      }
      batch.update(firestore.collection("users").doc(order.uIdMandobeName), {
        'total_balance': FieldValue.increment(order.priceCity! * multiplier)
      });
    }

    // معالجة التغيرات حسب الحالة
    if (lastStatus == "مع شركة الشحن") {
      if (status == "مرتجع" || status == "في المكتب") {
        updateProductStock(1);
      } else if (status == "تم تسليم العميل") {
        updateUserBalances(1);
      }
    } else if (lastStatus == "مرتجع") {
      if (status == "مع شركة الشحن" || status == "تم تسليم العميل"||status == "مؤجل") {
        updateProductStock(-1);
        if (status == "تم تسليم العميل")  updateUserBalances(1);
      }
    } else if (lastStatus == "تم تسليم العميل") {
      if (status == "مع شركة الشحن" || status == "مرتجع"|| status == "في المكتب"||status == "مؤجل") {
        updateUserBalances(-1);
        if (status == "مرتجع"|| status == "في المكتب") updateProductStock(1);
      }
    } else if (lastStatus == "في المكتب") {
      if (status == "مع شركة الشحن"||status == "مؤجل") {
        updateProductStock(-1);
      } else if (status == "تم تسليم العميل") {
        updateProductStock(-1);
        updateUserBalances(1);
      }else if (lastStatus == "مؤجل") {
        if (status == "مرتجع" || status == "في المكتب") {
          updateProductStock(1);
        } else if (status == "تم تسليم العميل") {
          updateUserBalances(1);
        }
      }
    }

    // تنفيذ التحديثات دفعة واحدة
    try {
      await batch.commit();
    } catch (error) {
      emit(CreateOrderErrorState());
    }
  }


  void getfilteredOrders() {
    bool isDelay = statusOrderFilter == "كل الاوردرات";
    if (isDelay) {
      filteredOrders = orders!;
    } else {
      filteredOrders = orders!.where((order) {
        DateTime orderDate = DateTime.parse(order.dateTime!);
        bool matchesStatus = order.status == statusOrderFilter;
        bool matchesYear = orderDate.year == int.parse(yearValue!);
        bool matchesMonth = orderDate.month == int.parse(monthValue!);

        // if (isDelay) {
        //   return matchesMonth && matchesYear;
        // }

        return matchesStatus && matchesMonth && matchesYear;
      }).toList();
    }
  }

  void getfilteredOrdersAccountant() {
    filteredOrdersAccountant = orders!.where((order) {
      bool matchesStatus = order.status == "تم تسليم العميل";

      return matchesStatus;
    }).toList();
  }

  //######### End Order Function ########
//######### Start Mandobe Function ########
  void addMandobeMoney({required String name, required int money}) {
    mandobeMoney.add(MandobeMoneyModel(name: name, money: money));
    emit(AddMandobeMoneyState());
  }

  void removeMandobeMoney({
    required String name,
  }) {
    mandobeMoney.removeWhere((order) => order.name == name);
    emit(RemoveMandobeMoneyState());
  }

  void changeChooseMandobeAccountantValue({required String mandobe}) {
    chooseMandobeAccountant = mandobe;
    emit(ChangeChooseCityState());
  }

  void getFilteredMandobeOrdersAccountant({required String name}) {
    filteredMandobeOrdersAcoountant = orders!.where((order) {
      DateTime orderDate = DateTime.parse(order.dateTime!);
      return order.status == "تم تسليم العميل" &&
          orderDate.month == int.parse(monthValueMandobe!) &&
          order.mandobe == false &&
          orderDate.year == int.parse(yearValueMandobe!) &&
          order.mandobeName == name;
    }).toList();
    emit(GetFilterMandobeSuccessState());
  }

  void getFilteredMandobeOrders({required String name}) {
    filteredMandobeOrders = orders!.where((order) {
      DateTime orderDate = DateTime.parse(order.dateTime!);
      return order.status == statusValueMandobe &&
          orderDate.month == int.parse(monthValueMandobe!) &&
          orderDate.year == int.parse(yearValueMandobe!) &&
          order.mandobeName == name;
      // &&order.status == statusValue
    }).toList();
    getDayMandobe();
    emit(GetFilterMandobeSuccessState());
  }

  void getLastDayMandobe() {
    DateTime firstDayOfNextMonth = DateTime(
        int.parse(yearValueMandobe!), int.parse(monthValueMandobe!) + 1, 1);
    DateTime lastDayOfCurrentMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1));
    lastDayMandobe = lastDayOfCurrentMonth.day;
    emit(GetLastDayMandobeSuccessState());
  }

  List<String> uniqueYearsMandobe = [];
  void getYearMandobe() {
    for (var order in orders!) {
      DateTime orderDate = DateTime.parse(order.dateTime!);
      String day = orderDate.year
          .toString(); // يمكنك استخدام weekday للحصول على اليوم كرقم
      if (!uniqueYearsMandobe.contains(day)) {
        uniqueYearsMandobe.add(day);
      }
    }

    // Check and add current month if not present
    DateTime now = DateTime.now();
    String currentYear = now.year.toString();
    if (!uniqueYearsMandobe.contains(currentYear)) {
      uniqueYearsMandobe.add(currentYear);
    }
    emit(GetYearMandobeSuccessState());
  }

  void changeYearMandobe(value, name) {
    yearValueMandobe = value!;
    getFilteredMandobeOrders(name: name);
    emit(ChangeYearMandobeState());
  }

  void changeMonthMandobe(value, name) {
    monthValueMandobe = value!;
    getFilteredMandobeOrders(name: name);
    dayMandobe = 1;
    emit(ChangeMonthMandobeState());
  }

  void changeStatusMandobe(value, name) {
    statusValueMandobe = value!;
    getFilteredMandobeOrders(name: name);
    emit(ChangeStatusMandobeState());
  }

  List<String> uniqueMonthMandobe = [];

  void getMonthMandobe() {
    for (var order in orders!) {
      DateTime orderDate = DateTime.parse(order.dateTime!);
      String month = orderDate.month.toString();
      if (!uniqueMonthMandobe.contains(month)) {
        uniqueMonthMandobe.add(month);
      }
    }

    // Check and add current month if not present
    DateTime now = DateTime.now();
    String currentMonth = now.month.toString();
    if (!uniqueMonthMandobe.contains(currentMonth)) {
      uniqueMonthMandobe.add(currentMonth);
    }
    emit(GetMonthsMandobeSuccessState());
  }

  List<String> uniqueDayMandobe = [];

  void getDayMandobe() {
    uniqueDayMandobe = [];
    for (var order in filteredMandobeOrders!) {
      DateTime orderDate = DateTime.parse(order.dateTime!);
      String day = orderDate.day.toString();
      if (!uniqueDayMandobe.contains(day)) {
        uniqueDayMandobe.add(day);
      }
      emit(GetDayMandobeSuccessState());
    }
  }

  void updateStatusMandobe({
    required String lastStatus,
    required String status,
    required String id,
    required List<OrderDetailsModel> list,
    required String name,
  }) async {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(id)
        .update({"status": status}).whenComplete(() {
      getFilteredMandobeOrders(name: name);
      emit(ChangeStatusMandobeState());
    });
    if (lastStatus == "مع شركة الشحن") {
      if (status == "مع شركة الشحن") {
      } else if (status == "مرتجع") {
        if (list.isNotEmpty) {
          for (var gift in list) {
            try {
              await FirebaseFirestore.instance
                  .collection("product")
                  .doc(gift.id)
                  .update({'count': FieldValue.increment(gift.count!)});
            } catch (error) {
              emit(CreateOrderErrorState());
              return;
            }
          }
        }
        getFilteredMandobeOrders(name: name);
        emit(ChangeStatusMandobeState());
      } else if (status == "تم تسليم العميل") {
      } else if (status == "في المكتب") {
        if (list.isNotEmpty) {
          for (var gift in list) {
            try {
              await FirebaseFirestore.instance
                  .collection("product")
                  .doc(gift.id)
                  .update({'count': FieldValue.increment(gift.count!)});
            } catch (error) {
              emit(CreateOrderErrorState());
              return;
            }
          }
        }
        getFilteredMandobeOrders(name: name);
        emit(ChangeStatusMandobeState());
      }
    } else if (lastStatus == "مرتجع") {
      if (status == "مع شركة الشحن") {
        if (list.isNotEmpty) {
          for (var gift in list) {
            try {
              await FirebaseFirestore.instance
                  .collection("product")
                  .doc(gift.id)
                  .update({'count': FieldValue.increment(-gift.count!)});
            } catch (error) {
              emit(CreateOrderErrorState());
              return;
            }

            getFilteredMandobeOrders(name: name);
            emit(ChangeStatusMandobeState());
          }
        }
      } else if (status == "مرتجع") {
      } else if (status == "تم تسليم العميل") {
        if (list.isNotEmpty) {
          for (var gift in list) {
            try {
              await FirebaseFirestore.instance
                  .collection("product")
                  .doc(gift.id)
                  .update({'count': FieldValue.increment(-gift.count!)});
            } catch (error) {
              emit(CreateOrderErrorState());
              return;
            }

            getFilteredMandobeOrders(name: name);
            emit(ChangeStatusMandobeState());
          }
        }
      } else if (status == "في المكتب") {}
    } else if (lastStatus == "تم تسليم العميل") {
      if (status == "مع شركة الشحن") {
      } else if (status == "مرتجع") {
        if (list.isNotEmpty) {
          for (var gift in list) {
            try {
              await FirebaseFirestore.instance
                  .collection("product")
                  .doc(gift.id)
                  .update({'count': FieldValue.increment(gift.count!)});
            } catch (error) {
              emit(CreateOrderErrorState());
              return;
            }
          }
        }
        getFilteredMandobeOrders(name: name);
        emit(ChangeStatusMandobeState());
      } else if (status == "تم تسليم العميل") {
      } else if (status == "في المكتب") {
        if (list.isNotEmpty) {
          for (var gift in list) {
            try {
              await FirebaseFirestore.instance
                  .collection("product")
                  .doc(gift.id)
                  .update({'count': FieldValue.increment(gift.count!)});
            } catch (error) {
              emit(CreateOrderErrorState());
              return;
            }
          }
        }
        getFilteredMandobeOrders(name: name);
        emit(ChangeStatusMandobeState());
      }
    } else if (lastStatus == "في المكتب") {
      if (status == "مع شركة الشحن") {
        if (list.isNotEmpty) {
          for (var gift in list) {
            try {
              await FirebaseFirestore.instance
                  .collection("product")
                  .doc(gift.id)
                  .update({'count': FieldValue.increment(-gift.count!)});
            } catch (error) {
              emit(CreateOrderErrorState());
              return;
            }

            getFilteredMandobeOrders(name: name);
            emit(ChangeStatusMandobeState());
          }
        }
      } else if (status == "مرتجع") {
      } else if (status == "تم تسليم العميل") {
        if (list.isNotEmpty) {
          for (var gift in list) {
            try {
              await FirebaseFirestore.instance
                  .collection("product")
                  .doc(gift.id)
                  .update({'count': FieldValue.increment(-gift.count!)});
            } catch (error) {
              emit(CreateOrderErrorState());
              return;
            }

            getFilteredMandobeOrders(name: name);
            emit(ChangeStatusMandobeState());
          }
        }
      } else if (status == "في المكتب") {}
    }
  }

  void updateMandobeOrder(
      {required String mandobe,
      required String lastMandobe,
      required String lastStatus,
      required String id,
        required OrderModel order,
      required List<OrderDetailsModel> list}) async {
    if (lastMandobe == "") {
      FirebaseFirestore.instance.collection("orders").doc(id).update(
          {"mandobeName": mandobe, "dateTime": DateTime.now().toString()});
      updateStatus(
          lastStatus: lastStatus, status: "مع شركة الشحن", id: id, list: list, order: order);
    } else {
      FirebaseFirestore.instance
          .collection("orders")
          .doc(id)
          .update({"mandobeName": mandobe});
    }
  }

  void removeMandobeOrder({
    required String mandobe,
    required String id,
  }) async {
    emit(OnLoadingRemoveMandobeState());
    FirebaseFirestore.instance.collection("orders").doc(id).update(
        {"mandobeName": mandobe, "dateTime": DateTime.now().toString()});
    emit(RemoveMandobeSuccessState());
  }

  void addMandobe({
    required String name,
    required String phone,
  }) {
    emit(OnLoadingAddMandobeState());
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("mandobe");
    String newId = collectionRef.doc().id;
    MandobeModel model =
        MandobeModel(name: name, phone: phone, count: 0, id: newId);

    collectionRef.doc(newId).set(model.toMap()).then((value) {
      getMandobe();
      emit(CreateMandobeSuccessState());
    }).catchError((error) {
      emit(CreateMandobeErrorState());
    });
  }

  void updateMandobe({
    required String name,
    required String phone,
    required String id,
    required String collection,
  }) {
    emit(OnLoadingUpdateMandobeState());
    FirebaseFirestore.instance.collection(collection)
      ..doc(id).update({
        "name": name,
        "phone": phone,
      }).then((value) {
        getMandobe();
        emit(UpdateMandobeSuccessState());
      }).catchError((error) {
        emit(UpdateMandobeErrorState());
      });
  }

  void deleteMandobe({
    required String id,
    required String collection,
  }) {
    emit(OnLoadingDeleteMandobeState());
    FirebaseFirestore.instance.collection(collection)
      ..doc(id).delete().then((value) {
        getMandobe();
        emit(DeleteMandobeSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(DeleteMandobeErrorState());
      });
  }

  List<UserModel>? mandobe;
  List<UserModel>? merchants;
  void getMandobe() {
    emit(OnLoadingGetMandobeState());
    FirebaseFirestore.instance
        .collection("mandobe")
        .snapshots()
        .listen((event) {
      mandobe = [];
      for (var element in event.docs) {
        mandobe!.add(UserModel.fromJson(element.data()));
      }

      emit(GetMandobeSuccessState());
    });
  }

//######### End Mandobe Function ########
//######### Start Store Function ########
  int codeProduct = 1;
  void addGift({
    required String name,
    required String notes,
    required String image,
    required String link,
    required String price,
    required String price2,
    required int count,
    required String uid,
    required String nameAdd,
    required String type,
  }) {
    emit(OnLoadingAddGiftState());
    late CollectionReference collectionRef;
    if (type == "تاجر") {
      collectionRef = FirebaseFirestore.instance.collection("pending_products");
    } else {
      collectionRef = FirebaseFirestore.instance.collection("product");
    }

    String newId = collectionRef.doc().id;
    GiftModel model = GiftModel(
      name: name,
      count: count,
      notes: notes,
      image: image,
      price: price,
      price2: price2,
      link: link,
      id:  newId,
      code: codeProduct,
      nameAdd: nameAdd,
      uid: uid,
      edit: "",
    );

    collectionRef.doc(newId).set(model.toMap()).then((value) {
      getGift();
      getPendingGift();
      emit(CreateGiftSuccessState());
    }).catchError((error) {
      emit(CreateGiftErrorState());
    });
  }

  void addGiftPending({
    required String name,
    required String notes,
    required String image,
    required String link,
    required String price,
    required String price2,
    required int count,
    required String uid,
    required String id,
    required int code,
    required String nameAdd,
    required String type,
  }) {
    emit(OnLoadingAddGiftPendingState());
    late CollectionReference collectionRef= FirebaseFirestore.instance.collection("pending_products");
    late CollectionReference collectionRef2= FirebaseFirestore.instance.collection("product");

    GiftModel model = GiftModel(
      name: name,
      count: count,
      notes: notes,
      image: image,
      price: price,
      price2: price2,
      link: link,
      id: id ,
      code: code,
      nameAdd: nameAdd,
      uid: uid,
      edit: "",
    );

    collectionRef2.doc(id).set(model.toMap()).then((value) {
      collectionRef.doc(id).delete().then((value){
        getGift();
        getPendingGift();
        emit(CreateGiftPendingSuccessState());
      });

    }).catchError((error) {
      emit(CreateGiftPendingErrorState());
    });
  }

  List<GiftModel>? gift;
  void getGift() {
    emit(OnLoadingGetGiftState());

    var query =
        FirebaseFirestore.instance.collection("product").orderBy("code");

    if (usermodel != null && usermodel!.type == "تاجر") {
      query = query.where("uid", isEqualTo: usermodel!.uId);
    }

    // جلب البيانات من التخزين المؤقت أولاً
    query.get(const GetOptions(source: Source.cache)).then((snapshot) {
      gift =
          snapshot.docs.map((doc) => GiftModel.fromJson(doc.data())).toList();
      gift!.sort((a, b) => b.code!.compareTo(a.code!));
      codeProduct = snapshot.docs.length + 1;

      emit(GetGiftSuccessState());

      // البدء بالاستماع للتحديثات في حال توفر اتصال
      query.snapshots().listen((event) {
        gift = event.docs.map((doc) => GiftModel.fromJson(doc.data())).toList();
        gift!.sort((a, b) => b.code!.compareTo(a.code!));
        codeProduct = event.docs.length + 1;
        emit(GetGiftSuccessState());
      });
    }).catchError((error) {
      emit(GetOrderErrorState());
    });
  }

  List<GiftModel>? pendingGift;
  void getPendingGift() {
    emit(OnLoadingGetGiftPendingState());
    if (usermodel != null && usermodel!.type == "تاجر") {
      FirebaseFirestore.instance
          .collection("pending_products")
          .where("uid", isEqualTo: usermodel!.uId)
          .snapshots()
          .listen((event) {
        pendingGift = [];
        for (var element in event.docs) {
          pendingGift!.add(GiftModel.fromJson(element.data()));
        }
      });
    }else{
      FirebaseFirestore.instance
          .collection("pending_products")
          .snapshots()
          .listen((event) {
        pendingGift = [];
        for (var element in event.docs) {
          pendingGift!.add(GiftModel.fromJson(element.data()));
        }
      });
    }
  }

  void updateGiftProduct({
    required String id,
    required String name,
    required int count,
  }) {
    FirebaseFirestore.instance
        .collection("product")
        .doc(id)
        .update({'name': name, "count": count}).then((value) => getGift());
    emit(UpdateGiftSuccessState());
  }

  void deleteGift({required String id}) {
    FirebaseFirestore.instance
        .collection("product")
        .doc(id)
        .delete()
        .then((value) => getGift());
    emit(DeleteGiftSuccessState());
  }
  void deleteGiftPending({required String id}) {
    FirebaseFirestore.instance
        .collection("pending_products")
        .doc(id)
        .delete()
        .then((value) => getPendingGift());
    emit(DeleteGiftSuccessState());
  }

  void addShipping({
    required String name,
    required int price,
  }) {
    emit(OnLoadingAddShippingPriceState());
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("shipping");
    String newId = collectionRef.doc().id;
    ShippingPrice model =
        ShippingPrice(governorate: name, price: price, id: newId);

    collectionRef.doc(newId).set(model.toMap()).then((value) {
      getShippingPrice();
      emit(CreateShippingPriceSuccessState());
    }).catchError((error) {
      emit(CreateShippingPriceErrorState());
    });
  }

  List<ShippingPrice>? shippingPrice;
  void getShippingPrice() {
    emit(OnLoadingGetShippingPriceState());
    FirebaseFirestore.instance
        .collection("shipping")
        .snapshots()
        .listen((event) {
      shippingPrice = [];
      for (var element in event.docs) {
        shippingPrice!.add(ShippingPrice.fromJson(element.data()));
      }
      emit(GetShippingPriceSuccessState());
    });
  }

  void updateShippingPrice({
    required String id,
    required String governorate,
    required int price,
  }) {
    emit(OnLoadingUpdateShippingPriceState());
    FirebaseFirestore.instance
        .collection("shipping")
        .doc(id)
        .update({'governorate': governorate, "price": price}).then(
            (value) => getGift());
    emit(UpdateShippingPriceSuccessState());
  }

  void updateGift({
    required String id,
    required int count,
  }) {
    emit(OnLoadingAddGiftState());

    FirebaseFirestore.instance
        .collection("product")
        .doc(id)
        .update({'count': FieldValue.increment(count)}).then((value) {
      FirebaseFirestore.instance
          .collection("product")
          .doc(id)
          .collection("details")
          .add({
        "count": count,
        "dateTime": DateTime.now().toString(),
      }).then((value) => getGift());
      emit(UpdateGiftSuccessState());
    }).catchError((error) {
      emit(UpdateGiftErrorState());
    });
  }

  void updateStore({
    required String id,
    required String file,
    required String name,
    required String notes,
    required String link,
    required String price,
    required String price2,
    required int count,
    required String uid,
    required String nameAdd,
    required int code,
  }) {
    emit(OnLoadingAddGiftState());
    GiftModel model = GiftModel(
      name: name,
      count: count,
      notes: notes,
      image: file,
      price: price,
      price2: price2,
      link: link,
      id: id,
      code: code,
      nameAdd: nameAdd,
      uid: uid,
      edit: "",
    );
    if (usermodel!.type == "تاجر") {
      FirebaseFirestore.instance
          .collection("pending_products")
          .doc(id)
          .set(model.toMap())
          .then((value) {
        emit(UpdateGiftAddSuccessState());
      }).catchError((error) {
        emit(UpdateGiftAddErrorState());
      });
    } else {
      FirebaseFirestore.instance.collection("product").doc(id).set(model.toMap()).then((value) {
        getGift();
        emit(UpdateGiftSuccessState());
      }).catchError((error) {
        emit(UpdateGiftErrorState());
      });
    }
  }

  List<GiftDetailsModel> giftDetails = [];
  void getGiftDetails({required String id}) {
    giftDetails = [];
    emit(OnLoadingGetMoneyState());
    FirebaseFirestore.instance
        .collection("product")
        .doc(id)
        .collection("details")
        .orderBy("dateTime", descending: false)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        giftDetails.add(GiftDetailsModel.fromJson(element.data()));
      }
      emit(GetMoneySuccessState());
    });
  }

//######### End Store Function ########
//######### Start Code Function ########

  void addCode({
    required String name,
    required String phone,
  }) {
    emit(OnLoadingAddCodeState());
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("code");
    String newId = collectionRef.doc().id;
    MandobeModel model = MandobeModel(name: name, phone: phone, id: newId);
    collectionRef.doc(newId).set(model.toMap()).then((value) {
      getCode();
      emit(CreateCodeSuccessState());
    }).catchError((error) {
      emit(CreateCodeErrorState());
    });
  }

  List<UserModel>? code;
  void getCode() {
    emit(OnLoadingGetCodeState());
    FirebaseFirestore.instance.collection("code").snapshots().listen((event) {
      code = [];
      for (var element in event.docs) {
        code!.add(UserModel.fromJson(element.data()));
      }

      emit(GetCodeSuccessState());
    });
  }

  void getfilteredCodeOrders({
    required String code,
  }) {
    filteredCodeOrders = orders!.where((order) {
      DateTime orderDate = DateTime.parse(order.dateTime!);
      return order.status == statusCodeValue &&
          order.sells == (statusSellsValue == "paid" ? true : false) &&
          orderDate.month == int.parse(monthValueCode!) &&
          orderDate.year == int.parse(yearValueCode!) &&
          order.code == code;
    }).toList();
    emit(GetFilterOrderCodeState());
  }

  void changeStatusCodeValue(status, code) {
    statusCodeValue = status;
    getfilteredCodeOrders(code: code);
    emit(ChangeStatusCodeState());
  }

  void changeStatusSellsValue(status, code) {
    statusSellsValue = status;
    getfilteredCodeOrders(code: code);
    emit(ChangeStatusSellsState());
  }

  void changeMonthCodeValue(month, code) {
    monthValueCode = month;
    getfilteredCodeOrders(code: code);
    emit(ChangeMonthCodeState());
  }

  void changeYearCodeValue(year, code) {
    yearValueCode = year;
    getfilteredCodeOrders(code: code);
    emit(ChangeYearCodeState());
  }

  List<CommissionDetailsModel> commissionDetails = [];
  void getCommissionDetails({required String id}) {
    commissionDetails = [];
    emit(OnLoadingGetMoneyState());
    FirebaseFirestore.instance
        .collection("code")
        .doc(id)
        .collection("commission")
        .orderBy("dateTime", descending: false)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        commissionDetails.add(CommissionDetailsModel.fromJson(element.data()));
      }
      emit(GetMoneySuccessState());
    });
  }

  bool message = false;

  Future<void> updatePaymentStatusForAllOrders(
      List<OrderModel>? filteredCodeOrders, code, id, commission) async {
    message = false;
    if (filteredCodeOrders == null) {
      return;
    }
    CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');

    for (OrderModel order in filteredCodeOrders) {
      await ordersCollection.doc(order.id).update({"sells": true});
    }
    FirebaseFirestore.instance
        .collection('code')
        .doc(id)
        .collection("commission")
        .add({
      "commission": commission,
      "dateTime": DateTime.now().toString(),
    });
    message = true;
    emit(ChangeMessageStatusState());
    getfilteredCodeOrders(code: code);
  }

//######### End Code Function #######

//######### Start suppliers Function #######

//######### suppliers Code Function #######

//######### Start Other Function #######
  void addToListMattress({
    required MattressModel name,
    required int count,
  }) {
    mattressList.add(MattressModel(
        name: name.name,
        id: name.id,
        count: count,
        height: name.height,
        size: name.size));
    emit(GetAddToListState());
  }

  void changeIndex(index, text) {
    currentIndex = index;
    labelAppBar = text;
    emit(ChangeIndexState());
  }

  void addMattress({
    required String name,
    required String size,
    required String height,
    required int count,
  }) {
    emit(OnLoadingAddMattressState());
    MattressModel model = MattressModel(
        name: name, size: size, height: height, count: count, id: "0");

    FirebaseFirestore.instance
        .collection("mattress")
        .add(model.toMap())
        .then((value) {
      String documentId = value.id;
      value.update({'id': documentId}).then((_) {
        getMattress();
        emit(CreateMattressSuccessState());
      }).catchError((error) {
        emit(CreateOrderErrorState());
      });
      emit(CreateMattressErrorState());
    }).catchError((error) {
      emit(CreateMattressErrorState());
    });
  }

  List<MattressModel> mattress = [];
  void getMattress() {
    mattress = [];
    emit(OnLoadingGetMattressState());
    FirebaseFirestore.instance.collection("mattress").get().then((value) {
      for (var element in value.docs) {
        mattress.add(MattressModel.fromJson(element.data()));
      }

      emit(GetMattressSuccessState());
    }).catchError((error) {
      emit(GetMattressErrorState());
    });
  }

  void addMoney({
    required String name,
    required String money,
    required String notes,
  }) {
    emit(OnLoadingAddMoneyState());
    MoneyModel model = MoneyModel(
        name: name,
        money: money,
        id: "0",
        date: DateTime.now().toString(),
        notes: notes);
    // إضافة مستند جديد في مجموعة "money" يتضمن الاسم فقط
    FirebaseFirestore.instance
        .collection("money")
        .add(model.toMap())
        .then((value) {
      String documentId = value.id;

      // تحديث المستند الجديد بإضافة الـ documentId إليه
      value.update({'id': documentId}).then((_) {
        // إضافة بيانات المال والتاريخ إلى المجموعة الفرعية "data" داخل المستند الجديد
        FirebaseFirestore.instance
            .collection("money")
            .doc(documentId)
            .collection("data")
            .add({
          'money': money,
          'date': DateTime.now().toString(),
          "notes": notes
        }).then((_) {
          getMoney();
          emit(CreateMoneySuccessState());
        }).catchError((error) {
          emit(CreateMoneyErrorState());
        });
      }).catchError((error) {
        emit(CreateMoneyErrorState());
      });
    }).catchError((error) {
      emit(CreateMoneyErrorState());
    });
  }

  List<MoneyModel> moneys = [];
  void getMoney() {
    emit(OnLoadingGetMoneyState());
    FirebaseFirestore.instance.collection("money").snapshots().listen((event) {
      moneys = [];
      for (var element in event.docs) {
        moneys.add(MoneyModel.fromJson(element.data()));
      }
      emit(GetMoneySuccessState());
    });
  }

  List<MoneysDetailsModel> moneysDetails = [];
  void getMoneyDetails({required String id}) {
    moneysDetails = [];
    emit(OnLoadingGetMoneyState());
    FirebaseFirestore.instance
        .collection("money")
        .doc(id)
        .collection("data")
        .orderBy("date", descending: false)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        moneysDetails.add(MoneysDetailsModel.fromJson(element.data()));
      }
      emit(GetMoneySuccessState());
    });
  }

  void updateMoney({
    required String id,
    required String name,
    required String money,
    required String notes,
  }) {
    moneys = [];
    emit(OnLoadingGetMoneyState());
    FirebaseFirestore.instance.collection("money").doc(id).update({
      "id": id,
      "name": name,
      "money": money,
      "date": DateTime.now().toString(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection("money")
          .doc(id)
          .collection("data")
          .add({
        "money": money,
        "date": DateTime.now().toString(),
        "notes": notes
      }).then((value) {
        getMoney();
        emit(GetMoneySuccessState());
      }).catchError((error) {
        emit(GetMoneyErrorState());
      });
    }).catchError((error) {
      emit(GetMoneyErrorState());
    });
  }

  int codeEmployee = 1;
  void addEmployee({
    required String name,
    required String jop,
  }) {
    emit(OnLoadingAddEmployeeState());
    EmployeeModel model =
        EmployeeModel(name: name, jop: jop, id: "0", code: codeEmployee);

    FirebaseFirestore.instance
        .collection("employee")
        .add(model.toMap())
        .then((value) {
      String documentId = value.id;
      value.update({'id': documentId}).then((_) {
        getEmployee();
        emit(CreateEmployeeSuccessState());
      }).catchError((error) {
        emit(CreateEmployeeErrorState());
      });
    }).catchError((error) {
      emit(CreateEmployeeErrorState());
    });
  }

  List<EmployeeModel> employee = [];
  void getEmployee() {
    emit(OnLoadingGetEmployeeState());
    FirebaseFirestore.instance
        .collection("employee")
        .snapshots()
        .listen((event) {
      employee = [];
      for (var element in event.docs) {
        employee.add(EmployeeModel.fromJson(element.data()));
      }
      employee.sort((a, b) => a.code!.compareTo(b.code!));
      codeEmployee = event.docs.length + 1;
      emit(GetEmployeeSuccessState());
    });
  }

//######### End Other Function #######
//######### Start Suppliers Function #######
  int codeSuppliers = 1;
  void addSuppliers({
    required String name,
    required int salary,
  }) {
    emit(OnLoadingAddSuppliersState());
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("suppliers");
    String newId = collectionRef.doc().id;
    SuppliersModel model = SuppliersModel(
        name: name,
        id: newId,
        salary: salary,
        code: codeSuppliers,
        dateTime: Timestamp.fromDate(DateTime.now()));
    collectionRef.doc(newId).set(model.toMap()).then((value) {
      getSuppliers();
      emit(CreateSuppliersMoneySuccessState());
    }).catchError((error) {
      emit(CreateSuppliersErrorState());
    });
  }

  List<SuppliersModel> suppliers = [];
  void getSuppliers() {
    emit(OnLoadingGetSuppliersState());
    FirebaseFirestore.instance
        .collection("suppliers")
        .snapshots()
        .listen((event) {
      suppliers = [];
      for (var element in event.docs) {
        suppliers.add(SuppliersModel.fromJson(element.data()));
      }
      suppliers.sort((a, b) => a.code!.compareTo(b.code!));
      codeSuppliers = event.docs.length + 1;
      emit(GetSuppliersSuccessState());
    });
  }

  void deleteSuppliers({required String id}) {
    FirebaseFirestore.instance
        .collection("suppliers")
        .doc(id)
        .delete()
        .then((value) => getSuppliers());
    emit(DeleteOrderSuccessState());
  }

  void addSuppliersMoney({
    required int money,
    required String name,
    required String type,
    required String notes,
    required Timestamp dateTime,
  }) {
    emit(OnLoadingAddSuppliersMoneyState());
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("vault");
    String newId = collectionRef.doc().id;
    SuppliersModelMoney model =
        type == "توريد نقدي" || type == "فودافون كاش" || type == "تسوية مدينة"
            ? SuppliersModelMoney(
                id: newId,
                type: type,
                notes: notes,
                dateTime: dateTime,
                debit: money,
                credit: 0,
                name: name)
            : SuppliersModelMoney(
                id: newId,
                type: type,
                notes: notes,
                dateTime: dateTime,
                debit: 0,
                credit: -money,
                name: name);
    collectionRef.doc(newId).set(model.toMap()).then((value) {
      getCombinedOrder(name: selectNameSuppliers!);
      emit(CreateSuppliersMoneySuccessState());
    }).catchError((error) {
      emit(CreateSuppliersMoneyErrorState());
    });
  }

  void editSuppliersMoney({
    required int money,
    required String id,
    required String name,
    required String type,
    required String notes,
    required Timestamp dateTime,
  }) {
    emit(OnLoadingUpdateSuppliersMoneyState());
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("vault");
    SuppliersModelMoney model =
        type == "توريد نقدي" || type == "فودافون كاش" || type == "تسوية مدينة"
            ? SuppliersModelMoney(
                id: id,
                type: type,
                notes: notes,
                dateTime: dateTime,
                debit: money,
                credit: 0,
                name: name)
            : SuppliersModelMoney(
                id: id,
                type: type,
                notes: notes,
                dateTime: dateTime,
                debit: 0,
                credit: -money,
                name: name);
    collectionRef.doc(id).update(model.toMap()).then((value) {
      getCombinedOrder(name: selectNameSuppliers!);
      emit(UpdateSuppliersMoneySuccessState());
    }).catchError((error) {
      emit(UpdateSuppliersMoneyErrorState());
    });
  }

  void deletesSuppliersMoney({
    required String id,
  }) {
    emit(OnLoadingDeleteSuppliersMoneyState());
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("vault");
    collectionRef.doc(id).delete().then((value) {
      getCombinedOrder(name: selectNameSuppliers!);
      emit(DeleteSuppliersMoneySuccessState());
    }).catchError((error) {
      emit(DeleteSuppliersMoneyErrorState());
    });
  }

  List<SuppliersModelMoney>? suppliersMoney;

  void getSuppliersMoney() {
    emit(OnLoadingGetSuppliersMoneyState());

    // إنشاء الاشتراك للاستماع لتحديثات Firestore
    FirebaseFirestore.instance.collection("vault").snapshots().listen((event) {
      suppliersMoney = [];
      for (var element in event.docs) {
        suppliersMoney!.add(SuppliersModelMoney.fromJson(element.data()));
      }
      emit(GetSuppliersMoneySuccessState());
    }, onError: (error) {
      emit(GetSuppliersMoneyErrorState());
    });
  }

  void addOrderSuppliers(
      {required String id,
      required String name,
      required int total,
      required Timestamp dateTime,
      required List<OrderDetailsModel> list}) async {
    emit(OnLoadingAddOrderState());
    removeParameter();
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection("orderSuppliers");
      String newId = collectionRef.doc().id;
      OrderSuppliersModel model = OrderSuppliersModel(
          name: name,
          credit: -total,
          dateTime: dateTime,
          id: newId,
          details: list,
          type: "فاتورة مشتريات",
          notes: "لا توجد ملاحظات");
      await collectionRef.doc(newId).set(model.toMap());
      if (list.isNotEmpty) {
        for (var order in list) {
          try {
            await FirebaseFirestore.instance
                .collection("product")
                .doc(order.id)
                .update({'count': FieldValue.increment(order.count!)});
            getOrdersSuppliers(name: name);
          } catch (error) {
            emit(CreateOrderErrorState());
            return;
          }
        }
      }
      orderSuppliersList.clear();
      suppliersValue = null;
      getGift();

      emit(CreateOrderSuccessState());
    } catch (error) {
      emit(CreateOrderErrorState());
    }
  }

  List<OrderSuppliersModel> ordersSuppliers = [];
  void getOrdersSuppliers({required String name}) {
    emit(OnLoadingGetOrderSuppliersState());
    FirebaseFirestore.instance
        .collection("orderSuppliers")
        .orderBy("dateTime", descending: true)
        .snapshots()
        .listen((event) {
      ordersSuppliers = [];
      for (var element in event.docs) {
        ordersSuppliers.add(OrderSuppliersModel.fromJson(element.data()));
      }
      getCombinedOrder(name: name);
      emit(GetOrderSuppliersSuccessState());
    });
  }

  List<CombinedModel> combinedList = [];
  void getCombinedOrder({required String name}) {
    combinedList = [];

    combinedList.add(CombinedModel(
      id: selectSuppliers!.id!,
      name: selectSuppliers!.name!,
      dateTime:
          selectSuppliers!.dateTime!, // يمكنك استخدام قيمة تاريخ ووقت محددة
      credit: -selectSuppliers!.salary!,
      debit: 0,
      notes: "رصيد بداية المدة",
      type: "تسوية دائنة",
    ));

    // Check if any order or supplier contains the name "Mohamed"
    // Check if any order or supplier contains the name "Mohamed"
    for (var order in ordersSuppliers) {
      if (order.name == name) {
        combinedList.add(CombinedModel(
          id: order.id,
          name: order.name,
          dateTime: order.dateTime!, // Convert string to DateTime
          credit: order.credit,
          notes: order.notes,
          details: order.details,
          type: order.type,
        ));
      }
    }

    // Iterate through suppliersMoney and add to combinedList if the name matches
    for (var supplier in suppliersMoney!) {
      if (supplier.name == name) {
        combinedList.add(CombinedModel(
          id: supplier.id,
          name: supplier.name,
          type: supplier.type,
          notes: supplier.notes,
          dateTime: supplier.dateTime, // Convert Timestamp to DateTime
          credit: supplier.credit,
          debit: supplier.debit,
        ));
      }
    }
    combinedList.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    emit(GetOrderSuppliersSuccessState());
  }

  Future<void> editOrderSuppliers({
    required String idSupp,
    required String id,
    required String name,
    required Timestamp dateTime,
    required String notes,
    required int credit,
    required int debit,
    required List<OrderDetailsModel> addList,
    required List<OrderDetailsModel> removeList,
  }) async {
    emit(OnLoadingEditOrderState());

    List<Map<String, dynamic>> listOfMaps =
        addList.map((orderDetails) => orderDetails.toMap()).toList();

    try {
      await FirebaseFirestore.instance
          .collection("orderSuppliers")
          .doc(id)
          .update({
        "credit": credit,
        "debit": debit,
        "dateTime": dateTime,
        "id": id,
        "details": listOfMaps,
        "type": "فاتورة مشتريات",
        "name": name,
        "notes": notes,
      });

      await _updateProductCounts(removeList, increment: false);
      await _updateProductCounts(addList, increment: true);

      orderSuppliersList.clear();
      suppliersValue = null;
      getGift();

      emit(EditOrderSuccessState());
    } catch (error) {
      emit(EditOrderErrorState());
    }
  }

  Future<void> _updateProductCounts(List<OrderDetailsModel> orderList,
      {required bool increment}) async {
    for (var order in orderList) {
      try {
        await FirebaseFirestore.instance
            .collection("product")
            .doc(order.id)
            .update({
          'count':
              FieldValue.increment(increment ? order.count! : -order.count!)
        });
      } catch (error) {
        rethrow; // Rethrow to handle in main function
      }
    }
  }

//######### End Suppliers Function #######
//######### Start User Function #######

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String type,
    required String notes,
    required bool addOrder,
    required bool editOrder,
    required bool removeOrder,
    required bool showMandobe,
    required bool addMandobe,
    required bool editMandobe,
    required bool removeMandobe,
    required bool showCode,
    required bool addCode,
    required bool editCode,
    required bool removeCode,
    required bool showStore,
    required bool addStore,
    required bool editStore,
    required bool changeStatus,
    required bool addComment,
  }) {
    emit(SocialRegisterOnLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: "$email@gmail.com", password: password)
        .then((value) {
      userCreate(
          email: email,
          password: password,
          notes: notes,
          uId: value.user!.uid,
          name: name,
          type: type,
          addOrder: addOrder,
          editOrder: editOrder,
          removeOrder: removeOrder,
          showMandobe: showMandobe,
          addMandobe: addMandobe,
          editMandobe: editMandobe,
          removeMandobe: removeMandobe,
          showCode: showCode,
          addCode: addCode,
          editCode: editCode,
          removeCode: removeCode,
          showStore: showStore,
          addStore: addStore,
          editStore: editStore,
          changeStatus: changeStatus,
          addComment: addComment,
          phone: phone);
    }).catchError((e) {
      print(e.toString());
      emit(SocialRegisterErrorState(e.toString()));
    });
  }

  void userUpdate({
    required String email,
    required String id,
    required String password,
    required String phone,
    required String name,
    required String type,
    required String notes,
    required bool addOrder,
    required bool editOrder,
    required bool removeOrder,
    required bool showMandobe,
    required bool addMandobe,
    required bool editMandobe,
    required bool removeMandobe,
    required bool showCode,
    required bool addCode,
    required bool editCode,
    required bool removeCode,
    required bool showStore,
    required bool addStore,
    required bool editStore,
    required bool changeStatus,
    required bool addComment,
  }) {
    emit(SocialOnLoadingUpdateUserState());
    FirebaseFirestore.instance.collection("users").doc(id).update({
      "uId": id,
      "email": email,
      "password": password,
      "phone": phone,
      "name": name,
      "type": type,
      "notes": notes,
      "addOrder": addOrder,
      "editOrder": editOrder,
      "removeOrder": removeOrder,
      "showMandobe": showMandobe,
      "addMandobe": addMandobe,
      "editMandobe": editMandobe,
      "removeMandobe": removeMandobe,
      "showCode": showCode,
      "addCode": addCode,
      "editCode": editCode,
      "removeCode": removeCode,
      "showStore": showStore,
      "addStore": addStore,
      "editStore": editStore,
      "changeStatus": changeStatus,
      "addComment": addComment,
    });
    emit(SocialUpdateUserSuccessState());
  }

  void deleteUser({
    required String uid,
    required String email,
    required String password,
  }) {
    emit(DeleteUserOnLoadingState());
    EmailAuthProvider.credential(email: email, password: password);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: "$email@gmail.com", password: password)
        .then((value) async {
      final user = FirebaseAuth.instance.currentUser;
      await user?.delete().then((value) {
        CollectionReference collectionRef =
            FirebaseFirestore.instance.collection("users");
        collectionRef.doc(uid).delete().then((value) {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: usermodel!.email!, password: usermodel!.password!)
              .then((value) {
            getUsers();
            emit(DeleteUserSuccessState());
          });
        }).catchError((error) {
          emit(DeleteUserErrorState());
        });
      });
    }).catchError((e) {
      emit(DeleteUserErrorState());
    });
  }

  void userCreate({
    required String email,
    required String password,
    required String phone,
    required String uId,
    required String name,
    required String type,
    required String notes,
    required bool addOrder,
    required bool editOrder,
    required bool removeOrder,
    required bool showMandobe,
    required bool addMandobe,
    required bool editMandobe,
    required bool removeMandobe,
    required bool showCode,
    required bool addCode,
    required bool editCode,
    required bool removeCode,
    required bool showStore,
    required bool addStore,
    required bool editStore,
    required bool changeStatus,
    required bool addComment,
  }) {
    emit(OnLoadingCreateUserState());
    UserModel model = UserModel(
        uId: uId,
        notes: notes,
        password: password,
        phone: phone,
        name: name,
        type: type,
        email: email,
        addOrder: addOrder,
        editOrder: editOrder,
        removeOrder: removeOrder,
        showMandobe: showMandobe,
        addMandobe: addMandobe,
        editMandobe: editMandobe,
        removeMandobe: removeMandobe,
        showCode: showCode,
        addCode: addCode,
        editCode: editCode,
        removeCode: removeCode,
        showStore: showStore,
        addStore: addStore,
        editStore: editStore,
        changeStatus: changeStatus,
        addComment: addComment,
      totalBalance: 0
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      getUsers();
      emit(SocialUserCreateSuccessState(uId));
    }).catchError((error) {
      emit(SocialUserCreateErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];
  void getUsers() {
    emit(OnLoadingGetAllUsersState());
    FirebaseFirestore.instance.collection("users").snapshots()
      ..listen((value) {
        users = [];
        for (var element in value.docs) {
          users.add(UserModel.fromJson(element.data()));
        }
        mandobe = users
            .where((element) => element.type!.contains("شركة شحن"))
            .toList();
        merchants = users
            .where((element) => element.type!.contains("تاجر"))
            .toList();
        code = users
            .where((element) => element.type!.contains("مسوق الكتروني"))
            .toList();
        emit(GetAllUsersSuccessState());
      }).onError((error) {
        emit(GetAllUsersErrorState());
      });
  }

  List<UserModel> usersAdmin = [];
  void getUsersAdmin() {
    emit(OnLoadingGetAllUsersState());
    FirebaseFirestore.instance.collection("userAdmin").snapshots()
      ..listen((value) {
        usersAdmin = [];
        for (var element in value.docs) {
          usersAdmin.add(UserModel.fromJson(element.data()));
        }
        emit(GetAllUsersSuccessState());
      }).onError((error) {
        emit(GetAllUsersErrorState());
      });
  }

  List<ItemCollectionModel> itemCollection = [];
  void getItemCollection() {
    emit(OnLoadingGetAllUsersState());
    FirebaseFirestore.instance.collection("itemCollection").snapshots()
      ..listen((value) {
        for (var element in value.docs) {
          itemCollection.add(ItemCollectionModel.fromJson(element.data()));
        }
        print("Item Collection = ${itemCollection[0].name}");
        emit(GetAllUsersSuccessState());
      }).onError((error) {
        emit(GetAllUsersErrorState());
      });
  }

  void updateUser({required String id}) {
    emit(SocialOnLoadingUpdateUserState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"start": FieldValue.increment(1)});
    emit(SocialUpdateUserSuccessState());
  }

  late OrderCodeModel orderCode;
  void getOrderCode() {
    emit(GetOrderCodeOnLoadingState());
    FirebaseFirestore.instance
        .collection("orderCode")
        .snapshots()
        .listen((event) {
      orderCode = OrderCodeModel.fromJson(event.docs[0].data());
      emit(GetOrderCodeSuccessState());
    });
  }

  void updateOrderCode({required String id}) {
    emit(UpdateOrderCodeOnLoadingState());
    FirebaseFirestore.instance
        .collection("orderCode")
        .doc(id)
        .update({"orderCode": FieldValue.increment(1)});
    emit(UpdateOrderCodeSuccessState());
  }

//######### End User Function #######

  Future<void> exportOrdersToExcel(List<OrderModel> orders) async {
    var excel = Excel.createExcel();
    var sheet = excel['اوردرات'];

    // إضافة رأس الجدول
    sheet.appendRow([
      TextCellValue('رقم الفاتورة'),
      TextCellValue('اسم العميل'),
      TextCellValue('المدينة'),
      TextCellValue('العنوان'),
      TextCellValue('المسوق'),
      TextCellValue('شركة الشحن'),
      TextCellValue('رقم الهاتف'),
      TextCellValue('رقم اخر'),
      TextCellValue('الحالة'),
      TextCellValue('الاجمالي'),
      TextCellValue('تفاصيل الاوردر'),
      TextCellValue('التاريخ')
    ]);

    // إضافة البيانات
    for (var order in orders) {
      String orderDetails = order.details!
          .map((detail) =>
              '(اسم المنتج:${detail.name}, الكمية: ${detail.count}, السعر: ${detail.price}, الملاحظة: ${detail.details}, الكود: ${detail.code})')
          .join('\n');
      sheet.appendRow([
        TextCellValue(order.orderCode!),
        TextCellValue(order.name!),
        TextCellValue(order.city!),
        TextCellValue(order.address!),
        TextCellValue(order.code!),
        TextCellValue(order.mandobeName!),
        TextCellValue(order.phone!),
        TextCellValue(order.phoneTow!),
        TextCellValue(order.status!),
        TextCellValue(order.total!),
        TextCellValue(orderDetails),
        TextCellValue(order.dateTime!.toString()),
      ]);
    }
    List<int>? excelBytes = excel.encode();
    if (excelBytes == null) return;

    Uint8List uint8List = Uint8List.fromList(excelBytes);

    downloadExcel(
        uint8List, "اوردرات ${DateTime.now().toString().split(" ")[0]}.xlsx");
  }

  Future<void> downloadSheet() async {
    var excel = Excel.createExcel();
    var sheet = excel['Orders'];

    // إضافة رأس الجدول
    sheet.appendRow([
      TextCellValue('رقم الفاتورة'),
      TextCellValue('اسم العميل'),
      TextCellValue('المدينة'),
      TextCellValue('العنوان'),
      TextCellValue('المسوق'),
      TextCellValue('شركة الشحن'),
      TextCellValue('رقم الهاتف'),
      TextCellValue('رقم اخر'),
      TextCellValue('الحالة'),
      TextCellValue('كود المنتج'),
      TextCellValue('الكمية'),
      TextCellValue('السعر'),
    ]);

    List<int>? excelBytes = excel.encode();
    if (excelBytes == null) return;

    Uint8List uint8List = Uint8List.fromList(excelBytes);

    downloadExcel(uint8List, "نموذج_اوردرات.xlsx");
  }

  Future<List<OrderModel>> importOrdersFromExcel() async {
    consoleLogs = [];
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null) {
        Uint8List? fileBytes = result.files.single.bytes;

        if (fileBytes == null) {
          addConsoleLog("⚠️ لم يتم تحميل الملف بشكل صحيح.");
          return [];
        }

        var excel = Excel.decodeBytes(fileBytes);
        var sheet = excel.tables[excel.tables.keys.toList()[1]]!;

        List<OrderModel> orders = [];

        for (var i = 1; i < sheet.rows.length; i++) {
          var row = sheet.rows[i];

          if (row.length < 11 ||
              row[0] == null ||
              row[1] == null ||
              row[2] == null ||
              row[3] == null ||
              row[4] == null ||
              row[5] == null ||
              row[6] == null ||
              row[8] == null ||
              row[9] == null ||
              row[10] == null ||
              row[11] == null) {
            addConsoleLog(
                "⚠️ الصف رقم $i يحتوي على بيانات ناقصة (باستثناء رقم الهاتف الثاني)، سيتم تخطيه.");
            continue;
          }

          int? sell = int.tryParse(row[9]?.value.toString() ?? '');
          int? count = int.tryParse(row[10]?.value.toString() ?? '');
          int? price = int.tryParse(row[11]?.value.toString() ?? '');

          if (sell == null || count == null || price == null) {
            addConsoleLog(
                "⚠️ الصف رقم $i يحتوي على قيم غير صالحة، سيتم تخطيه.");
            continue;
          }

          GiftModel? orderDetails = gift!.firstWhere(
            (element) => element.code == sell,
            orElse: () => GiftModel(name: "", count: 0, id: '', code: 0),
          );
          ShippingPrice? selectedCity = shippingPrice!.firstWhere(
            (element) => element.governorate == row[2]!.value.toString(),
            orElse: () => ShippingPrice(
                governorate: "", price: 0, id: ''), // قيمة افتراضية
          );
          UserModel? mandobeen = mandobe!.firstWhere(
                (element) => element.name == row[5]!.value.toString(),
            orElse: () => UserModel(
                name: "", uId: "", type: ''), // قيمة افتراضية
          );
          UserModel? sells = code!.firstWhere(
                (element) => element.name == row[4]!.value.toString(),
            orElse: () => UserModel(
                name: "", uId: "", type: ''), // قيمة افتراضية
          );
          orders.add(OrderModel(
            orderCode: row[0]?.value.toString() ?? '',
            name: row[1]?.value.toString() ?? '',
            city: row[2]?.value.toString() ?? '',
            address: row[3]?.value.toString() ?? '',
            code: sells.name,
            mandobeName: mandobeen.name,
            phone: row[6]?.value.toString() ?? '',
            phoneTow: row[7]?.value.toString() ?? '',
            status: row[8]?.value.toString() ?? '',
            dateTime: DateTime.now().toString(),
            total: "${(count * price) + selectedCity.price!}",
            priceCity: selectedCity.price,
            uIdMandobeName: mandobeen.uId,
            uIdCode: sells.uId,
            details: [
              OrderDetailsModel(
                id: orderDetails.id,
                count: count,
                name: orderDetails.name,
                details: "",
                price: price,
                total: count * price,
                code: sell,
              )
            ],
          ));
        }
        addConsoleLog("✅ تم استيراد ${orders.length} طلب بنجاح.");
        for (var i = 0; i < orders.length; i++) {
          // ShippingPrice? selectedCity = shippingPrice!.firstWhere(
          //       (element) => element.governorate == orders[0].city!,
          //   orElse: () => ShippingPrice(governorate: "", price: 0, id: ''), // قيمة افتراضية
          // );
          addOrder(
              name: orders[i].name!,
              phone: orders[i].phone!,
              phoneTow: orders[i].phoneTow!,
              address: orders[i].address!,
              city: orders[i].city!,
              mandobeName: orders[i].mandobeName!,
              code: orders[i].code!,
              total: orders[i].total!,
              dateTime: orders[i].dateTime!,
              orderDetails: orders[i].details!, priceCity: orders[i].priceCity!, uIdMandobeName: orders[i].uIdMandobeName!, uIdCode: orders[i].uIdCode!);
          addConsoleLog("✅ تم اضافة اوردر ${orders[i].name} طلب بنجاح.");
        }

        return orders;
      }
      addConsoleLog("⚠️ لم يتم اختيار أي ملف.");
      return [];
    } catch (e) {
      addConsoleLog("⚠️ هذا الملف به مشكلة.");
      return [];
    }
  }

  void addConsoleLog(String message) {
    consoleLogs.add(message);
    emit(AddConsoleState());
  }

  Uint8List? webImage;
  String? fileName;
  Future picProductImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      webImage = await pickedImage.readAsBytes();
      fileName = pickedImage.name;
      emit(ImagePickedSuccessState());
    } else {
      print("no Image Selected");
      emit(ImagePickedErrorState());
    }
  }

  Uint8List? webRequestImage;
  String? fileRequestName;
  Future picRequestImageFromGallery() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      webRequestImage = await pickedImage.readAsBytes();
      fileRequestName = pickedImage.name;
      emit(ImagePickedSuccessState());
    } else {
      print("no Image Selected");
      emit(ImagePickedErrorState());
    }
  }

  Future<Map<String, dynamic>> postRequestWithFile({
    required Uint8List file,
    required String name,
    required String notes,
    required String link,
    required String price,
    required String price2,
    required int count,
    required String uid,
    required String nameAdd,
    required String type,
  }) async {
    emit(OnLoadingCheckOut());
    try {
      http.MultipartRequest request = http.MultipartRequest(
          "POST", Uri.parse("https://admin.the-future-market.xyz/api/upload"));
      print("done1");
      if (file != null) {
        var multipartFile = http.MultipartFile.fromBytes(
          "images",
          file,
          filename: fileName,
        );

        request.files.add(multipartFile);
      }
      request.headers.addAll({
        "Accept": "application/json",
      });
      print("done3");

      var myrequest = await request.send();
      print("done5");
      if (myrequest.statusCode == 200 || myrequest.statusCode == 201) {
        var responseData = await myrequest.stream.bytesToString();
        var jsonData = jsonDecode(responseData);
        emit(CheckOutSuccessful());
        addGift(
            price: price,
            price2: price2,
            nameAdd: nameAdd,
            name: name,
            count: count,
            notes: notes,
            link: link,
            image: jsonData['paths'][0],
            uid: uid,
            type: type);
        return jsonData['paths'];
      } else {
        emit(CheckOutSError());
        print("Error ${myrequest.statusCode}");
        return {'error': 'Failed to upload image'};
      }
    } catch (error) {
      emit(CheckOutSError());
      print('Error uploading image: $error');
      return {'error': 'Error uploading image'};
    }
  }

  Future<void> createTransferRequest({
   required int amount,
    required String notes,
    required String phone,
    required String type
}) async {
    emit(OnLoadingAddRequest());
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("requestsBalance");
    String newId = collectionRef.doc().id;
    await collectionRef.doc(newId).set({
      'id': newId,
      'name': usermodel!.name,
      'uId':usermodel!.type=="ادمن"?usersAdmin[0].uId :usermodel!.uId,
      'type': type,
      'role': usermodel!.type,
      'phone': phone,
      'amount': amount,
      'status': 'قيد المراجعه',
      'notes': notes,
      'image': "",
      'dateTime': DateTime.now().toString(),
      'createdAt': FieldValue.serverTimestamp(),
    }).then((value){
      emit(AddRequestSuccessful());
    }).catchError((e){
      emit(AddRequestSError());
    });
  }
 List<RequestModel>? requests;
 void getTransferRequest() async {
    emit(OnLoadingGetRequest());
    FirebaseFirestore.instance.collection("requestsBalance").where("uId" ,isEqualTo:usermodel!.type=="ادمن"?usersAdmin[0].uId : usermodel!.uId).orderBy("createdAt",descending: true).snapshots()
      .listen((value) {
      requests = [];
      for (var element in value.docs) {
        requests!.add(RequestModel.fromJson(element.data()));
      }
      emit(GetRequestSuccessful());
    });
  }
  List<RequestModel>? requestsDelay;
  void getTransferRequestDelay() async {
    emit(OnLoadingGetRequestDelay());
    FirebaseFirestore.instance.collection("requestsBalance").where("status" ,isEqualTo: 'قيد المراجعه').orderBy("createdAt",descending: true).snapshots()
        .listen((value) {
      requestsDelay = [];
      for (var element in value.docs) {
        requestsDelay!.add(RequestModel.fromJson(element.data()));
      }
      emit(GetRequestDelaySuccessful());
    });
  }

  List<RequestModel>? allRequests;
  void getAllRequest() async {
    emit(OnLoadingGetRequestDelay());
    FirebaseFirestore.instance.collection("requestsBalance").orderBy("createdAt",descending: true).snapshots()
        .listen((value) {
      allRequests = [];
      for (var element in value.docs) {
        allRequests!.add(RequestModel.fromJson(element.data()));
      }
      emit(GetRequestDelaySuccessful());
    });
  }

  void whistlingAdmin()async {
    emit(OnLoadingWhistlingAdmin());
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("requestsBalance");
    String newId = collectionRef.doc().id;
    batch.update(firestore.collection("userAdmin").doc(usersAdmin[0].uId),{"total_balance":0});
    batch.set(firestore.collection("requestsBalance").doc(newId), {
      'id': newId,
      'name': usermodel!.name,
      'uId':usermodel!.type=="ادمن"?usersAdmin[0].uId :usermodel!.uId,
      'type': "",
      'role': usermodel!.type,
      'phone': "",
      'amount': usersAdmin[0].totalBalance,
      'status': 'تم الموافقة',
      'notes':  "تم تصفير الحساب من ${usersAdmin[0].totalBalance} الي صفر",
      'image': "",
      'dateTime': DateTime.now().toString(),
      'createdAt': FieldValue.serverTimestamp(),
    });
    try {
      await batch.commit();
      emit(WhistlingAdminSuccessful());
    } catch (error) {
      emit(WhistlingAdminError());
    }
  }

  void requestConfirm({
   required RequestModel model,
   required String notes,
  })async {
    emit(OnLoadingRequestConfirm());
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();
    if(webRequestImage!=null){
      try {

        http.MultipartRequest request = http.MultipartRequest(
            "POST", Uri.parse("https://admin.the-future-market.xyz/api/upload"));
        if (webRequestImage != null) {
          var multipartFile = http.MultipartFile.fromBytes(
            "images",
            webRequestImage!,
            filename: fileRequestName,
          );

          request.files.add(multipartFile);
        }
        request.headers.addAll({
          "Accept": "application/json",
        });
        var myrequest = await request.send();
        if (myrequest.statusCode == 200 || myrequest.statusCode == 201) {
          var responseData = await myrequest.stream.bytesToString();
          var jsonData = jsonDecode(responseData);

          batch.update(firestore.collection("requestsBalance").doc(model.id), {
            "status": "تم الموافقة",
            "notes":notes,
            "image":jsonData['paths'][0]
          });
          if(model.role=="ادمن"){
            batch.update(firestore.collection("userAdmin").doc(model.uId), {
              'total_balance': FieldValue.increment(-model.amount!)
            });
          }else{
            batch.update(firestore.collection("users").doc(model.uId), {
              'total_balance': FieldValue.increment(-model.amount!)
            });
          }
          try {
            await batch.commit();
            emit(RequestConfirmSuccessful());
          } catch (error) {
            emit(RequestConfirmError());
          }
        } else {
          emit(RequestConfirmError());
          print("Error ${myrequest.statusCode}");
        }
      } catch (error) {
        emit(RequestConfirmSuccessful());
        print('Error uploading image: $error');
      }
    }else{
      batch.update(firestore.collection("requestsBalance").doc(model.id), {
        "status": "تم الموافقة",
        "notes":notes,
      });
      if(model.role=="ادمن"){
        batch.update(firestore.collection("userAdmin").doc(model.uId), {
          'total_balance': FieldValue.increment(-model.amount!)
        });
      }else{
        batch.update(firestore.collection("users").doc(model.uId), {
          'total_balance': FieldValue.increment(-model.amount!)
        });
      }
      try {
        await batch.commit();
        emit(RequestConfirmSuccessful());
      } catch (error) {
        emit(RequestConfirmError());
      }
    }


  }

  void requestRefused(RequestModel model,String notes)async {
    emit(OnLoadingRequestRefuse());
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();
    batch.update(firestore.collection("requestsBalance").doc(model.id), {
      "status": "تم الرفض",
      "notes":notes
    });
    try {
      await batch.commit();
      emit(RequestRefuseSuccessful());
    } catch (error) {
      emit(RequestRefuseError());
    }
  }

}
