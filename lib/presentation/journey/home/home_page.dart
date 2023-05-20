import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/home/components/banner_item.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/product_widget.dart';
import 'package:magento_app/presentation/journey/home/components/product_type_item.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'package:magento_app/presentation/widgets/refresh_widget.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final List<AssetGenImage> banners = [
    Assets.images.homeBanner1,
    Assets.images.homeBanner2,
    Assets.images.homeBanner3,
  ];

  final productTypeTiles = [
    TransactionConstants.shirt.tr,
    TransactionConstants.pants.tr,
    TransactionConstants.coats.tr,
    //  TransactionConstants.shoes.tr,
    TransactionConstants.bags.tr,
    // TransactionConstants.accessories.tr,
  ];

  final productTypeImages = [
    Assets.images.icPolo,
    Assets.images.icPants,
    Assets.images.icCoat,
    // Assets.images.icShoes,
    Assets.images.icBag,
    //  Assets.images.icNecklace,
  ];

  final bannerImages = [
    '/m/h/mh01-black_main_1.jpg',
    '/w/t/wt04-blue_main_1.jpg',
    '/u/g/ug06-lb-0.jpg',
    '/w/s/ws05-black_back_1.jpg',
  ];

  final bannerTitles = [
    TransactionConstants.men.tr,
    TransactionConstants.women.tr,
    TransactionConstants.gear.tr,
    TransactionConstants.sale.tr,
  ];

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final mainController = Get.find<MainController>();
    return Obx(() => Scaffold(
          key: controller.scaffoldKey,
          backgroundColor: AppColors.grey50,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(150.sp),
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.mediaQuery.padding.top,
                        ),
                        Text(
                          'Hi, ${mainController.rxCustomer.value?.firstname ?? ''} ${mainController.rxCustomer.value?.lastname ?? ''}',
                          overflow: TextOverflow.ellipsis,
                          style: ThemeText.bodySemibold.s16,
                        ),
                        _searchField()
                      ],
                    )
                  ],
                ),
              )),
          body: _buildBody(),
        ));
  }

  Widget _searchField() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.product, arguments: true),
      child: Container(
        margin: EdgeInsets.only(top: 8.sp),
        width: Get.width - 16.sp * 2,
        child: AppTextField(
          enable: false,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16.sp, right: 10.5.sp),
            child: SizedBox(
              width: 14.sp,
              height: 14.sp,
              child: AppImageWidget(
                asset: Assets.images.icSearch,
              ),
            ),
          ),
          hintText: TransactionConstants.search.tr,
          readOnly: true,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() => RefreshWidget(
          enableLoadMore: controller.canLoadMore.value,
          onLoadMore: () async {
            double oldPosition = controller.scrollController.position.pixels;
            await controller.getProductList();
            controller.scrollController.position.jumpTo(oldPosition);
          },
          controller: controller.productRefreshController,
          onRefresh: controller.onRefresh,
          child: controller.rxLoadedList.value == LoadedType.start
              ? const AppLoadingWidget()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: CustomScrollView(
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 40.sp),
                          child: _buildBannerWidget(),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            TransactionConstants.homeLookingfor.tr,
                            style: ThemeText.bodySemibold.s20,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.sp, bottom: 40.sp),
                          child: _buildTypeOfProductList(),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.sp),
                          child: Center(
                            child: Text(
                              TransactionConstants.hotItems.tr,
                              style: ThemeText.bodySemibold.s20,
                            ),
                          ),
                        ),
                      ),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (Get.width / 4) / (Get.width / 3),
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Card(
                              child:
                                  _buildProductItem(controller.products[index]),
                            );
                          },
                          childCount: controller.products.length,
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }

  Widget _buildBannerWidget() {
    return CarouselSlider(
      items: banners
          .map(
            (item) => AppImageWidget(
              asset: item,
              fit: BoxFit.cover,
              width: Get.width,
              borderRadius: BorderRadius.circular(10),
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: false,
        viewportFraction: 1,
        aspectRatio: Get.height / Get.width,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        initialPage: 0,
      ),
    );
  }

  Widget _buildProductItem(ProductModel productModel) {
    final mainController = Get.find<MainController>();
    return AppTouchable(
      onPressed: () {
        Get.toNamed(AppRoutes.productDetail, arguments: productModel.sku);
      },
      child: Container(
        color: AppColors.white,
        width: Get.width / 2,
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImageWidget(
              url:
                  '${NetworkConfig.baseProductMediaUrl}${productModel.mediaGalleryEntries?.first.file ?? ''}',
              size: Get.width / 4,
            ),
            SizedBox(height: 16.sp),
            Text(
              productModel.name ?? '',
              style: ThemeText.bodyRegular,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.sp),
            Obx(
              () => Text(
                  '${currencySymbols[mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${productModel.price ?? 0}',
                  style: ThemeText.bodySemibold.s16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeOfProductList() {
    return Center(
      child: Wrap(
        children: [
          ProductTypeItem(
            icon: productTypeImages[0],
            title: productTypeTiles[0],
            onTap: () {
              Get.toNamed(AppRoutes.product, arguments: 'tee');
            },
          ),
          ProductTypeItem(
              icon: productTypeImages[1],
              title: productTypeTiles[1],
              onTap: () {
                Get.toNamed(AppRoutes.product, arguments: 'pant');
              }),
          ProductTypeItem(
              icon: productTypeImages[2],
              title: productTypeTiles[2],
              onTap: () {
                Get.toNamed(AppRoutes.product, arguments: 'jacket');
              }),
          ProductTypeItem(
              icon: productTypeImages[3],
              title: productTypeTiles[3],
              onTap: () {
                Get.toNamed(AppRoutes.product, arguments: 'bag');
              }),
          // ProductTypeItem(
          //   icon: productTypeImages[4],
          //   title: productTypeTiles[4],
          //     onTap: ()
          //     {
          //       Get.toNamed(AppRoutes.product, arguments: 'tee');
          //     }
          // ),
          // ProductTypeItem(
          //   icon: productTypeImages[5],
          //   title: productTypeTiles[5],
          //     onTap: ()
          //     {
          //       Get.toNamed(AppRoutes.product, arguments: 'tee');
          //     }
          // ),
        ],
      ),
    );
  }

  _buildHotItemsList() {
    return controller.hotItems.value.isEmpty
        ? const SizedBox.shrink()
        : SizedBox(
            height: Get.width * 0.8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  ProductWidget(productModel: controller.hotItems.value[index]),
              itemCount: controller.hotItems.value.length >= 10
                  ? 10
                  : controller.hotItems.value.length,
              shrinkWrap: true,
            ),
          );
  }

  _buildBannersList() {
    return ListView.builder(
      itemBuilder: (context, index) => BannerItem(
        title: bannerTitles[index],
        image: bannerImages[index],
      ),
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
