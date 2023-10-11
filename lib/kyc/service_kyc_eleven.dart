// import 'dart:io';

// import 'package:esalerz/ui/widgets/custom_text.dart';
// import 'package:esalerz/ui/widgets/image_view.dart';
// import 'package:esalerz/ui/widgets/modals.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

// import '../../../res/app_colors.dart';
// import '../../../res/app_strings.dart';
// import '../../../res/enum.dart';
// import '../../../utils/navigator/page_navigator.dart';

// class KycServiceScreenEleven extends StatefulWidget {
//   KycServiceScreenEleven({
//     super.key,
//   });

//   @override
//   State<KycServiceScreenEleven> createState() => _KycServiceScreenElevenState();
// }

// class _KycServiceScreenElevenState extends State<KycServiceScreenEleven> {
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     // final serviceProvider =
//     //     Provider.of<ServiceProviderViewModel>(context, listen: true);

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
//             accountRepository: AccountRepositoryImpl(),
//             viewModel: Provider.of<AccountViewModel>(context, listen: false)),
//         child: BlocConsumer<AccountCubit, AccountStates>(
//           listener: (context, state) {
//             if (state is AccountLoaded) {
//               if (state.userData.status!) {
//                 AppNavigator.pushAndStackPage(context,
//                     page: KycServiceScreenTwelve());
//                 Modals.showToast(state.userData.message ?? '',
//                     messageType: MessageType.success);
//               } else {
//                 Modals.showToast(state.userData.message ?? '',
//                     messageType: MessageType.success);
//               }
//             } else if (state is AccountApiErr) {
//               if (state.message != null) {
//                 Modals.showToast(state.message!,
//                     messageType: MessageType.error);
//               }
//             } else if (state is AccountNetworkErr) {
//               if (state.message != null) {
//                 Modals.showToast(state.message!,
//                     messageType: MessageType.error);
//               }
//             }
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
//                   Row(
//                     children: [
//                      // backButton(context),
//                       const SizedBox(
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
//                   CustomText(
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     text: 'Upload ID picture ',
//                     weight: FontWeight.w700,
//                     size: 24,
//                     fontFamily: AppStrings.montserrat,
//                     color: Colors.black,
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   if (serviceProvider.imageURl2 == null) ...[
//                     Container(
//                       padding: EdgeInsets.all(30),
//                       height: 294,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: Color(0xFF424242),
//                       ),
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       width: MediaQuery.sizeOf(context).width,
//                     ),
//                   ],
//                   if (serviceProvider.imageURl2 != null) ...[
//                     Container(
//                         height: 294,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color: Color(0xFF424242),
//                         ),
//                         margin: EdgeInsets.symmetric(horizontal: 20),
//                         width: MediaQuery.sizeOf(context).width,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(30),
//                           child: ImageView.file(
//                               File(
//                                 serviceProvider.imageURl2!.path,
//                               ),
//                               fit: BoxFit.cover),
//                         )),
//                   ],
//                   SizedBox(
//                     height: 40,
//                   ),
//                   (state is PetProfileLoading)
//                       ? SizedBox.shrink()
//                       : TextButton(
//                           onPressed: () async {
//                             serviceProvider.loadImage(
//                                 context, UploadType.photoId);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Text('Choose from gallery'),
//                           ),
//                           style: TextButton.styleFrom(
//                             backgroundColor: Color(0xFFEBF0FF),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                         ),
//                   const SizedBox(
//                     height: 70,
//                   ),
//                   if (serviceProvider.imageURl2 != null)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 0.0, horizontal: 20),
//                       child: ButtonView(
//                         onPressed: () async {
//                           if (serviceProvider.imageURl2 != null) {
//                             //      AppNavigator.pushAndStackPage(context,
//                             // page: KycServiceScreenTwelve(

//                             // ));
//                             setState(() {
//                               isLoading = true;
//                             });
//                             String imgUrl = await serviceProvider.uploadImage(
//                                 serviceProvider.imageURl2!.path,
//                                 'petnity_service_provider');
//                             setState(() {
//                               isLoading = false;
//                             });
//                             _submit(
//                                 ctx: context,
//                                 photoId: serviceProvider.photoId,
//                                 picture: imgUrl);
//                           }
//                         },
//                         processing: (state is AccountLoading || isLoading),
//                         color: AppColors.lightSecondary,
//                         borderRadius: 32,
//                         borderColor: Colors.white,
//                         child: CustomText(
//                           textAlign: TextAlign.center,
//                           maxLines: 1,
//                           text: 'Submit',
//                           weight: FontWeight.w400,
//                           size: 16,
//                           fontFamily: AppStrings.interSans,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   SizedBox(
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
//       required String photoId,
//       required String picture}) {
//     ctx
//         .read<AccountCubit>()
//         .uploadPhotoUrl(photoId: photoId, photoUrl: picture);
//   }
// }
