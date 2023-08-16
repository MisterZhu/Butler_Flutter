import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../Constants/sc_asset.dart';

class ComInfoListFloldView extends StatefulWidget {

  List list;

  /// 左侧标题icon点击
  final Function(String value, int index)? leftAction;

  /// 右侧内容icon点击
  final Function(String value, int index)? rightAction;



  ComInfoListFloldView({Key? key,required this.list,this.leftAction,this.rightAction}) : super(key: key);

  @override
  State<ComInfoListFloldView> createState() => _ComInfoListFloldViewState();
}

class _ComInfoListFloldViewState extends State<ComInfoListFloldView> {


   var count = 0;
   List data=[];
   bool isShowFold = false;
   bool isFold = false;

   @override
   void initState(){
     super.initState();
     if(widget.list.length>4){
       data = widget.list.sublist(0,4);
       isShowFold = true;
     }else{
       data = widget.list;
       isShowFold = false;
     }

   }



  @override
  Widget build(BuildContext context) {
    count  = isShowFold ? (data.length+1):data.length;
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [body(context)],
      ),
    );
  }


  /// body
  Widget body(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 12.0,
          );
        },
        itemCount: count);
  }

  Widget getCell(int index) {
    if(isShowFold && index == count-1) {
       return showFoldView();
    }else{
      SCUIDetailCellModel model = widget.list[index];
    if (model.type == 2) {
        return titleCell(model, index);
    } if(model.type == 7){
        return infoCell(model, index);
      }else if (model.type == 5) {
        return contentCell(model, index);
      }else{
        return const SizedBox(
          height: 12.0,
        );
      }
    }
  }

   /// 标题
   Widget titleCell(SCUIDetailCellModel model, int index) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 12.0),
       child: SCTitleCell(
         leftIcon: model.leftIcon,
         rightIcon: model.rightIcon,
         title: model.title,
         titleColor: model.titleColor,
         content: model.content,
         contentColor: model.contentColor,
         leftAction: () {
           widget.leftAction?.call(model.subTitle ?? '', index);
         },
         rightAction: () {
           widget.rightAction?.call(model.subContent ?? '', index);
         },
       ),
     );
   }



   /// 内容
   Widget contentCell(SCUIDetailCellModel model, int index) {
     return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
         child: Text(
           model.content ??'',
           maxLines: model.maxLength,
           overflow: TextOverflow.ellipsis,
           style: const TextStyle(
               fontSize: SCFonts.f16,
               fontWeight: FontWeight.w500,
               color: SCColors.color_1B1D33),
         ));
   }
  
  Widget showFoldView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        InkWell(
          onTap: (){
              setState((){
                isFold = !isFold;
                if(isFold){
                  data = widget.list;
                }else{
                  data = widget.list.sublist(0,4);
                }
              });
          },
          child:Text(isFold?"收起":"展开", style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              height: 1.3,
              color: Color(0xFF8D8E99))),
        ),
        Image.asset(
          isFold? SCAsset.iconArrowTop:SCAsset.iconArrowBottom,
          width: 15.0,
          height: 15.0,
        )
      ],
    );
  }

  /// 信息
  Widget infoCell(SCUIDetailCellModel model, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SCTextCell(
          title: model.title,
          titleColor: model.titleColor,
          titleFontSize: model.titleFontSize,
          content: model.content,
          contentColor: model.contentColor,
          contentFontSize: model.contentFontSize,
          leftIcon: model.leftIcon,
          rightIcon: model.rightIcon,
          maxLength: model.maxLength,
          leftAction: () {
            widget.leftAction?.call(model.subTitle ?? '', index);
          },
          rightAction: () {
            widget.rightAction?.call(model.subContent ?? '', index);
          },
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    data.clear(); //页面销毁主动释放内存
  }



}


