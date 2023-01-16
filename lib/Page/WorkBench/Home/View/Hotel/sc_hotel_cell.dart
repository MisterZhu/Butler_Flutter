import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_hotel_order_model.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';

/// 酒店cell

class SCHotelCell extends StatelessWidget {

  const SCHotelCell({Key? key, required this.model, this.callAction, this.doneAction}) : super(key: key);

  final SCHotelOrderModel model;

  /// 打电话
  final Function(String phone)? callAction;

  /// 完成
  final Function(SCHotelOrderModel model)? doneAction;

  @override
  Widget build(BuildContext context) {
    return view();
  }

  /// container
  Widget view() {
    return Container(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        children: [
          const SizedBox(
            height: 14.0,
          ),
          titleView(),
          const SizedBox(
            height: 14.0,
          ),
          roomInfoView(),
          const SizedBox(
            height: 12.0,
          ),
          roomAddressView(),
          const SizedBox(
            height: 12.0,
          ),
          line(),
          roomDealView()
        ],
      ),
    );
  }

  /// title
  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Image.asset(
            SCAsset.iconHotel,
            width: 18.0,
            height: 18.0,
          ),
          const SizedBox(width: 6.0,),
          Expanded(
              child: Text(
            model.hotelName ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33),
          ))
        ],
      ),
    );
  }

  /// 房间信息
  Widget roomInfoView() {
    List list = model.orderHouseType ?? [];
    if (list.isEmpty) {
      return const SizedBox();
    } else {
      List<Widget> widgetList = [];
      for (int i=0; i<list.length; i++) {
        String title = list[i];
        String gmtStartDate = model.gmtStartDate ?? '';
        String gmtEndDate = model.gmtEndDate ?? '';
        String startDate = '';
        String endDate = '';
        int days = model.duration ?? 0;
        String startWeekDay = '';
        String endWeekDay = '';

        if (gmtStartDate == '') {
          startDate = '';
        } else {
          DateTime startTime = DateTime.parse(model.gmtStartDate ?? '');
          startWeekDay = SCDateUtils.getShortWeekday(weekday: startTime.weekday);
          startDate = SCDateUtils.transformDate(dateTime: DateTime.parse(model.gmtStartDate ?? ''), formats: ['mm', '月', 'dd', '日']);
        }

        if (gmtEndDate == '') {
          endDate = '';
        } else {
          DateTime endTime = DateTime.parse(model.gmtEndDate ?? '');
          endWeekDay = SCDateUtils.getShortWeekday(weekday: endTime.weekday);
          endDate = SCDateUtils.transformDate(dateTime: DateTime.parse(model.gmtEndDate ?? ''), formats: ['mm', '月', 'dd', '日']);
        }

        if (i == list.length - 1) {
          widgetList.add(roomInfoSubView(title: title, startDate: startDate, startWeekday: startWeekDay, endDate: endDate, endWeekday: endWeekDay, days: days));
        } else {
          widgetList.add(roomInfoSubView(title: title, startDate: startDate, startWeekday: startWeekDay, endDate: endDate, endWeekday: endWeekDay, days: days));
          widgetList.add(const SizedBox(
            height: 10.0,
          ));
        }
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: widgetList,
        ),
      );
    }
  }

  /// 房间信息subView
  Widget roomInfoSubView({required String title, required String startDate, required String startWeekday, required String endDate,required String endWeekday, required int days}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        roomTitleView(title: title),
        const SizedBox(
          height: 10.0,
        ),
        roomLiveDateView(startDate: startDate, startWeekday: startWeekday, endDate: endDate, endWeekday: endWeekday, days: days),
      ],
    );
  }

  /// 房间-title
  Widget roomTitleView({required String title}) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33),
    );
  }

  /// 房间-入住、离店日期
  Widget roomLiveDateView({required String startDate, required String startWeekday, required String endDate, required String endWeekday, required int days}) {
    return Row(
      children: [
        RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: startDate,
                style: const TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w500,
                    color: SCColors.color_1B1D33),
                children: [
                  TextSpan(
                    text: '($startWeekday入住)',
                    style: const TextStyle(
                        fontSize: SCFonts.f12,
                        fontWeight: FontWeight.w500,
                        color: SCColors.color_5E5F66),
                  )
                ])),
        const SizedBox(
          width: 8.0,
        ),
        Row(
          children: [
            Container(
              width: 8.0,
              height: 1.0,
              color: SCColors.color_4285F4,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    width: 1.0,
                    color: SCColors.color_4285F4,
                  )),
              child: Container(
                height: 20.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${model.duration}晚',
                  style: const TextStyle(
                      fontSize: SCFonts.f12,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_4285F4),
                ),
              ),
            ),
            Container(
              width: 8.0,
              height: 1.0,
              color: SCColors.color_4285F4,
            ),
          ],
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
            child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: endDate,
                    style: const TextStyle(
                        fontSize: SCFonts.f16,
                        fontWeight: FontWeight.w500,
                        color: SCColors.color_1B1D33),
                    children: [
                      TextSpan(
                        text: '($endWeekday离店)',
                        style: const TextStyle(
                            fontSize: SCFonts.f12,
                            fontWeight: FontWeight.w500,
                            color: SCColors.color_5E5F66),
                      )
                    ]))),
      ],
    );
  }

  /// 房间-地址
  Widget roomAddressView() {
    String address = model.customerSource ?? '';
    String userName = model.customerName ?? '';
    String phone = model.customerMobileNum ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Image.asset(
            SCAsset.iconAddress,
            width: 14.0,
            height: 14.0,
          ),
          const SizedBox(
            width: 3.0,
          ),
          Expanded(
              child: Text(
            address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66),
          )),
          CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 16.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    SCAsset.iconPhone,
                    width: 16.0,
                    height: 16.0,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: SCFonts.f12,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_5E5F66),
                  )
                ],
              ),
              onPressed: () {
                callAction?.call(phone);
              })
        ],
      ),
    );
  }

  /// line
  Widget line() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 1.0,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 房间-立即处理
  Widget roomDealView() {
    return Container(
      height: 64.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.center,
      child: Row(
        children: [
          const Expanded(
              child: Text(
            '2022-11-14 12:00:00',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66),
          )),
          SizedBox(
            width: 100.0,
            height: 40.0,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(4.0),
              padding: EdgeInsets.zero,
                minSize: 40.0,
                color: SCColors.color_4285F4,
                child: const Text(
                  '立即处理',
                  style: TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_FFFFFF),
                ),
                onPressed: () {
                doneAction?.call(model);
                }),
          )
        ],
      ),
    );
  }
}
