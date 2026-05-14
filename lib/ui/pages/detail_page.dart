import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tool_app/state/providers/item_provider.dart';
import 'package:my_tool_app/ui/styles/spacing.dart';
import 'package:my_tool_app/core/utils/date_utils.dart' as date_utils;
import 'package:my_tool_app/core/extensions/context_ext.dart';

class DetailPage extends ConsumerStatefulWidget {
  final String itemId;

  const DetailPage({
    super.key,
    required this.itemId,
  });

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  bool _isEditing = false;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final itemState = ref.watch(itemProvider);
    final item = itemState.items.firstWhere(
      (i) => i.id == widget.itemId,
      orElse: () => itemState.items.first,
    );

    if (_isEditing) {
      _titleController.text = item.title;
      _contentController.text = item.content ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '编辑项目' : '详情'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveItem(item);
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: AppSpacing.edgeInsetsAll16,
        child: _isEditing
            ? _buildEditForm(item)
            : _buildDetailView(item),
      ),
    );
  }

  Widget _buildDetailView(dynamic item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '创建时间: ${date_utils.DateUtils.formatDateTime(item.createdAt)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (item.content != null)
          Text(
            item.content!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }

  Widget _buildEditForm(dynamic item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: '标题',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _contentController,
          decoration: const InputDecoration(
            labelText: '内容',
            border: OutlineInputBorder(),
          ),
          maxLines: null,
        ),
      ],
    );
  }

  void _saveItem(dynamic item) {
    if (_titleController.text.isNotEmpty) {
      final updatedItem = item.copyWith(
        title: _titleController.text,
        content: _contentController.text.isEmpty ? null : _contentController.text,
      );
      ref.read(itemProvider.notifier).updateItem(updatedItem);
      setState(() {
        _isEditing = false;
      });
      context.showSnackBar('保存成功');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
