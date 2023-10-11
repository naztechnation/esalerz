// import 'dart:io';

// import 'package:esalerz/ui/widgets/button_view.dart';
// import 'package:esalerz/ui/widgets/custom_text.dart';
// import 'package:esalerz/ui/widgets/modals.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

// import '../../../handlers/secure_handler.dart';

// import '../../../res/app_colors.dart';
// import '../../../res/app_strings.dart';
// import '../../../res/enum.dart';
// import '../../../utils/navigator/page_navigator.dart';

// class KycServiceScreenSeven extends StatefulWidget {
//   KycServiceScreenSeven({
//     super.key,
//   });

//   @override
//   State<KycServiceScreenSeven> createState() => _KycServiceScreenSevenState();
// }

// class _KycServiceScreenSevenState extends State<KycServiceScreenSeven> {
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     // final user = Provider.of<ServiceProviderViewModel>(context, listen: true);
//     // final userDetails = Provider.of<AccountViewModel>(context, listen: true);

//     return Scaffold(
//         body: Container(
//       height: MediaQuery.sizeOf(context).height,
//       width: MediaQuery.sizeOf(context).width,
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [AppColors.scaffoldColor, Colors.red.shade50],
//               begin: Alignment.topRight,
//               end: Alignment.topLeft)),
//       child: BlocProvider<AccountCubit>(
//         lazy: false,
//         create: (_) => AccountCubit(
//           //accountRepository: AccountRepositoryImpl(),
//          // viewModel: Provider.of<AccountViewModel>(context, listen: false),
//         ),
//         child: BlocConsumer<AccountCubit, AccountStates>(
//           listener: (context, state) {
//             // if (state is AgentResLoaded) {
//             //   if (state.agents.status!) {
//             //     StorageHandler.saveAgentId(state.agents.agent!.id.toString());

//             //     AppNavigator.pushAndStackPage(context,
//             //         page: KycServiceScreenEight());
//             //     Modals.showToast(state.agents.message ?? '',
//             //         messageType: MessageType.success);
//             //   } else {
//             //     Modals.showToast(state.agents.message ?? '',
//             //         messageType: MessageType.success);
//             //   }
//             // // } else if (state is AccountApiErr) {
//             // //   if (state.message != null) {
//             // //     Modals.showToast(state.message!,
//             // //         messageType: MessageType.error);
//             // //   }
//             // // } else if (state is AccountNetworkErr) {
//             // //   if (state.message != null) {
//             // //     Modals.showToast(state.message!,
//             // //         messageType: MessageType.error);
//             // //   }
//             // }
//           },
//           builder: (context, state) => GestureDetector(
//             onTap: () {
//               FocusScope.of(context).requestFocus(FocusNode());
//             },
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SafeArea(
//                       child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
//                   const Row(
//                     children: [
//                       //backButton(context),
//                       SizedBox(
//                         width: 40,
//                       ),
//                       CustomText(
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         text: 'KYC  Registration',
//                         weight: FontWeight.w800,
//                         size: 16,
//                         fontFamily: AppStrings.interSans,
//                         color: Colors.black,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: MediaQuery.sizeOf(context).height * 0.11,
//                   ),
//                   const CustomText(
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     text: 'Upload your picture ',
//                     weight: FontWeight.w700,
//                     size: 24,
//                     fontFamily: AppStrings.montserrat,
//                     color: Colors.black,
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   //  // if (user.imageURl == null) ...[
//                   //     Container(
//                   //       padding: EdgeInsets.all(30),
//                   //       height: 294,
//                   //       decoration: BoxDecoration(
//                   //         borderRadius: BorderRadius.circular(30),
//                   //         color: Color(0xFF424242),
//                   //       ),
//                   //       margin: EdgeInsets.symmetric(horizontal: 20),
//                   //       width: MediaQuery.sizeOf(context).width,
//                   //     ),
//                   //   ],
//                   // if (user.imageURl != null) ...[
//                   //   Container(
//                   //       height: 294,
//                   //       decoration: BoxDecoration(
//                   //         borderRadius: BorderRadius.circular(30),
//                   //         color: Color(0xFF424242),
//                   //       ),
//                   //       margin: EdgeInsets.symmetric(horizontal: 20),
//                   //       width: MediaQuery.sizeOf(context).width,
//                   //       child: ClipRRect(
//                   //         borderRadius: BorderRadius.circular(30),
//                   //         child: ImageView.file(
//                   //             File(
//                   //               user.imageURl!.path,
//                   //             ),
//                   //             fit: BoxFit.cover),
//                   //       )),
//                   // ],
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   // (state is PetProfileLoading)
//                   // ? SizedBox.shrink()
//                   // : TextButton(
//                   //     onPressed: () async {
//                   //      // user.loadImage(context, UploadType.userPhoto);
//                   //     },
//                   //     child: Padding(
//                   //       padding: const EdgeInsets.all(10.0),
//                   //       child: Text('Choose from gallery'),
//                   //     ),
//                   //     style: TextButton.styleFrom(
//                   //       backgroundColor: Color(0xFFEBF0FF),
//                   //       shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(30),
//                   //       ),
//                   //     ),
//                   //   ),
//                   const SizedBox(
//                     height: 70,
//                   ),
//                   //if (user.imageURl != null)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 0.0, horizontal: 20),
//                     child: ButtonView(
//                       onPressed: () async {
//                         // if (user.imageURl != null) {
//                         //   userDetails.getUserId();
//                         //   setState(() {
//                         //     isLoading = true;
//                         //   });
//                         //   String imgUrl = await user.uploadImage(
//                         //       user.imageURl!.path,
//                         //       'petnity_service_provider');
//                         //   setState(() {
//                         //     isLoading = false;
//                         //   });

//                         //   // _submit(
//                         //   //   username: userDetails.username,
//                         //   //   ctx: context,
//                         //   //   name: user.serviceProviderName,
//                         //   //   country: user.serviceProviderCountry,
//                         //   //   city: user.serviceProviderCity,
//                         //   //   dob: user.serviceProviderAge,
//                         //   //   gender: user.servicesProviderGender,
//                         //   //   about: user.aboutServiceProvider,
//                         //   //   picture: imgUrl,
//                         //   // );

//                         //   AppNavigator.pushAndStackPage(context,
//                         //       page: KycServiceScreenEight());
//                         // }
//                       },
//                       // processing: (state is AgentResLoading || isLoading),
//                       color: AppColors.lightSecondary,
//                       borderRadius: 32,
//                       borderColor: Colors.white,
//                       child: const CustomText(
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         text: 'Submit',
//                         weight: FontWeight.w400,
//                         size: 16,
//                         fontFamily: AppStrings.interSans,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ));
//   }

//   _submit(
//       {required BuildContext ctx,
//       required String username,
//       required String name,
//       required String gender,
//       required String country,
//       required String city,
//       required String about,
//       required String dob,
//       required String picture}) {
//     // Modals.showToast(username);
//     ctx.read<AccountCubit>().registerServiceProviderProfile(
//         username: username,
//         dob: dob,
//         name: name,
//         gender: gender,
//         country: country,
//         city: city,
//         about: about,
//         picture: picture);
//   }
// }

// class AccountCubit {
//   void registerServiceProviderProfile(
//       {required String username,
//       required String dob,
//       required String name,
//       required String gender,
//       required String country,
//       required String city,
//       required String about,
//       required String picture}) {}
// }
