import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tool_app/state/providers/item_provider.dart';
import 'package:my_tool_app/state/notifiers/item_notifier.dart';
import 'package:my_tool_app/app/routes.dart';
import 'package:my_tool_app/ui/widgets/common/loading_widget.dart';
import 'package:my_tool_app/ui/widgets/common/empty_state.dart';
import 'package:my_tool_app/ui/widgets/common/error_widget.dart';
import 'package:my_tool_app/ui/widgets/business/item_card.dart';
import 'package:my_tool_app/ui/styles/spacing.dart';
import 'package:my_tool_app/core/extensions/context_ext.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(itemProvider.notifier).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemState = ref.watch(itemProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的工具'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settingsRoute);
            },
          ),
        ],
      ),
      body: _buildBody(itemState),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildBody(ItemState state) {
    if (state.isLoading) {
      return const LoadingWidget();
    }
    
    if (state.error != null) {
      return ErrorDisplayWidget(
        message: state.error!,
        onRetry: () => ref.read(itemProvider.notifier).loadItems(),
      );
    }
    
    if (state.items.isEmpty) {
      return const EmptyState(
        title: '暂无数据',
        message: '点击右下角按钮添加',
      );
    }
    
    return ListView.builder(
      padding: AppSpacing.edgeInsetsAll16,
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];
        return ItemCard(
          item: item,
          onTap: () {
            Navigator.pushNamed(
              context, 
              AppRoutes.detail,
              arguments: {'id': item.id},
            );
          },
          onDelete: () {
            ref.read(itemProvider.notifier).deleteItem(item.id);
          },
        );
      },
    );
  }
  
  void _showAddDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('添加项目'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: '标题',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: '内容（可选）',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  ref.read(itemProvider.notifier).addItem(
                    titleController.text,
                    contentController.text.isEmpty ? null : contentController.text,
                  );
                  Navigator.pop(context);
                  context.showSnackBar('添加成功');
                } else {
                  context.showSnackBar('请输入标题');
                }
              },
              child: const Text('添加'),
            ),
          ],
        );
      },
    );
  }
}
