import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialCheck/View/AddCheck/sc_all_category_listview.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_add_entry_allmaterial_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyMaintenance/View/Add/sc_unify_propertyinfo_view.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../MaterialCheck/Model/sc_check_type_model.dart';
import '../../../PropertyFrmLoss/Model/sc_property_list_model.dart';
import '../../Model/sc_material_list_model.dart';

/// 物资信息cell

class SCMaterialInfoCell extends StatelessWidget {
  /// 选择仓库名称
  final Function? selectNameAction;

  /// 选择类型
  final Function? selectTypeAction;

  /// 点击新增
  final Function? addAction;

  /// 删除物资
  final Function(int index)? deleteAction;

  /// 物资数据源
  final List<SCMaterialListModel> list;

  /// 物资分类数据源
  final List<SCCheckTypeModel>? categoryList;

  /// 刷新数量
  final Function(int index, int value)? updateNumAction;

  /// 是否显示添加
  final bool showAdd;

  /// 2显示物资分类,3显示采购单,4资产维保,其它显示物资信息，
  final int? materialType;

  /// title
  final String title;

  /// 隐藏物资数量输入框
  final bool? hideMaterialNumTextField;

  /// 是否是物资出入库-归还入库
  final bool? isReturnEntry;

  /// 是否是资产
  final bool? isProperty;

  /// 资产维保数据
  final dynamic? propertyMap;

  /// 无需归还勾选
  final Function(int index, bool status)? noNeedReturnAction;

  /// 是否统一维保单位
  final Function(bool value)? unifyPropertyCompanyAction;

  /// 是否统一维保内容
  final Function(bool value)? unifyPropertyContentAction;

  /// 统一维保内容
  final Function(String value)? propertyCompanyAction;

  /// 维保内容
  final Function(String value)? propertyContentAction;

  SCMaterialInfoCell({
    Key? key,
    required this.title,
    this.materialType = 0,
    this.selectNameAction,
    this.selectTypeAction,
    this.addAction,
    required this.list,
    this.categoryList,
    this.deleteAction,
    this.updateNumAction,
    required this.showAdd,
    this.hideMaterialNumTextField,
    this.isReturnEntry,
    this.isProperty,
    this.propertyMap,
    this.noNeedReturnAction,
    this.unifyPropertyCompanyAction,
    this.unifyPropertyContentAction,
    this.propertyCompanyAction,
    this.propertyContentAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleItem(),
        numItem(),
        const SizedBox(
          height: 6.0,
        ),
        listview(),
      ],
    );
  }

  /// titleItem
  Widget titleItem() {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w500,
                      color: SCColors.color_1B1D33)),
            ),
            topRightItem(),
          ],
        ));
  }

  /// 新增
  Widget topRightItem() {
    if (showAdd) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          addAction?.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              SCAsset.iconMaterialAdd,
              width: 18.0,
              height: 18.0,
            ),
            const SizedBox(
              width: 6.0,
            ),
            const Text('新增',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_4285F4)),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  /// 数量
  Widget numItem() {
    String subTitle = '';
    if (isProperty == true) {
      subTitle = '共 ${getTypeNumber()} 种';
    } else {
      if ((materialType ?? 0) == 2) {
        // 物资分类
        subTitle = '共 ${getCategoryNumber()} 类';
      } else if ((materialType ?? 0) == 3) {
        // 采购单
        subTitle = '共 ${getTypeNumber()} 种';
      } else {
        // 物资
        subTitle = '共 ${getTypeNumber()} 种  总数量 ${getNumber()}';
      }
    }
    return Text(subTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66));
  }

  /// listview
  Widget listview() {
    if (materialType == 2) {
      // 分类列表
      return classifyView();
    } else if (materialType == 3) {
      // 采购单物资
      return purchaseView();
    } else if (materialType == 4) {
      /// 资产维保
      return propertyView();
    } else {
      // 物资列表
      return materialListView();
    }
  }

  /// 物资列表
  Widget materialListView() {
    return SCAddEntryAllMaterialView(
      hideMaterialNumTextField: hideMaterialNumTextField,
      list: list,
      isReturnEntry: isReturnEntry,
      isProperty: isProperty,
      deleteAction: (int index) {
        deleteAction?.call(index);
      },
      updateNumAction: (int index, int value) {
        updateNumAction?.call(index, value);
      },
      noNeedReturnAction: (int index, bool status) {
        noNeedReturnAction?.call(index, status);
      }
    );
  }

  /// 物资分类列表
  Widget classifyView() {
    return SCAllCategoryListView(
      list: categoryList ?? [],
      deleteAction: (int index) {
        deleteAction?.call(index);
      },
    );
  }

  /// 采购单物资列表
  Widget purchaseView() {
    return SCAddEntryAllMaterialView(
      hideMaterialNumTextField: true,
      list: list,
      isReturnEntry: false,
      isProperty: false,
      deleteAction: (int index) {
        deleteAction?.call(index);
      },
    );
  }

  /// 资产维保列表
  Widget propertyView() {
    bool unifyCompany = propertyMap['unifyCompany'];
    bool unifyContent = propertyMap['unifyContent'];
    String company = propertyMap['company'];
    String content = propertyMap['content'];
    return DecoratedBox(decoration: BoxDecoration(
      color: SCColors.color_FFFFFF,
      borderRadius: BorderRadius.circular(4.0)
    ), child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SCUnifyPropertyInfoView(
          unifyCompany: unifyCompany,
          unifyContent: unifyContent,
          company: company,
          content: content,
          companyAction: (String value){
            propertyCompanyAction?.call(value);
          },
          contentAction: (String value) {
            propertyContentAction?.call(value);
          },
          unifyCompanyAction: (bool value){
            unifyPropertyCompanyAction?.call(value);
          },
          unifyContentAction: (bool value) {
            unifyPropertyContentAction?.call(value);
          },
        ),
        SCAddEntryAllMaterialView(
            hideMaterialNumTextField: hideMaterialNumTextField,
            list: list,
            isReturnEntry: isReturnEntry,
            isProperty: isProperty,
            isPropertyMaintenance: true,
            deleteAction: (int index) {
              deleteAction?.call(index);
            },
            updateNumAction: (int index, int value) {
              updateNumAction?.call(index, value);
            },
            noNeedReturnAction: (int index, bool status) {
              noNeedReturnAction?.call(index, status);
            }
        )
      ],
    ),);
  }

  Widget cell() {
    return Container(
      height: 100,
      color: SCColors.color_FFFFFF,
    );
  }

  /// 获取种类
  int getTypeNumber() {
    return list.length;
  }

  /// 获取数量
  int getNumber() {
    int count = 0;
    for (SCMaterialListModel model in list) {
      count += model.localNum ?? 0;
    }
    return count;
  }

  /// 分类
  int getCategoryNumber() {
    return categoryList?.length ?? 0;
  }
}
