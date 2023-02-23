/// 入库-enum

class SCMaterialEntryEnum {
  /// 单据状态
  static int orderStatusWaitSubmit = 0;  // 待提交
  static int orderStatusWaitApprove = 1;  // 待审批
  static int orderStatusApproving = 2;  // 审批中
  static int orderStatusRefuse = 3;  // 已拒绝
  static int orderStatusReject = 4;  // 已驳回
  static int orderStatusWithdraw = 5;  // 已撤回
  static int orderStatusDone = 6;  // 已入库
}