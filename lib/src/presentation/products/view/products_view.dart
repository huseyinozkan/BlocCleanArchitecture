import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/quantity_button.dart';
import 'package:bloc_clean_architecture/src/common/widgets/network_image/cached_network_image.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/data_not_found_widget.dart';
import 'package:bloc_clean_architecture/src/data/model/response/category_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/product_dto.dart';
import 'package:bloc_clean_architecture/src/presentation/products/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsCubit>()..initialized(context),
      child: const Scaffold(
        appBar: _AppBar(),
        body: _Body(),
      ),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      leading: emptyBox,
      title: CoreText(LocalizationKey.products.tr(context)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            expandedHeight: 50,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                spacing: 12,
                children: [
                  _MenuCategories(),
                ],
              ),
            ),
          ),
        ];
      },
      body: const _Products(),
    );
  }
}

@immutable
final class _MenuCategories extends StatelessWidget {
  const _MenuCategories();

  @override
  Widget build(BuildContext context) {
    final categories = context.select((ProductsCubit cubit) => cubit.state.categories);
    return SizedBox(
      height: 32,
      child: CoreListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppConstants.paddingConstants.pagePaddingHorizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => horizontalBox8,
        itemBuilder: (context, index) => _MenuCategoryButton(category: categories[index]),
      ),
    );
  }
}

@immutable
final class _MenuCategoryButton extends StatelessWidget {
  const _MenuCategoryButton({required this.category});

  final CategoryDto category;

  @override
  Widget build(BuildContext context) {
    final isSelected = context.select((ProductsCubit cubit) => cubit.state.selectedCategory?.id == category.id);
    return CoreButton(
      onPressed: () => context.read<ProductsCubit>().onChangedSelectedCategory(category),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? context.colorScheme.secondary : context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Row(
              children: [
                CoreText.labelMedium(
                  category.name,
                  textColor: isSelected ? context.colorScheme.onSecondary : context.colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
final class _Products extends StatelessWidget {
  const _Products();

  @override
  Widget build(BuildContext context) {
    final products = context.select((ProductsCubit cubit) => cubit.state.products);
    return products.isEmpty
        ? DataNotFoundWidget(description: LocalizationKey.noDataToDisplay.tr(context))
        : RefreshIndicator.adaptive(
            onRefresh: () => context.read<ProductsCubit>().onRefresh(context),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: products.length,
              separatorBuilder: (context, index) => verticalBox12,
              itemBuilder: (context, index) => _ProductCard(product: products[index]),
            ),
          );
  }
}

@immutable
final class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ProductDto product;

  double get cardHeight => 130;
  double get imageHeight => cardHeight;
  double get imageWidth => imageHeight * 0.8;
  double get cardBorderRadius => 12;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppConstants.paddingConstants.pagePaddingHorizontal,
      height: cardHeight,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(cardBorderRadius),
            child: MyCachedNetworkImage(
              imageId: product.id,
              height: imageHeight,
              width: imageWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Başlık ve Fiyat alanı
                  Row(
                    children: [
                      Expanded(child: CoreText.titleMedium(product.name, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(color: context.colorScheme.secondary, borderRadius: BorderRadius.circular(12)),
                        child: CoreText.titleSmall(product.priceToCurrency, fontWeight: FontWeight.bold, textColor: context.colorScheme.onSecondary),
                      ),
                    ],
                  ),
                  verticalBox4,
                  // İçindekiler alanı
                  Visibility(
                    child: Expanded(
                      child: CoreAutoSizeText(
                        product.description,
                        minFontSize: 6,
                      ),
                    ),
                  ),
                  verticalBox4,
                  // Sepete ekle butonu
                  Row(
                    children: [
                      const Spacer(),
                      Builder(
                        builder: (context) {
                          final cartItems = context.select((ProductsCubit cubit) => cubit.state.cartItems);
                          final quantity = cartItems.where((e) => e.product?.id == product.id).length;
                          return QuantityButton(
                            quantity: quantity,
                            onIncrease: () {
                              context.read<ProductsCubit>().increaseProductQuantity(product);
                            },
                            onDecrease: () {
                              context.read<ProductsCubit>().decreaseProductQuantity(product);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
