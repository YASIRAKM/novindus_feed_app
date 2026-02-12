import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/utils/snack_bar_utils.dart';
import 'package:novindus_feed_app/features/add_feed/presentation/widgets/add_feed_popup_widget.dart';

import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../feed/presentation/providers/feed_provider.dart';
import '../providers/add_feed_provider.dart';
import '../widgets/category_selector_widget.dart';
import '../widgets/description_input_widget.dart';
import '../widgets/file_picker_widget.dart';

class AddFeedScreen extends StatefulWidget {
  const AddFeedScreen({super.key});

  @override
  State<AddFeedScreen> createState() => _AddFeedScreenState();
}

class _AddFeedScreenState extends State<AddFeedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AddFeedProvider>(context, listen: false);
      provider.resetForm();
      provider.loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AddFeedScreenContent();
  }
}

class _AddFeedScreenContent extends StatefulWidget {
  const _AddFeedScreenContent();

  @override
  State<_AddFeedScreenContent> createState() => _AddFeedScreenContentState();
}

class _AddFeedScreenContentState extends State<_AddFeedScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();
  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context, _formKey),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AddFeedProvider>(
          builder: (context, provider, child) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilePickerWidget(
                    file: provider.videoFile,
                    onTap: provider.pickVideo,
                    label: 'Select a video from Gallery',
                    icon: Icons.play_arrow,
                    height: 200,
                    isVideo: true,
                  ),
                  const SizedBox(height: 24),
                  FilePickerWidget(
                    file: provider.imageFile,
                    onTap: provider.pickImage,
                    label: 'Add a Thumbnail',
                    icon: Icons.image,
                  ),
                  const SizedBox(height: 24),
                  DescriptionInputWidget(controller: _descController),
                  const SizedBox(height: 16),
                  CategorySelectorWidget(
                    categories: provider.categories,
                    selectedCategoryIds: provider.selectedCategoryIds.toSet(),
                    onCategorySelected: provider.toggleCategory,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, GlobalKey<FormState> formKey) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: Colors.white,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Add Feeds', style: AppTextStyles.appBarTitle),
      actions: [
        Consumer<AddFeedProvider>(
          builder: (context, provider, child) {
            return InkWell(
              onTap: provider.status == AddFeedStatus.uploading
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        if (provider.videoFile == null) {
                          SnackbarUtils.showError("Please select a video");
                          return;
                        }
                        if (provider.imageFile == null) {
                          SnackbarUtils.showError("Please select a thumbnail");
                          return;
                        }
                        if (provider.selectedCategoryIds.isEmpty) {
                          SnackbarUtils.showError(
                            "Please select at least one category",
                          );
                          return;
                        }

                       
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const AddFeedProgressDialog();
                          },
                        );

                        final success = await provider.uploadFeed(
                          _descController.text,
                        );

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }

                        if (success && context.mounted) {
                        
                          Provider.of<FeedProvider>(
                            context,
                            listen: false,
                          ).loadMyFeeds(refresh: true);

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const AddFeedProgressDialog(
                                isSuccess: true,
                              );
                            },
                          );

                          await Future.delayed(const Duration(seconds: 2));

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                        } else if (context.mounted &&
                            provider.errorMessage != null) {
                          SnackbarUtils.showError(provider.errorMessage!);
                        }
                      }
                    },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: provider.status == AddFeedStatus.uploading
                      ? Colors.grey
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: provider.status == AddFeedStatus.uploading
                        ? Colors.grey
                        : AppColors.redColor,
                  ),
                ),
                child: Text('Share Post', style: AppTextStyles.buttonText),
              ),
            );
          },
        ),
      ],
    );
  }
}
