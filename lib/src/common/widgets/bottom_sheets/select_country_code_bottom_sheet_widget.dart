import 'dart:async';
import 'dart:convert';

import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/data_not_found.dart';
import 'package:bloc_clean_architecture/src/common/widgets/textfields/search_textfield.dart';
import 'package:bloc_clean_architecture/src/data/model/country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class SelectCountryCodeBottomSheetWidget extends StatefulWidget {
  const SelectCountryCodeBottomSheetWidget({required this.id, super.key});

  final String id;

  @override
  State<SelectCountryCodeBottomSheetWidget> createState() => _SelectCountryCodeBottomSheetWidgetState();
}

class _SelectCountryCodeBottomSheetWidgetState extends State<SelectCountryCodeBottomSheetWidget> {
  List<Country>? countries;
  late TextEditingController controller;

  IMyPopupManager get popupManager => getIt<IMyPopupManager>();

  List<Country> get filteredCountries {
    final text = controller.text.trim().toLowerCase();
    return countries?.where((element) => element.countryName?.toLowerCase().contains(text) ?? false).toList() ?? [];
  }

  @override
  void initState() {
    controller = TextEditingController();
    scheduleMicrotask(() {
      loadCountryCodes().then((value) {
        countries = value;
        if (context.mounted) setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: context.width,
            height: 50,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 80,
                    height: 6,
                    decoration: BoxDecoration(
                      color: context.colorScheme.onSurface.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 0,
                  bottom: 0,
                  child: CoreIconButton(
                    onPressed: () => popupManager.dialogs.hidePopup<void>(id: widget.id),
                    icon: Icon(
                      Icons.close,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchTextField(
              onChanged: (_) => setState(() {}),
              controller: controller,
            ),
          ),
          verticalBox20,
          if (countries.isNullOrEmpty)
            const DataNotFound()
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (context, i) => listRow(filteredCountries[i]),
              ),
            ),
          verticalBox20,
        ],
      ),
    );
  }

  Future<List<Country>> loadCountryCodes() async {
    final data = await rootBundle.loadString(Assets.phoneCodes.phoneCodes);
    final jsonResult = json.decode(data);
    return (jsonResult as List<dynamic>).map((elemet) => Country.fromJson(elemet as Map<String, dynamic>)).toList();
  }

  Widget listRow(Country country) => ListTile(
        title: Row(
          children: [
            Assets.flags.values
                    .where((item) => item.path.contains(country.countryCode!))
                    .map(
                      (e) => Image.asset(
                        e.path,
                        width: 30,
                      ),
                    )
                    .firstOrNull ??
                const SizedBox.shrink(),
            horizontalBox8,
            Expanded(child: CoreText.bodyMedium(country.countryName ?? '', fontWeight: FontWeight.bold)),
            CoreText.labelMedium('(${country.phoneCode})'),
          ],
        ),
        onTap: () {
          popupManager.dialogs.hidePopup(id: widget.id, result: country);
        },
      );
}
