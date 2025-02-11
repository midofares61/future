import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/model/order_model.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../constant/constant.dart';

class OrderPage extends StatefulWidget {
  final List<OrderModel> orders;
  const OrderPage({super.key, required this.orders});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final FocusNode _thirdFocusNode = FocusNode();
  final FocusNode _forthFocusNode = FocusNode();
  final FocusNode _fiveFocusNode = FocusNode();
  final FocusNode _btnFocusNode = FocusNode();

  late TextEditingController deliverController;
  late TextEditingController kartahController;
  late TextEditingController gazController;
  late TextEditingController otherController;
  late TextEditingController deliverAddController;

  @override
  void initState() {
    super.initState();
    deliverController = TextEditingController();
    kartahController = TextEditingController();
    gazController = TextEditingController();
    otherController = TextEditingController();
    deliverAddController = TextEditingController();
  }

  @override
  void dispose() {
    deliverController.dispose();
    kartahController.dispose();
    gazController.dispose();
    otherController.dispose();
    deliverAddController.dispose();
    super.dispose();
  }

  int calculateTotal() {
    int totalOrders = widget.orders.fold(0, (sum, order) => sum + int.parse(order.total!));
    int gaz = int.tryParse(gazController.text) ?? 0;
    int deliver = int.tryParse(deliverController.text) ?? 0;
    int deliverAdd = int.tryParse(deliverAddController.text) ?? 0;
    int kartah = int.tryParse(kartahController.text) ?? 0;
    int other = int.tryParse(otherController.text) ?? 0;

    return totalOrders - gaz - deliver - kartah - other + deliverAdd;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Column(
      children: [
        buildInputRow("مصاريف الشحن", deliverController, _firstFocusNode),
        const SizedBox(height: 10),
        buildInputRow("مصاريف كارته", kartahController, _secondFocusNode),
        const SizedBox(height: 10),
        buildInputRow("مصاريف جاز", gazController, _thirdFocusNode),
        const SizedBox(height: 10),
        buildInputRow("مصاريف اخري", otherController, _forthFocusNode),
        const SizedBox(height: 10),
        buildInputRow("اضافي شحن", deliverAddController, _fiveFocusNode),
        const SizedBox(height: 10),
        Text(
          "اجمالي المبلغ المطلوب=  ${calculateTotal()}",
          style:const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        InkWell(
          focusNode: _btnFocusNode,
          onTap: () {
            cubit.addMandobeMoney(name: widget.orders[0].mandobeName!,money:calculateTotal() );
            deliverController.text="";
            kartahController.text="";
            gazController.text="";
            otherController.text="";
            deliverAddController.text="";
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: defaultColor,
                borderRadius: BorderRadius.circular(20)),
            child:const Text(
              "اضافة",
              style: TextStyle(
                  color:Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );});
  }

  Widget buildInputRow(String label, TextEditingController controller, FocusNode focusNode) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.center,
      onFieldSubmitted: (_) => setState(() {}),
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: label,
        isDense: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}