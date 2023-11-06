import 'package:esalerz/extentions/custom_string_extension.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/widgets/modals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/view_models/account_view_model.dart';
import 'text_edit_view.dart';

class CountryListWidget extends StatelessWidget {
  
  final List<String> countries;

  final searchController = TextEditingController();

    CountryListWidget({super.key, required this.countries});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 14, right: 14),
            height: 110,
            color: AppColors.lightPrimary,
            child: TextEditView(
              controller: searchController,
              hintText: 'Search location',
              filled: true,
              autofocus: false,
              isDense: true,
              fillColor: Colors.white,
              borderColor: AppColors.lightPrimary,
              prefixIcon: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(height: 20,color: AppColors.scaffoldColor,),

          ListTile(
            title: const Text('My Location'),
            subtitle:   Text('${user.address.capitalizeFirstOfEach}'),
            trailing: const Icon(Icons.keyboard_arrow_right,
                color: AppColors.lightPrimary),
            onTap: () {},
          ),
          Container(height: 20,color: AppColors.scaffoldColor,),
           ListTile(
            title: const Text('All Nigeria'),
            trailing: const Icon(Icons.keyboard_arrow_right,
                color: AppColors.lightPrimary),
            onTap: () {},
          ),
          
          Container(height: 20,color: AppColors.scaffoldColor,),

          const Divider(
            height: 0,
            thickness: 1.0,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: countries.length,
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 1.0,
                height: 0,
              );
            },
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(countries[index]),
                trailing: const Icon(Icons.keyboard_arrow_right,
                    color: AppColors.lightPrimary),
                onTap: () {
                   user.updateAddress(countries[index]);
                  Navigator.pop(context);
                  

                },
              );
            },
          ),
        ],
      ),
    );
  }
}
