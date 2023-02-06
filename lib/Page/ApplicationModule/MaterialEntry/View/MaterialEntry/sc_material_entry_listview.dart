
import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_entry_cell.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';

/// 物资入库listview

class SCMaterialEntryListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 3);
  }

  /// cell
  Widget cell(int index) {
    return SCMaterialEntryCell(
      detailTapAction: () {
        SCRouterHelper.pathPage(SCRouterPath.materialDetailPage, null);
      },
    );
  }

}
