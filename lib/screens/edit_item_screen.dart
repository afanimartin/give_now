import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_event.dart';
import '../blocs/item/item_state.dart';
import '../models/item/item.dart';
import '../utils/category.dart';
import '../utils/condition.dart';
import '../widgets/category_editing_widget.dart';
import '../widgets/condition_editing_widget.dart';
import '../widgets/menu_widget.dart';
import '../widgets/price_editing_widget.dart';
import '../widgets/progress_loader.dart';
import '../widgets/title_editing_widget.dart';

///
class EditItemScreen extends StatefulWidget {
  ///
  const EditItemScreen({@required this.item, Key key}) : super(key: key);

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
  bool get _isEditing => widget.item != null;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceContentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (_isEditing) {
      _titleController.text = widget.item.title;
      _descriptionController.text = widget.item.description;
      _priceContentController.text = widget.item.price;
    }
  }

  String _categoryValue = categoryList[0];
  String _conditionValue = conditionList[0];

  @override
  Widget build(BuildContext context) => BlocBuilder<ItemBloc, ItemState>(
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: widget.item.mainImageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                          onChanged: (String category) {
                            setState(() {
                              _categoryValue = category;
                            });
                          }),
                      ConditonEditingWidget(
                          conditionValue: _conditionValue,
                          onChanged: (String condition) {
                            setState(() {
                              _conditionValue = condition;
                            });
                          })
                    ],
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final updatedItem = widget.item.copyWith(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    price: _priceContentController.text,
                    category: _categoryValue,
                    condition: _conditionValue,
                    updatedAt: Timestamp.now());

                context.read<ItemBloc>().add(UpdateItem(item: updatedItem));
              },
              child: state is ItemBeingUpdated
                  ? const ProgressLoader()
                  : const Icon(
                      Icons.check,
                      size: 30,
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
