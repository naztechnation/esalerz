import 'dart:io';

import 'package:esalerz/extentions/custom_string_extension.dart';
import 'package:esalerz/ui/widgets/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_model/ads_options.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../res/enum.dart';
import '../widgets/button_view.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';

class AdsOptionPage extends StatelessWidget {
  final String adsId;
  const AdsOptionPage({
    Key? key,
    this.adsId = '10',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: AdsOption(
        adsId: adsId,
      ),
    );
  }
}

class AdsOption extends StatefulWidget {
  final String adsId;

  const AdsOption({super.key, required this.adsId});

  @override
  State<AdsOption> createState() => _AdsOptionState();
}

class _AdsOptionState extends State<AdsOption> {
  late UserCubit _userCubit;

  final _formKey = GlobalKey<FormState>();

  String token = '';

  List<AdsOptionsData> options = [];

  final Map<String, TextEditingController> controllers = {};
  final Map<String, String> selectedValues = {};

  getCategories() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    // _userCubit.getAdsOptions(bkey: token, adsId: widget.adsId);
    await _userCubit.getAdsOptions(bkey: token, adsId: '10');
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<AccountViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageView.asset(
              AppImages.icon,
              height: 30,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              'Enter Ads Info',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.close,
                  color: AppColors.lightPrimary,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is AdsOptionsLoaded) {
          if (state.adsOptions.status == 1) {
            options = state.adsOptions.data ?? [];
            for (var param in options) {
              if (param.paramType == 'textbox') {
                String paramKey = param.paramName ?? '';
                controllers[paramKey] = TextEditingController();
              }
            }
            setState(() {});
          } else {
            options = [];
          }
        } else if (state is PostAdsLoaded) {
          if (state.success.status == 1) {
            Modals.showToast(state.success.message ?? '',
                messageType: MessageType.success);
          } else {
            Modals.showToast(state.success.message ?? '');
          }
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            context: context,
            onRefresh: () =>
                _userCubit.getAdsOptions(bkey: token, adsId: widget.adsId),
          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            context: context,
            onRefresh: () =>
                _userCubit.getAdsOptions(bkey: token, adsId: widget.adsId),
          );
        }

        return (state is AdsOptionsLoading)
            ? LoadingPage()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (serviceProvider.imageURl2 == null) ...[
                        GestureDetector(
                          onTap: () {
                            serviceProvider.loadImage(
                                context, UploadType.photoId);
                          },
                          child: Container(
                            padding: EdgeInsets.all(30),
                            height: 294,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.lightPrimary.withOpacity(0.1),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.sizeOf(context).width,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No images selected'),
                                SizedBox(
                                  height: 14,
                                ),
                                Icon(Icons.add),
                              ],
                            )),
                          ),
                        ),
                      ],
                      if (serviceProvider.imageURl2 != null) ...[
                        Container(
                            height: 294,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF424242),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.sizeOf(context).width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ImageView.file(
                                  File(
                                    serviceProvider.imageURl2!.path,
                                  ),
                                  fit: BoxFit.cover),
                            )),
                      ],
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: options.map((param) {
                              if (param.paramType == 'textbox') {
                                String paramKey =
                                    param.paramName!.split('-').last;
                                return TextFormField(
                                  controller: controllers[param.paramName],
                                  decoration: InputDecoration(
                                    labelText: paramKey.capitalizeFirstOfEach,
                                  ),
                                   
                                );
                              } else if (param.paramType == 'select') {
                                List<String> values = param.paramValues!.split(',');
            String paramKey = param.paramName ?? '';
            String paramKey1 = param.paramName!.split('-').last;

            return DropdownButtonFormField(
              value: selectedValues[paramKey],
              onChanged: (value) {
                setState(() {
                  selectedValues[paramKey] = value.toString();
                });
              },
              items: values.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: paramKey1.capitalizeFirstOfEach,
              ),
            );
                              } else {
                                return Container();
                              }
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: ButtonView(
                          color: AppColors.lightPrimary,
                          processing: state is PostAdsLoading,
                          borderColor: Colors.white,
                          borderRadius: 30,
                          onPressed: () {
                            submitPost(serviceProvider.imageURl2);
                          },
                          child: const Text(
                            'Post Ads',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  submitPost(var image) {
    if (validateForm()) {
      if (image != null) {
        _userCubit.postAds(options: options, image: image, token: token);
      } else {
        Modals.showToast('please select image');
      }
    }
  }

 bool validateForm() {
  for (var param in options) {
    if (param.paramType == 'textbox') {
      String paramKey = param.paramName ?? '';
      String paramValue = controllers[paramKey]?.text.trim() ?? '';

      if (paramValue.isEmpty) {
        Modals.showToast('${paramKey.capitalizeFirstOfEach} cannot be empty');
        print('Error: $paramKey cannot be empty');
        return false;
      }
    }else if (param.paramType == 'select') {
      String paramKey = param.paramName ?? '';

      String selectedValue = selectedValues[paramKey] ?? '';

      if (selectedValue.isEmpty) {
        Modals.showToast('${paramKey.capitalizeFirstOfEach} must be selected');
        return false;
      }
    }
  }

  return true;
}

}
