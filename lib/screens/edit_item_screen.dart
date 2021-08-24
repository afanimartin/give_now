import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../blocs/item/item_cubit.dart';
import '../blocs/item/item_state.dart';
import '../models/item/item.dart';
import '../utils/category.dart';
import '../utils/condition.dart';
import '../utils/constants.dart';
import '../widgets/category_editing_widget.dart';
import '../widgets/condition_editing_widget.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/menu_widget.dart';
import '../widgets/price_editing_widget.dart';
import '../widgets/progress_loader.dart';
import '../widgets/title_editing_widget.dart';

///
class EditItemScreen extends StatefulWidget {
  ///
  const EditItemScreen({required this.item, Key? key}) : super(key: key);

  ///
  final Item item;

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
  }
}

class _EditItemScreenState extends State<EditItemScreen> {
  // ignore: unnecessary_null_comparison
  bool get _isEditing => widget.item != null;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceContentController = TextEditingController();

  String? _categoryValue = categoryList[0];
  String? _conditionValue = conditionList[0];

  @override
  void initState() {
    super.initState();

    if (_isEditing) {
      _titleController.text = widget.item.title!;
      _descriptionController.text = widget.item.description!;
      _priceContentController.text = widget.item.price!;
      _categoryValue = widget.item.category!;
      _conditionValue = widget.item.condition;
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          appBar: AppBar(
            elevation: 0,
            title: TitleEditingWidget(controller: _titleController),
            backgroundColor: Theme.of(context).accentColor,
            iconTheme: Theme.of(context).iconTheme,
            actions: [
              MenuWidget(
                item: widget.item,
              )
            ],
          ),
          body: SlidingUpPanel(
            body: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.item.mainImageUrl!,
                  height: Constants.threeHundred,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Constants.six,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleEditingWidget(
                          controller: _titleController,
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: _descriptionController,
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                      ),
                      PriceEditingWidget(controller: _priceContentController),
                      CategoryEditingWidget(
                          categoryValue: _categoryValue,
                          onChanged: (String? category) {
                            setState(() {
                              _categoryValue = category;
                            });
                          }),
                      ConditonEditingWidget(
                          conditionValue: _conditionValue,
                          onChanged: (String? condition) {
                            setState(() {
                              _conditionValue = condition;
                            });
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButtonWidget(
            onPressed: () {
              final updatedItem = widget.item.copyWith(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  price: _priceContentController.text,
                  category: _categoryValue,
                  condition: _conditionValue,
                  updatedAt: Timestamp.now());

              context.read<ItemCubit>().updateItem(updatedItem);
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: state is ItemBeingUpdated
                ? ProgressLoader(
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                : const Icon(
                    Icons.check,
                    size: Constants.iconButtonSize,
                  ),
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();

    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', widget.item));
  }
}
