

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_model/ads_options.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';
import 'package:http/http.dart' as http;



class AdsOptionPage extends StatelessWidget {

  final String adsId;
  const AdsOptionPage({
    Key? key,   this.adsId = '10',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: AdsOption(adsId: adsId,),
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

  String token = '';


  List<AdsOptionsData> options = [];

   final Map<String, TextEditingController> controllers = {};


  getCategories() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    // _userCubit.getAdsOptions(bkey: token, adsId: widget.adsId);
    await  _userCubit.getAdsOptions(bkey: token, adsId: '10');

      for (var param in options) {
      String paramKey = param.paramName!.split('-').last;
      controllers[paramKey] = TextEditingController();
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
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
        body: BlocConsumer<UserCubit, UserStates>(listener:
         (context, state) {
      if (state is AdsOptionsLoaded) {
        if (state.adsOptions.status == 1) {
          options = state.adsOptions.data ?? [];
          setState(() {});
        } else {
          options = [];
        }
      } 
    }, builder: (context, state) {
      if (state is UserNetworkErr) {
        
        return EmptyWidget(
          title: 'Network error',
          description: state.message,
            context: context,

          onRefresh: () => _userCubit.getAdsOptions(bkey: token, adsId: widget.adsId),
        );
      } else if (state is UserNetworkErrApiErr) {
         
        return EmptyWidget(
          title: 'Network error',
          description: state.message,
            context: context,

          onRefresh: () => _userCubit.getAdsOptions(bkey: token, adsId: widget.adsId),
        );
      }

      return (state is AdsOptionsLoading)
          ? Scaffold(body: const LoadingPage())
          : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: options.map((param) {
                if (param.paramType == 'textbox') {
                  String paramKey = param.paramName!.split('-').last;
                  return TextFormField(
                    controller: controllers[paramKey],
                    decoration: InputDecoration(
                      labelText: paramKey,
                    ),
                  );
                } else if (param.paramType == 'select') {
                  List<String> values = param.paramValues!.split(',');
                  String paramKey = param.paramName!.split('-').last;
                  return DropdownButtonFormField(
                    value: null,
                    onChanged: (value) {
                      // Handle dropdown value change if needed
                    },
                    items: values.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: paramKey,
                    ),
                  );
                } else {
                  return Container(); 
                }
              }).toList(),
            ),
          ),
                );
  }),
    );
  }

  void sendDataToServer() async {
    Map<String, String> payload = {};

    for (var param in options) {
      String paramKey = param.paramName!.split('-').first;
      String paramValue = controllers[paramKey]!.text;
      payload[paramKey] = paramValue;
    }

    
    payload['bkey'] = token;
    payload['image[]'] = token;

    try {
      var response = await http.post(
        Uri.parse('your_server_url_here'),
        body: payload,
      );

      // Handle the server response here
      print('Server response: ${response.body}');
    } catch (error) {
      print('Error sending data to server: $error');
    }
  }
}