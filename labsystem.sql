/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : labsystem

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 18/11/2025 21:34:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for approvals
-- ----------------------------
DROP TABLE IF EXISTS `approvals`;
CREATE TABLE `approvals`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `biz_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务类型（PO=采购单/BR=借用单/RS=预约单/MO=维护单/SC=盘点单）',
  `biz_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务单据ID（关联对应业务表主键）',
  `step_no` int NOT NULL COMMENT '审批步骤序号（如1/2/3）',
  `approver_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '审批人ID：关联users.id',
  `status` enum('pending','approved','rejected','skipped') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT '审批状态：待审批/通过/驳回/跳过',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批意见',
  `acted_at` datetime NULL DEFAULT NULL COMMENT '审批操作时间',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审批任务创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_approval_biz`(`biz_type` ASC, `biz_id` ASC) USING BTREE,
  INDEX `idx_approval_approver`(`approver_id` ASC, `status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通用审批流任务表（支持多业务复用）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of approvals
-- ----------------------------
INSERT INTO `approvals` VALUES ('16', 'MO', '1', 1, '2', 'approved', '同意保养，费用合规', '2024-06-01 09:30:00', '2025-10-11 18:50:46');
INSERT INTO `approvals` VALUES ('17', 'MO', '6', 1, '1', 'rejected', '无法修复，建议报废', '2024-06-05 15:30:00', '2025-10-11 18:50:46');
INSERT INTO `approvals` VALUES ('18', 'MO', '9', 1, '4', 'approved', '同意检定，确保精度', '2024-06-01 09:00:00', '2025-10-11 18:50:46');
INSERT INTO `approvals` VALUES ('19', 'MO', '7', 1, '5', 'pending', NULL, NULL, '2025-10-11 18:50:46');
INSERT INTO `approvals` VALUES ('20', 'MO', '8', 1, '6', 'approved', '同意取消，误报故障', '2024-06-06 10:00:00', '2025-10-11 18:50:46');
INSERT INTO `approvals` VALUES ('4c3af55b-6575-48b9-acac-7f97a6b006cc', 'RS', 'ae9f5516-604a-4a6c-9280-30abdd8f4c79', 1, '10', 'pending', NULL, NULL, '2025-11-18 20:37:12');
INSERT INTO `approvals` VALUES ('73039e56-588e-46b8-83a4-332c68576c15', 'BR', '9fde3e93-8a0f-41b2-8301-64b47a73ea6e', 1, '10', 'pending', NULL, NULL, '2025-11-18 20:51:37');
INSERT INTO `approvals` VALUES ('7574d036-9821-46b8-8cc2-ccafa37b0f52', 'PO', 'TEMPLATE', 1, '1', 'approved', NULL, '2025-11-17 20:25:05', '2025-10-19 21:49:37');
INSERT INTO `approvals` VALUES ('89dfef83-6fdb-44da-b787-bbd7001088fd', 'PO', 'TEMPLATE', 2, '12', 'pending', '审批模板步骤', NULL, '2025-10-19 21:49:37');
INSERT INTO `approvals` VALUES ('8b1a3426-5993-4b72-9f94-70a1c3d4945c', 'RS', 'TEMPLATE', 3, '16', 'pending', '审批模板步骤', NULL, '2025-10-19 21:48:08');
INSERT INTO `approvals` VALUES ('b6a2c71d-b886-432f-a25a-153a986ce2c6', 'BR', 'bee52f71-82b2-4b41-b75f-d2c0d03b0234', 1, '10', 'pending', NULL, NULL, '2025-11-18 20:32:53');
INSERT INTO `approvals` VALUES ('cf287cfd-df2d-45c3-9116-a80793b98dc2', 'RS', 'TEMPLATE', 1, '16', 'pending', '审批模板步骤', NULL, '2025-10-19 21:48:08');
INSERT INTO `approvals` VALUES ('e8adc965-843c-4b20-99cb-daabd5a341a6', 'BR', 'TEMPLATE', 2, '16', 'pending', '审批模板步骤', NULL, '2025-10-17 20:34:20');
INSERT INTO `approvals` VALUES ('ee9f2bcb-1574-4d78-bba1-290f2b2fe7ff', 'RS', 'TEMPLATE', 2, '16', 'pending', '审批模板步骤', NULL, '2025-10-19 21:48:08');
INSERT INTO `approvals` VALUES ('f77e54aa-988f-4a9a-bd3d-920475284a6b', 'BR', 'TEMPLATE', 1, '16', 'pending', '审批模板步骤', NULL, '2025-10-17 20:34:20');

-- ----------------------------
-- Table structure for audit_logs
-- ----------------------------
DROP TABLE IF EXISTS `audit_logs`;
CREATE TABLE `audit_logs`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `actor_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作者ID：关联users.id',
  `action` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作动作（CREATE/UPDATE/DELETE/LOGIN/APPROVE等）',
  `object_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作对象类型（如users/items/stock_batches）',
  `object_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作对象ID（对应对象表主键）',
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间戳',
  `before_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '操作前数据快照（JSON格式）',
  `after_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '操作后数据快照（JSON格式）',
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作者IP地址',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作备注（如批量更新/手动调整）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_audit_timestamp`(`timestamp` ASC) USING BTREE,
  INDEX `idx_audit_actor`(`actor_id` ASC) USING BTREE,
  INDEX `idx_audit_object`(`object_type` ASC, `object_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审计日志表（不可变更，全量留痕）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of audit_logs
-- ----------------------------
INSERT INTO `audit_logs` VALUES ('03a2cade-59a2-4b2a-b0bd-ec4049312d44', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7bbc-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:38:06', '{\"物资编码\":\"EQP001\",\"批次号\":\"-\",\"原实际数量\":1.0,\"原差异\":0.000}', '{\"物资编码\":\"EQP001\",\"批次号\":\"-\",\"新实际数量\":1.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:38:06\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('03d526b4-bb48-4d40-ad2e-7a61b42481d6', '2', 'CREATE_APPROVAL_TEMPLATE', 'approvals', 'RS', '2025-08-18 19:16:48', NULL, '{\"biz_type\":\"RS\",\"step_count\":2}', NULL, NULL);
INSERT INTO `audit_logs` VALUES ('0580133b-99e2-46a0-b4b7-54b5ff17740c', '18', 'STOCK_COUNT_START_SUCCESS', 'stock_counts', 'SC-20251118-001', '2025-11-18 18:09:40', '{\"盘点编号\":\"SC-20251118-001\",\"原状态\":\"已下发\"}', '{\"盘点编号\":\"SC-20251118-001\",\"新状态\":\"盘点中\",\"开始时间\":\"2025-11-18 18:09:40\",\"操作人\":\"王仓库\"}', '', '手动开始盘点，允许录入实际数量');
INSERT INTO `audit_logs` VALUES ('05ac684f-2dbc-44f3-84aa-180bd8cb947a', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-011', '2025-11-18 18:34:18', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-011\",\"盘点范围\":\"WH001-主仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:34:18\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('08ebe127-0176-46ed-aa35-ca6a7b3ca758', '2', 'DELETE_APPROVAL_TEMPLATE', 'approvals', 'SC', '2025-10-18 13:39:28', NULL, '{\"biz_type\":\"SC\"}', NULL, NULL);
INSERT INTO `audit_logs` VALUES ('0ee97845-f2b0-42a1-85ec-29b99d9171b3', '2', 'CREATE_APPROVAL_TEMPLATE', 'approvals', 'PO', '2025-10-19 21:49:37', NULL, '{\"biz_type\":\"PO\",\"step_count\":2}', NULL, NULL);
INSERT INTO `audit_logs` VALUES ('10890db8-66e7-48b0-89f6-76f4ed396db5', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7265-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:26', '{\"物资编码\":\"CHEM003\",\"批次号\":\"CHEM003-B202404\",\"原实际数量\":6.0,\"原差异\":0.000}', '{\"物资编码\":\"CHEM003\",\"批次号\":\"CHEM003-B202404\",\"新实际数量\":6.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:26\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('11d6ee51-d6a5-4cb9-8702-52916e2eb2ff', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d77c8-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:20', '{\"物资编码\":\"CONS004\",\"批次号\":\"CONS004-B202402\",\"原实际数量\":15.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS004\",\"批次号\":\"CONS004-B202402\",\"新实际数量\":15.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:20\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('1350aa19-329c-4bf6-a077-41db282f85ac', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d732a-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:23', '{\"物资编码\":\"CHEM004\",\"批次号\":\"CHEM004-B202404\",\"原实际数量\":4.0,\"原差异\":0.000}', '{\"物资编码\":\"CHEM004\",\"批次号\":\"CHEM004-B202404\",\"新实际数量\":4.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:23\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('1561b880-333f-45ef-bc8a-66b0525110e3', '18', 'STOCK_IN_FAILED', 'stock_transactions', 'IN-20251118174629-9c25b710', '2025-11-18 17:46:29', '{\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"尝试入库库位\":\"默认货位\"}', '{\"失败原因\":\"Cannot add or update a child row: a foreign key constraint fails (`labsystem`.`stock_batches`, CONSTRAINT `fk_stock_batch_location` FOREIGN KEY (`current_location_id`) REFERENCES `locations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE)\",\"失败时间\":\"2025-11-18 17:46:29\",\"异常堆栈\":\"   在 MySql.Data.MySqlClient.MySqlStream.<ReadPacketAsync>d__30.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\\r\\n   在 MySql.Data.MySqlClient.NativeDriver.<GetResultAsync>d__45.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerService\"}', '', '采购单物资入库操作失败（已回滚事务）');
INSERT INTO `audit_logs` VALUES ('165c12ba-3647-4e4c-bce6-cfbf63822705', '18', 'PO_STATUS_UPDATE', 'purchase_orders', 'po_test_001', '2025-11-18 20:06:47', '{\"原状态\":\"partially_received\"}', '{\"新状态\":\"partially_received\",\"未完全入库明细数\":2}', '', '采购单部分入库后更新状态');
INSERT INTO `audit_logs` VALUES ('1aeb3527-a795-4173-9157-c382d73a627b', '18', 'STOCK_BATCH_CLEAN', 'stock_batches', 'e2f61a2d-c46c-11f0-a379-00ff9a0531b3', '2025-11-18 18:54:16', '{\"库位ID\":\"2903c3d4-c46b-11f0-a379-00ff9a0531b3\",\"库位名称\":\"123(123)\",\"清理前批次数量\":1,\"涉及批次号\":\"CONS001-B202401\",\"库存状态\":\"数量为0（可能包含危化品）\"}', '{\"清理结果\":\"成功清理1个空批次\",\"清理时间\":\"2025-11-18 18:54:16\"}', '', '删除库位前自动清理空批次（含可能的危化品批次）');
INSERT INTO `audit_logs` VALUES ('1b6ce3c9-5fb5-4c87-8c7a-ec003f1d4a7a', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d74b0-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:38:02', '{\"物资编码\":\"CONS002\",\"批次号\":\"CONS002-B202401\",\"原实际数量\":40.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS002\",\"批次号\":\"CONS002-B202401\",\"新实际数量\":40.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:38:02\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('1f8ae759-43cd-4696-921f-ad74dc409e5c', '18', 'STOCK_COUNT_START_SUCCESS', 'stock_counts', 'SC-20251118-010', '2025-11-18 20:29:01', '{\"盘点编号\":\"SC-20251118-010\",\"原状态\":\"已下发\"}', '{\"盘点编号\":\"SC-20251118-010\",\"新状态\":\"盘点中\",\"开始时间\":\"2025-11-18 20:29:01\",\"操作人\":\"王仓库\"}', '', '手动开始盘点，允许录入实际数量');
INSERT INTO `audit_logs` VALUES ('281f7fa7-c560-47ac-bcf0-beec19046d94', '18', 'STOCK_COUNT_ISSUE_SUCCESS', 'stock_counts', 'SC-20251118-002', '2025-11-18 18:08:08', '{\"盘点编号\":\"SC-20251118-002\",\"原状态\":\"草稿\",\"明细数量\":\"0（未生成）\"}', '{\"盘点编号\":\"SC-20251118-002\",\"新状态\":\"已下发\",\"生成明细数量\":0,\"下发时间\":\"2025-11-18 18:08:08\",\"操作人\":\"王仓库\"}', '', '手动下发盘点任务，生成库存明细');
INSERT INTO `audit_logs` VALUES ('2b685125-dcf4-4331-9f82-c2dee03ef3d5', '18', 'STOCK_COUNT_EXPORT', 'stock_counts', 'SC-20251118-011', '2025-11-18 18:38:32', '{\"盘点编号\":\"SC-20251118-011\",\"明细数量\":21}', '{\"导出时间\":\"2025-11-18 18:38:32\",\"导出明细数量\":21,\"操作人\":\"王仓库\"}', '', '手动导出盘点任务明细数据');
INSERT INTO `audit_logs` VALUES ('2c372263-2168-4106-9764-9d0fd1d64c0d', '18', 'STOCK_IN_FAILED', 'stock_transactions', 'IN-20251118174639-b6dffb1a', '2025-11-18 17:46:39', '{\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"尝试入库库位\":\"默认货位\"}', '{\"失败原因\":\"Cannot add or update a child row: a foreign key constraint fails (`labsystem`.`stock_batches`, CONSTRAINT `fk_stock_batch_location` FOREIGN KEY (`current_location_id`) REFERENCES `locations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE)\",\"失败时间\":\"2025-11-18 17:46:39\",\"异常堆栈\":\"   在 MySql.Data.MySqlClient.MySqlStream.<ReadPacketAsync>d__30.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\\r\\n   在 MySql.Data.MySqlClient.NativeDriver.<GetResultAsync>d__45.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerService\"}', '', '采购单物资入库操作失败（已回滚事务）');
INSERT INTO `audit_logs` VALUES ('2d37a33d-8b55-4d32-8b92-5e06851ca06d', '2', 'add_location', 'locations', 'ec5bf783-bc72-4cef-9ae8-1da37698b211', '2025-08-19 19:19:32', NULL, '{\"code\":\"efr\",\"name\":\"rew\",\"type\":\"zone\"}', NULL, NULL);
INSERT INTO `audit_logs` VALUES ('2ed26e45-aed2-40e7-9553-1c9a03f0c171', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7949-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:36', '{\"物资编码\":\"CONS005\",\"批次号\":\"CONS005-B202403\",\"原实际数量\":10.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS005\",\"批次号\":\"CONS005-B202403\",\"新实际数量\":10.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:36\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('330b6bf3-ef57-414d-852d-8cc6a5bba26e', '18', 'PO_STATUS_UPDATE', 'purchase_orders', 'po_test_001', '2025-11-18 20:06:16', '{\"原状态\":\"partially_received\"}', '{\"新状态\":\"partially_received\",\"未完全入库明细数\":2}', '', '采购单部分入库后更新状态');
INSERT INTO `audit_logs` VALUES ('333ff195-4e93-4ea0-a951-1c6854443352', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7c8f-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:01', '{\"物资编码\":\"CONS001\",\"批次号\":\"BATCH-20251118-859e0f\",\"原实际数量\":10.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS001\",\"批次号\":\"BATCH-20251118-859e0f\",\"新实际数量\":10.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:01\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('3a3e2e38-b35c-457f-91ab-84b6a0612d6f', '2', 'add_lab_member', 'lab_memberships', '15_16', '2025-10-18 13:38:52', NULL, '{\"lab_id\":\"15\",\"user_id\":\"16\",\"username\":\"Che Sze Kwan\"}', NULL, '添加用户到实验室');
INSERT INTO `audit_logs` VALUES ('3b7de16b-728c-4e32-bf04-202c1ba9ee73', '18', 'STOCK_IN', 'stock_transactions', 'IN-20251118190750-f2b548f6', '2025-11-18 19:07:50', '{\"采购单ID\":\"4\",\"采购单号\":\"PO2024004\",\"入库前状态\":\"待入库\",\"待入库物资数量\":1}', '{\"入库标识\":\"IN-20251118190750-f2b548f6\",\"采购单ID\":\"4\",\"采购单号\":\"PO2024004\",\"入库仓库\":\"主仓库\",\"入库库位\":\"培养皿货位\",\"入库时间\":\"2025-11-18 19:07:50\",\"入库物资明细\":[{\"物资编码\":\"EQP002\",\"物资名称\":\"电子天平\",\"入库数量\":\"1\",\"单位\":\"台\"}],\"操作人\":\"123\"}', '', '采购单物资入库（通过采购单关联）');
INSERT INTO `audit_logs` VALUES ('3dcc692a-e65f-4530-ad2e-b59e9393d449', '2', 'CREATE_APPROVAL_TEMPLATE', 'approvals', 'BR', '2025-10-17 20:34:20', NULL, '{\"biz_type\":\"BR\",\"step_count\":2}', NULL, NULL);
INSERT INTO `audit_logs` VALUES ('45685dae-c930-4eaa-9dfd-95a23abfaea5', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-012', '2025-11-18 20:29:25', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-012\",\"盘点范围\":\"WH001-主仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 20:29:25\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('475c0b69-d094-4d78-980a-93b5308c9d52', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7abc-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:36:13', '{\"物资编码\":\"CONS007\",\"批次号\":\"CONS007-B202404\",\"原实际数量\":34.0,\"原差异\":-1.000}', '{\"物资编码\":\"CONS007\",\"批次号\":\"CONS007-B202404\",\"新实际数量\":34.0,\"新差异\":-1.000,\"修改时间\":\"2025-11-18 18:36:13\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('4b4308a3-7bb0-4043-912d-c5515af57376', '18', 'STOCK_COUNT_ISSUE_SUCCESS', 'stock_counts', 'SC-20251118-001', '2025-11-18 18:09:37', '{\"盘点编号\":\"SC-20251118-001\",\"原状态\":\"草稿\",\"明细数量\":\"0（未生成）\"}', '{\"盘点编号\":\"SC-20251118-001\",\"新状态\":\"已下发\",\"生成明细数量\":0,\"下发时间\":\"2025-11-18 18:09:37\",\"操作人\":\"王仓库\"}', '', '手动下发盘点任务，生成库存明细');
INSERT INTO `audit_logs` VALUES ('4cb69f3b-3ea8-4c57-906e-ffec6281c985', '18', 'STOCK_COUNT_EXPORT', 'stock_counts', 'SC2024003', '2025-11-18 18:05:18', '{\"盘点编号\":\"SC2024003\",\"明细数量\":0}', '{\"导出时间\":\"2025-11-18 18:05:18\",\"导出明细数量\":0,\"操作人\":\"王仓库\"}', '', '手动导出盘点任务明细数据');
INSERT INTO `audit_logs` VALUES ('4f7fa183-2fe7-4aff-a3e8-b90d9014416d', '18', 'STOCK_IN', 'stock_transactions', 'IN-20251118172919-94028e80', '2025-11-18 17:29:19', '{\"采购单ID\":\"2\",\"采购单号\":\"PO2024002\",\"入库前状态\":\"待入库\",\"待入库物资数量\":4}', '{\"入库标识\":\"IN-20251118172919-94028e80\",\"采购单ID\":\"2\",\"采购单号\":\"PO2024002\",\"入库仓库\":\"主仓库\",\"入库库位\":\"培养皿货位\",\"入库时间\":\"2025-11-18 17:29:19\",\"入库物资明细\":[{\"物资编码\":\"CONS005\",\"物资名称\":\"玻璃烧杯\",\"入库数量\":\"20.000\",\"单位\":\"箱\"},{\"物资编码\":\"CONS006\",\"物资名称\":\"磁力搅拌子\",\"入库数量\":\"32.000\",\"单位\":\"包\"},{\"物资编码\":\"CONS007\",\"物资名称\":\"一次性丁腈手套\",\"入库数量\":\"50.000\",\"单位\":\"盒\"},{\"物资编码\":\"CONS001\",\"物资名称\":\"一次性离心管\",\"入库数量\":\"10.000\",\"单位\":\"盒\"}],\"操作人\":\"123\"}', '', '采购单物资入库（通过采购单关联）');
INSERT INTO `audit_logs` VALUES ('501dfe8e-2d09-43a4-9648-e3db0e375a0a', '18', 'STOCK_COUNT_EXPORT', 'stock_counts', 'SC2024002', '2025-11-18 18:05:10', '{\"盘点编号\":\"SC2024002\",\"明细数量\":4}', '{\"导出时间\":\"2025-11-18 18:05:10\",\"导出明细数量\":4,\"操作人\":\"王仓库\"}', '', '手动导出盘点任务明细数据');
INSERT INTO `audit_logs` VALUES ('55f6becd-ba97-47ac-86a9-44f36d7d4e37', '18', 'STOCK_IN_FAILED', 'stock_transactions', 'IN-20251118182349-c31b0d6a', '2025-11-18 18:23:49', '{\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"尝试入库库位\":\"默认货位\"}', '{\"失败原因\":\"Cannot add or update a child row: a foreign key constraint fails (`labsystem`.`stock_batches`, CONSTRAINT `fk_stock_batch_location` FOREIGN KEY (`current_location_id`) REFERENCES `locations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE)\",\"失败时间\":\"2025-11-18 18:23:49\",\"异常堆栈\":\"   在 MySql.Data.MySqlClient.MySqlStream.<ReadPacketAsync>d__30.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\\r\\n   在 MySql.Data.MySqlClient.NativeDriver.<GetResultAsync>d__45.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerService\"}', '', '采购单物资入库操作失败（已回滚事务）');
INSERT INTO `audit_logs` VALUES ('5c5bb2e7-c8c1-4050-985a-9c937b11db17', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-004', '2025-11-18 18:13:29', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-004\",\"盘点范围\":\"WH001-主仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:13:29\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('5e05308f-6166-46e8-a3f8-4e5f5243cbd8', '1', 'APPROVE', 'approvals', '7574d036-9821-46b8-8cc2-ccafa37b0f52', '2025-11-17 20:25:05', '{\"Id\":\"7574d036-9821-46b8-8cc2-ccafa37b0f52\",\"BizType\":\"PO\",\"BizId\":\"TEMPLATE\",\"StepNo\":1,\"ApproverId\":\"1\",\"Status\":0,\"Comment\":\"审批模板步骤\",\"ActedAt\":null}', '{\"Id\":\"7574d036-9821-46b8-8cc2-ccafa37b0f52\",\"BizType\":\"PO\",\"BizId\":\"TEMPLATE\",\"StepNo\":1,\"ApproverId\":\"1\",\"Status\":1,\"Comment\":\"\",\"ActedAt\":\"2025-11-17T20:25:05.1179035+08:00\"}', '192.168.88.1', NULL);
INSERT INTO `audit_logs` VALUES ('623a658f-3ef4-403b-baab-992ca4acf65c', '18', 'STOCK_COUNT_START_SUCCESS', 'stock_counts', 'SC-20251118-011', '2025-11-18 18:39:55', '{\"盘点编号\":\"SC-20251118-011\",\"原状态\":\"已下发\"}', '{\"盘点编号\":\"SC-20251118-011\",\"新状态\":\"盘点中\",\"开始时间\":\"2025-11-18 18:39:55\",\"操作人\":\"王仓库\"}', '', '手动开始盘点，允许录入实际数量');
INSERT INTO `audit_logs` VALUES ('6370456e-7bea-4d11-90e0-a48dcc0e5f61', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-005', '2025-11-18 18:14:32', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-005\",\"盘点范围\":\"WH001-主仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:14:32\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('66990c40-aae7-4e26-b9e8-a9b52e25b8fd', '10', 'BORROW_CREATE', 'borrow_orders', 'bee52f71-82b2-4b41-b75f-d2c0d03b0234', '2025-11-18 20:32:53', NULL, '{\"借用单号\":\"BR-20251118-001\",\"所属实验室\":\"LAB010-细胞培养实验室2\",\"借用用途\":\"教学用品\",\"申请物资总数\":1,\"预计归还日期\":\"2025-11-25\"}', '本地', '实验人员提交借用申请，等待审批');
INSERT INTO `audit_logs` VALUES ('69705cfc-e25d-4a58-aba5-fc837f92828f', '18', 'STOCK_IN', 'stock_transactions', 'IN-20251118200647-fd08c66c', '2025-11-18 20:06:47', '{\"采购单ID\":\"po_test_001\",\"采购单号\":\"PO-TEST-20240601\",\"入库前状态\":\"待入库\",\"待入库物资数量\":1}', '{\"入库标识\":\"IN-20251118200647-fd08c66c\",\"采购单ID\":\"po_test_001\",\"采购单号\":\"PO-TEST-20240601\",\"入库仓库\":\"主仓库\",\"入库库位\":\"培养皿货位\",\"入库时间\":\"2025-11-18 20:06:47\",\"入库物资明细\":[{\"物资编码\":\"MAT-GLOVE-001\",\"物资名称\":\"一次性丁腈手套\",\"入库数量\":\"3\",\"单位\":\"盒\"}],\"操作人\":\"123\"}', '', '采购单物资入库（通过采购单关联）');
INSERT INTO `audit_logs` VALUES ('6a5018a2-908c-4049-80f8-601c1bf405c0', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7a02-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:58', '{\"物资编码\":\"CONS006\",\"批次号\":\"CONS006-B202403\",\"原实际数量\":12.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS006\",\"批次号\":\"CONS006-B202403\",\"新实际数量\":12.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:58\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('6d717446-f523-44d3-b639-43bca5efd73c', '18', 'LOCATION_DELETE', 'locations', '2903c3d4-c46b-11f0-a379-00ff9a0531b3', '2025-11-18 18:54:17', '{\"库位ID\":\"2903c3d4-c46b-11f0-a379-00ff9a0531b3\",\"库位名称\":\"123(123)\",\"库位编码\":\"未知编码\",\"库位类型\":\"未知类型\",\"父级库位\":\"橡胶耗材货架\",\"状态\":\"启用\"}', '{\"删除结果\":\"成功删除\",\"删除时间\":\"2025-11-18 18:54:17\"}', '', '仓库管理员手动删除库位（已清理空批次和子库位）');
INSERT INTO `audit_logs` VALUES ('778300c3-e85d-4770-83e7-5038af1bb6f4', '18', 'STOCK_IN', 'stock_transactions', 'IN-20251118193809-954c7974', '2025-11-18 19:38:09', '{\"采购单ID\":\"2\",\"采购单号\":\"PO2024002\",\"入库前状态\":\"待入库\",\"待入库物资数量\":2}', '{\"入库标识\":\"IN-20251118193809-954c7974\",\"采购单ID\":\"2\",\"采购单号\":\"PO2024002\",\"入库仓库\":\"主仓库\",\"入库库位\":\"默认货位\",\"入库时间\":\"2025-11-18 19:38:09\",\"入库物资明细\":[{\"物资编码\":\"CONS005\",\"物资名称\":\"玻璃烧杯\",\"入库数量\":\"1\",\"单位\":\"箱\"},{\"物资编码\":\"CONS006\",\"物资名称\":\"磁力搅拌子\",\"入库数量\":\"1\",\"单位\":\"包\"}],\"操作人\":\"123\"}', '', '采购单物资入库（通过采购单关联）');
INSERT INTO `audit_logs` VALUES ('78c169a6-5a91-436d-8cb3-0a6588349ad6', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7642-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:29', '{\"物资编码\":\"123\",\"批次号\":\"123\",\"原实际数量\":50.0,\"原差异\":0.000}', '{\"物资编码\":\"123\",\"批次号\":\"123\",\"新实际数量\":50.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:29\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('7a908334-b7eb-4729-8635-2086b7704b0c', '18', 'STOCK_COUNT_EXPORT', 'stock_counts', 'SC2024001', '2025-11-18 18:05:05', '{\"盘点编号\":\"SC2024001\",\"明细数量\":4}', '{\"导出时间\":\"2025-11-18 18:05:05\",\"导出明细数量\":4,\"操作人\":\"王仓库\"}', '', '手动导出盘点任务明细数据');
INSERT INTO `audit_logs` VALUES ('814efd82-4aff-4929-93fe-ab25623ad537', '2', 'edit_lab_member_role', 'lab_memberships', '15_16', '2025-10-18 13:38:56', '{\"role\":\"普通成员\"}', '{\"role\":\"管理员\"}', NULL, '修改实验室成员角色');
INSERT INTO `audit_logs` VALUES ('8703570f-5a83-434d-abe2-ed47739fdd5f', '18', 'STOCK_COUNT_START_SUCCESS', 'stock_counts', 'SC-20251118-002', '2025-11-18 18:08:15', '{\"盘点编号\":\"SC-20251118-002\",\"原状态\":\"已下发\"}', '{\"盘点编号\":\"SC-20251118-002\",\"新状态\":\"盘点中\",\"开始时间\":\"2025-11-18 18:08:15\",\"操作人\":\"王仓库\"}', '', '手动开始盘点，允许录入实际数量');
INSERT INTO `audit_logs` VALUES ('883cb823-3ff2-4d3a-84fa-65d5be679155', '18', 'STOCK_IN', 'stock_transactions', 'IN-20251118190723-40b14cad', '2025-11-18 19:07:23', '{\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"入库前状态\":\"待入库\",\"待入库物资数量\":1}', '{\"入库标识\":\"IN-20251118190723-40b14cad\",\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"入库仓库\":\"主仓库\",\"入库库位\":\"培养皿货位\",\"入库时间\":\"2025-11-18 19:07:23\",\"入库物资明细\":[{\"物资编码\":\"CONS002\",\"物资名称\":\"移液器吸头\",\"入库数量\":\"1\",\"单位\":\"盒\"}],\"操作人\":\"123\"}', '', '采购单物资入库（通过采购单关联）');
INSERT INTO `audit_logs` VALUES ('89482bf7-19df-4d55-bd15-a49fd531b245', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d70a0-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:13', '{\"物资编码\":\"CHEM001\",\"批次号\":\"CHEM001-B202403\",\"原实际数量\":8.0,\"原差异\":0.000}', '{\"物资编码\":\"CHEM001\",\"批次号\":\"CHEM001-B202403\",\"新实际数量\":8.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:13\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('920c356a-67b6-4447-80de-2f29792ed5b5', '18', 'STOCK_IN', 'stock_transactions', 'IN-20251118200616-a2501e6c', '2025-11-18 20:06:17', '{\"采购单ID\":\"po_test_001\",\"采购单号\":\"PO-TEST-20240601\",\"入库前状态\":\"待入库\",\"待入库物资数量\":1}', '{\"入库标识\":\"IN-20251118200616-a2501e6c\",\"采购单ID\":\"po_test_001\",\"采购单号\":\"PO-TEST-20240601\",\"入库仓库\":\"主仓库\",\"入库库位\":\"培养皿货位\",\"入库时间\":\"2025-11-18 20:06:16\",\"入库物资明细\":[{\"物资编码\":\"MAT-GLOVE-001\",\"物资名称\":\"一次性丁腈手套\",\"入库数量\":\"3\",\"单位\":\"盒\"}],\"操作人\":\"123\"}', '', '采购单物资入库（通过采购单关联）');
INSERT INTO `audit_logs` VALUES ('93c2a2a7-ba86-4390-bad0-0430d47c704e', '18', 'STOCK_COUNT_ISSUE_SUCCESS', 'stock_counts', 'SC-20251118-004', '2025-11-18 18:13:37', '{\"盘点编号\":\"SC-20251118-004\",\"原状态\":\"草稿\",\"明细数量\":\"0（未生成）\"}', '{\"盘点编号\":\"SC-20251118-004\",\"新状态\":\"已下发\",\"生成明细数量\":0,\"下发时间\":\"2025-11-18 18:13:37\",\"操作人\":\"王仓库\"}', '', '手动下发盘点任务，生成库存明细');
INSERT INTO `audit_logs` VALUES ('965587c8-846b-40a9-a961-dbc9c53886d0', '2', 'UPDATE_APPROVAL_TEMPLATE', 'approvals', 'RS', '2025-10-18 13:44:22', NULL, '{\"biz_type\":\"RS\",\"step_count\":3}', NULL, NULL);
INSERT INTO `audit_logs` VALUES ('99f7b618-81f2-4772-baa8-529b5b857fbf', '18', 'STOCK_OUT_SUCCESS', 'stock_transactions', 'TR-20251118-002', '2025-11-18 20:27:38', '{\"出库前状态\":\"待出库\",\"源库位\":null,\"涉及物资数量\":1,\"操作单号\":\"TR-20251118-002\"}', '{\"出库后状态\":\"已完成\",\"源库位\":null,\"出库时间\":\"2025-11-18 20:27:38\",\"出库单号\":\"TR-20251118-002\",\"操作人\":\"123\",\"出库原因\":\"领用（实验室）\",\"出库明细\":[{\"物资编码\":\"CONS003\",\"物资名称\":\"培养皿\",\"规格\":\"90mm，50个/包\",\"批次号\":\"CONS003-B202402\",\"出库数量\":\"1\",\"单位\":\"包\"}]}', '', '手动执行出库操作（扣减库存并记录事务）');
INSERT INTO `audit_logs` VALUES ('9accc299-d303-450d-8a4e-9a551091968e', '18', 'STOCK_COUNT_START_SUCCESS', 'stock_counts', 'SC-20251118-012', '2025-11-18 20:29:38', '{\"盘点编号\":\"SC-20251118-012\",\"原状态\":\"已下发\"}', '{\"盘点编号\":\"SC-20251118-012\",\"新状态\":\"盘点中\",\"开始时间\":\"2025-11-18 20:29:38\",\"操作人\":\"王仓库\"}', '', '手动开始盘点，允许录入实际数量');
INSERT INTO `audit_logs` VALUES ('9b658a95-2be6-4ebb-a90c-a33416285254', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d6f79-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:38:08', '{\"物资编码\":\"EQP007\",\"批次号\":\"-\",\"原实际数量\":1.0,\"原差异\":0.000}', '{\"物资编码\":\"EQP007\",\"批次号\":\"-\",\"新实际数量\":1.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:38:08\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('9bac611d-1a13-442e-9306-00bb9eb2419b', '18', 'STOCK_IN_FAILED', 'stock_transactions', 'IN-20251118174653-97de38a8', '2025-11-18 17:46:53', '{\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"尝试入库库位\":\"默认货位\"}', '{\"失败原因\":\"Cannot add or update a child row: a foreign key constraint fails (`labsystem`.`stock_batches`, CONSTRAINT `fk_stock_batch_location` FOREIGN KEY (`current_location_id`) REFERENCES `locations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE)\",\"失败时间\":\"2025-11-18 17:46:53\",\"异常堆栈\":\"   在 MySql.Data.MySqlClient.MySqlStream.<ReadPacketAsync>d__30.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\\r\\n   在 MySql.Data.MySqlClient.NativeDriver.<GetResultAsync>d__45.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerService\"}', '', '采购单物资入库操作失败（已回滚事务）');
INSERT INTO `audit_logs` VALUES ('a2a9bf92-0e6d-46c9-a528-35748e1ab27c', '18', 'STOCK_OUT_SUCCESS', 'stock_transactions', 'TR-20251118-001', '2025-11-18 20:26:22', '{\"出库前状态\":\"待出库\",\"源库位\":null,\"涉及物资数量\":1,\"操作单号\":\"TR-20251118-001\"}', '{\"出库后状态\":\"已完成\",\"源库位\":null,\"出库时间\":\"2025-11-18 20:26:21\",\"出库单号\":\"TR-20251118-001\",\"操作人\":\"123\",\"出库原因\":\"领用（实验室）\",\"出库明细\":[{\"物资编码\":\"CONS003\",\"物资名称\":\"培养皿\",\"规格\":\"90mm，50个/包\",\"批次号\":\"CONS003-B202402\",\"出库数量\":\"1\",\"单位\":\"包\"}]}', '', '手动执行出库操作（扣减库存并记录事务）');
INSERT INTO `audit_logs` VALUES ('a311d5fe-827c-492f-916a-bd56175fd35d', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d757c-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:49', '{\"物资编码\":\"CHEM006\",\"批次号\":\"CHEM006-B202405\",\"原实际数量\":3.0,\"原差异\":0.000}', '{\"物资编码\":\"CHEM006\",\"批次号\":\"CHEM006-B202405\",\"新实际数量\":3.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:49\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('a3746102-e15b-4138-812d-969a5e231546', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7884-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:33', '{\"物资编码\":\"CONS005\",\"批次号\":\"BATCH-20251118-25f581\",\"原实际数量\":20.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS005\",\"批次号\":\"BATCH-20251118-25f581\",\"新实际数量\":20.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:33\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('ac2a8d7a-7d7b-4b3a-b04e-122f11edc255', '18', 'STOCK_COUNT_EXPORT', 'stock_counts', 'SC2024004', '2025-11-18 18:05:15', '{\"盘点编号\":\"SC2024004\",\"明细数量\":0}', '{\"导出时间\":\"2025-11-18 18:05:15\",\"导出明细数量\":0,\"操作人\":\"王仓库\"}', '', '手动导出盘点任务明细数据');
INSERT INTO `audit_logs` VALUES ('ae8cb138-adbb-4227-bbfe-57dc0397a27a', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7d5e-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:52', '{\"物资编码\":\"CONS006\",\"批次号\":\"BATCH-20251118-e990b5\",\"原实际数量\":32.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS006\",\"批次号\":\"BATCH-20251118-e990b5\",\"新实际数量\":32.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:52\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('b2f3cea6-f801-437b-9936-fac9afd5e2b8', '18', 'PO_STATUS_UPDATE', 'purchase_orders', '2', '2025-11-18 19:38:09', '{\"原状态\":\"received\"}', '{\"新状态\":\"received\",\"未完全入库明细数\":0}', '', '采购单部分入库后更新状态');
INSERT INTO `audit_logs` VALUES ('b425f88c-98f4-43e5-9e80-cb6835bb5cc0', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-001', '2025-11-18 18:05:00', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-001\",\"盘点范围\":\"WH001-主仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:05:00\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('b69645d5-a692-11f0-ad9e-005056c00001', 'uuid-user-1', 'CREATE', 'users', 'uuid-user-21', '2025-10-11 19:09:10', NULL, '{\"id\":\"uuid-user-21\",\"username\":\"lab_user21\",\"full_name\":\"张三\",\"status\":\"active\",\"created_at\":\"2024-06-01 09:00:00\"}', '192.168.1.101', NULL);
INSERT INTO `audit_logs` VALUES ('b6965880-a692-11f0-ad9e-005056c00001', 'uuid-user-2', 'UPDATE', 'users', 'uuid-user-21', '2025-10-11 19:09:10', '{\"status\":\"active\"}', '{\"status\":\"disabled\"}', '192.168.1.102', NULL);
INSERT INTO `audit_logs` VALUES ('b6965a94-a692-11f0-ad9e-005056c00001', 'uuid-user-1', 'ASSIGN', 'user_roles', 'uuid-user-21_uuid-role-3', '2025-10-11 19:09:10', NULL, '{\"user_id\":\"uuid-user-21\",\"role_id\":\"uuid-role-3\",\"assigned_by\":\"uuid-user-1\",\"assigned_at\":\"2024-06-01 10:00:00\"}', '192.168.1.101', NULL);
INSERT INTO `audit_logs` VALUES ('b6965b9e-a692-11f0-ad9e-005056c00001', 'uuid-user-2', 'JOIN', 'lab_memberships', 'uuid-lab-1_uuid-user-21', '2025-10-11 19:09:10', NULL, '{\"lab_id\":\"uuid-lab-1\",\"user_id\":\"uuid-user-21\",\"role_in_lab\":\"member\",\"active\":true}', '192.168.1.102', NULL);
INSERT INTO `audit_logs` VALUES ('b6965ca9-a692-11f0-ad9e-005056c00001', 'uuid-user-3', 'CREATE', 'items', 'uuid-item-1', '2025-10-11 19:09:10', NULL, '{\"id\":\"uuid-item-1\",\"code\":\"CONS001\",\"name\":\"一次性离心管\",\"type\":\"consumable\",\"unit\":\"盒\",\"supplier_id\":\"uuid-supplier-1\",\"active\":true}', '192.168.1.103', NULL);
INSERT INTO `audit_logs` VALUES ('b6965de2-a692-11f0-ad9e-005056c00001', 'uuid-user-3', 'UPDATE', 'items', 'uuid-item-1', '2025-10-11 19:09:10', '{\"min_stock\":10.000}', '{\"min_stock\":15.000}', '192.168.1.103', NULL);
INSERT INTO `audit_logs` VALUES ('b6965ecf-a692-11f0-ad9e-005056c00001', 'uuid-user-4', 'CREATE', 'consumable_specs', 'uuid-item-1', '2025-10-14 19:09:10', NULL, '{\"item_id\":\"uuid-item-1\",\"storage_cond\":\"常温干燥\",\"shelf_life_days\":365,\"lot_tracking\":true}', '192.168.1.104', NULL);
INSERT INTO `audit_logs` VALUES ('b6965fcf-a692-11f0-ad9e-005056c00001', 'uuid-user-4', 'UPDATE', 'consumable_specs', 'uuid-item-1', '2025-10-11 19:09:10', '{\"msds_url\":null}', '{\"msds_url\":\"https://msds.example.com/CONS001.pdf\"}', '192.168.1.104', NULL);
INSERT INTO `audit_logs` VALUES ('b69660e8-a692-11f0-ad9e-005056c00001', 'uuid-user-5', 'CREATE', 'stock_batches', 'uuid-batch-1', '2025-10-11 19:09:10', NULL, '{\"id\":\"uuid-batch-1\",\"item_id\":\"uuid-item-1\",\"batch_no\":\"CONS001-B202401\",\"current_location_id\":\"uuid-location-13\",\"qty_on_hand\":30.000,\"status\":\"available\"}', '192.168.1.105', NULL);
INSERT INTO `audit_logs` VALUES ('b69661c3-a692-11f0-ad9e-005056c00001', 'uuid-user-5', 'UPDATE', 'stock_batches', 'uuid-batch-1', '2025-10-11 19:09:10', '{\"qty_on_hand\":30.000}', '{\"qty_on_hand\":25.000}', '192.168.1.105', NULL);
INSERT INTO `audit_logs` VALUES ('b69663b7-a692-11f0-ad9e-005056c00001', 'uuid-user-6', 'CREATE', 'stock_transactions', 'uuid-tx-1', '2025-10-11 19:09:10', NULL, '{\"id\":\"uuid-tx-1\",\"tx_type\":\"issue\",\"item_id\":\"uuid-item-1\",\"batch_id\":\"uuid-batch-1\",\"qty\":5.000,\"operator_id\":\"uuid-user-6\"}', '192.168.1.106', NULL);
INSERT INTO `audit_logs` VALUES ('b6966517-a692-11f0-ad9e-005056c00001', 'uuid-user-6', 'CREATE', 'stock_transactions', 'uuid-tx-2', '2025-06-11 19:09:10', NULL, '{\"id\":\"uuid-tx-2\",\"tx_type\":\"return\",\"item_id\":\"uuid-item-1\",\"batch_id\":\"uuid-batch-1\",\"qty\":3.000,\"operator_id\":\"uuid-user-6\"}', '192.168.1.106', NULL);
INSERT INTO `audit_logs` VALUES ('b696660f-a692-11f0-ad9e-005056c00001', 'uuid-user-21', 'CREATE', 'borrow_orders', 'uuid-br-1', '2025-10-11 19:09:10', NULL, '{\"id\":\"uuid-br-1\",\"borrow_no\":\"BOR2024001\",\"requester_id\":\"uuid-user-21\",\"lab_id\":\"uuid-lab-1\",\"status\":\"submitted\"}', '192.168.1.107', NULL);
INSERT INTO `audit_logs` VALUES ('b69666e7-a692-11f0-ad9e-005056c00001', 'uuid-user-2', 'APPROVE', 'borrow_orders', 'uuid-br-1', '2025-10-08 19:09:10', '{\"status\":\"submitted\"}', '{\"status\":\"approved\"}', '192.168.1.102', NULL);
INSERT INTO `audit_logs` VALUES ('b69667e9-a692-11f0-ad9e-005056c00001', 'uuid-user-22', 'CREATE', 'reservations', 'uuid-res-1', '2025-10-11 19:09:10', NULL, '{\"id\":\"uuid-res-1\",\"item_id\":\"uuid-item-8\",\"requester_id\":\"uuid-user-22\",\"start_time\":\"2024-06-16 09:00:00\",\"status\":\"requested\"}', '192.168.1.108', NULL);
INSERT INTO `audit_logs` VALUES ('b69668e1-a692-11f0-ad9e-005056c00001', 'uuid-user-3', 'APPROVE', 'reservations', 'uuid-res-1', '2025-05-11 19:09:10', '{\"status\":\"requested\"}', '{\"status\":\"approved\"}', '192.168.1.103', NULL);
INSERT INTO `audit_logs` VALUES ('b69669de-a692-11f0-ad9e-005056c00001', 'uuid-user-4', 'CREATE', 'maintenance_orders', 'uuid-mo-1', '2025-10-11 19:09:10', NULL, '{\"id\":\"uuid-mo-1\",\"mo_no\":\"MO2024001\",\"item_id\":\"uuid-item-9\",\"type\":\"calibration\",\"status\":\"submitted\"}', '192.168.1.104', NULL);
INSERT INTO `audit_logs` VALUES ('b6966f1f-a692-11f0-ad9e-005056c00001', 'uuid-user-1', 'APPROVE', 'maintenance_orders', 'uuid-mo-1', '2025-09-09 19:09:10', '{\"status\":\"submitted\"}', '{\"status\":\"approved\"}', '192.168.1.101', NULL);
INSERT INTO `audit_logs` VALUES ('b696712b-a692-11f0-ad9e-005056c00001', 'uuid-user-5', 'CREATE', 'stock_counts', 'uuid-sc-1', '2025-09-09 19:09:10', NULL, '{\"id\":\"uuid-sc-1\",\"count_no\":\"SC2024001\",\"location_id\":\"uuid-location-13\",\"status\":\"issued\"}', '192.168.1.105', NULL);
INSERT INTO `audit_logs` VALUES ('b696724b-a692-11f0-ad9e-005056c00001', 'uuid-user-5', 'UPDATE', 'stock_counts', 'uuid-sc-1', '2025-05-15 19:09:10', '{\"status\":\"issued\"}', '{\"status\":\"closed\"}', '192.168.1.105', NULL);
INSERT INTO `audit_logs` VALUES ('b8f3c56c-42bc-4a37-a63d-e4368a35955d', '2', 'CREATE_APPROVAL_TEMPLATE', 'approvals', 'RS', '2025-10-19 21:48:08', NULL, '{\"biz_type\":\"RS\",\"step_count\":3}', NULL, NULL);
INSERT INTO `audit_logs` VALUES ('b938bad5-790e-4390-86b9-f065e401eb77', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-007', '2025-11-18 18:26:25', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-007\",\"盘点范围\":\"WH002-危化品仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:26:25\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('b9b8fae5-779b-40dc-b8aa-7486ca7ebcc1', '18', 'STOCK_IN', 'stock_transactions', 'IN-20251118193755-012b8a47', '2025-11-18 19:37:55', '{\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"入库前状态\":\"待入库\",\"待入库物资数量\":2}', '{\"入库标识\":\"IN-20251118193755-012b8a47\",\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"入库仓库\":\"主仓库\",\"入库库位\":\"默认货位\",\"入库时间\":\"2025-11-18 19:37:55\",\"入库物资明细\":[{\"物资编码\":\"CONS001\",\"物资名称\":\"一次性离心管\",\"入库数量\":\"1\",\"单位\":\"盒\"},{\"物资编码\":\"CONS002\",\"物资名称\":\"移液器吸头\",\"入库数量\":\"1\",\"单位\":\"盒\"}],\"操作人\":\"123\"}', '', '采购单物资入库（通过采购单关联）');
INSERT INTO `audit_logs` VALUES ('b9d90ba8-a757-417d-8d60-a5dc5abc9ec4', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d717b-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:44', '{\"物资编码\":\"CHEM002\",\"批次号\":\"CHEM002-B202404\",\"原实际数量\":5.0,\"原差异\":0.000}', '{\"物资编码\":\"CHEM002\",\"批次号\":\"CHEM002-B202404\",\"新实际数量\":5.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:44\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('bd954754-7fb5-4bb1-bc15-da59be49de91', '18', 'STOCK_COUNT_START_SUCCESS', 'stock_counts', 'SC-20251118-003', '2025-11-18 18:09:54', '{\"盘点编号\":\"SC-20251118-003\",\"原状态\":\"已下发\"}', '{\"盘点编号\":\"SC-20251118-003\",\"新状态\":\"盘点中\",\"开始时间\":\"2025-11-18 18:09:54\",\"操作人\":\"王仓库\"}', '', '手动开始盘点，允许录入实际数量');
INSERT INTO `audit_logs` VALUES ('bf6d9580-81d0-4e2a-a800-ce640f342e01', '18', 'LOCATION_CREATE', 'locations', '2903c3d4-c46b-11f0-a379-00ff9a0531b3', '2025-11-18 18:41:37', NULL, '{\"库位编码\":\"123\",\"库位名称\":\"123\",\"库位类型\":\"bin\",\"危化品类型\":\"设备\",\"父级库位\":\"橡胶耗材货架(WH001-Z01-R04)\",\"温控范围\":\"1-2\"}', '本地', '仓库管理员手动新增库位');
INSERT INTO `audit_logs` VALUES ('c0d02208-29ef-4577-93b8-2cc3c83b1dfd', '18', 'STOCK_IN_FAILED', 'stock_transactions', 'IN-20251118174847-a684418a', '2025-11-18 17:48:47', '{\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"尝试入库库位\":\"默认货位\"}', '{\"失败原因\":\"Cannot add or update a child row: a foreign key constraint fails (`labsystem`.`stock_batches`, CONSTRAINT `fk_stock_batch_location` FOREIGN KEY (`current_location_id`) REFERENCES `locations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE)\",\"失败时间\":\"2025-11-18 17:48:47\",\"异常堆栈\":\"   在 MySql.Data.MySqlClient.MySqlStream.<ReadPacketAsync>d__30.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\\r\\n   在 MySql.Data.MySqlClient.NativeDriver.<GetResultAsync>d__45.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerService\"}', '', '采购单物资入库操作失败（已回滚事务）');
INSERT INTO `audit_logs` VALUES ('c0e12b60-2681-4611-852a-83943f379cc5', '2', 'add_lab_member', 'lab_memberships', '8_16', '2025-10-16 19:31:30', NULL, '{\"lab_id\":\"8\",\"user_id\":\"16\",\"username\":\"Che Sze Kwan\"}', NULL, '添加用户到实验室');
INSERT INTO `audit_logs` VALUES ('c25c7c80-5304-4ded-9649-809ed0202080', '18', 'STOCK_IN_FAILED', 'stock_transactions', 'IN-20251118185735-ce089bc3', '2025-11-18 18:57:36', '{\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"尝试入库库位\":\"默认货位\"}', '{\"失败原因\":\"Cannot add or update a child row: a foreign key constraint fails (`labsystem`.`stock_batches`, CONSTRAINT `fk_stock_batch_location` FOREIGN KEY (`current_location_id`) REFERENCES `locations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE)\",\"失败时间\":\"2025-11-18 18:57:36\",\"异常堆栈\":\"   在 MySql.Data.MySqlClient.MySqlStream.<ReadPacketAsync>d__30.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\\r\\n   在 MySql.Data.MySqlClient.NativeDriver.<GetResultAsync>d__45.MoveNext()\\r\\n--- 引发异常的上一位置中堆栈跟踪的末尾 ---\\r\\n   在 System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)\\r\\n   在 System.Runtime.CompilerService\"}', '', '采购单物资入库操作失败（已回滚事务）');
INSERT INTO `audit_logs` VALUES ('c3877a47-c443-4688-97b6-0392b931aafa', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7702-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:17', '{\"物资编码\":\"CONS003\",\"批次号\":\"CONS003-B202402\",\"原实际数量\":25.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS003\",\"批次号\":\"CONS003-B202402\",\"新实际数量\":25.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:17\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('c765280a-07d2-4be9-821d-ebbb7369d8b5', '18', 'STOCK_OUT_SUCCESS', 'stock_transactions', 'OUT-20251118-001', '2025-11-18 20:18:41', '{\"出库前状态\":\"待出库\",\"源库位\":null,\"涉及物资数量\":1,\"操作单号\":\"OUT-20251118-001\"}', '{\"出库后状态\":\"已完成\",\"源库位\":null,\"出库时间\":\"2025-11-18 20:18:41\",\"出库单号\":\"OUT-20251118-001\",\"操作人\":\"123\",\"出库原因\":\"领用（实验室）\",\"出库明细\":[{\"物资编码\":\"CONS003\",\"物资名称\":\"培养皿\",\"规格\":\"90mm，50个/包\",\"批次号\":\"CONS003-B202402\",\"出库数量\":\"1\",\"单位\":\"包\"}]}', '', '手动执行出库操作（扣减库存并记录事务）');
INSERT INTO `audit_logs` VALUES ('cb7ea302-2f3c-42bd-8066-1d84e32debbb', '18', 'STOCK_TRANSFER', 'stock_batches', 'e2f61a2d-c46c-11f0-a379-00ff9a0531b3', '2025-11-18 18:54:12', '{\"源库位ID\":\"2903c3d4-c46b-11f0-a379-00ff9a0531b3\",\"源库位名称\":\"123(123)\",\"转移前库存数量\":1.000,\"物资名称\":\"一次性离心管\",\"批次号\":\"CONS001-B202401\"}', '{\"目标库位ID\":\"17\",\"目标库位名称\":\"离心管货位(WH001-Z01-R01-B01)\",\"转移数量\":1.0,\"转移后源库位剩余数量\":0.000,\"物资单位\":\"盒\",\"转移类型\":\"手动移库\"}', '', '仓库管理员手动转移库存（无关联单据）');
INSERT INTO `audit_logs` VALUES ('cbd18a54-4ddf-40bc-9157-92b8e7e0aba2', '18', 'STOCK_IN', 'stock_transactions', 'IN-20251118172935-eb561ea8', '2025-11-18 17:29:35', '{\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"入库前状态\":\"待入库\",\"待入库物资数量\":1}', '{\"入库标识\":\"IN-20251118172935-eb561ea8\",\"采购单ID\":\"1\",\"采购单号\":\"PO2024001\",\"入库仓库\":\"主仓库\",\"入库库位\":\"培养皿货位\",\"入库时间\":\"2025-11-18 17:29:35\",\"入库物资明细\":[{\"物资编码\":\"CONS001\",\"物资名称\":\"一次性离心管\",\"入库数量\":\"1.000\",\"单位\":\"盒\"}],\"操作人\":\"123\"}', '', '采购单物资入库（通过采购单关联）');
INSERT INTO `audit_logs` VALUES ('cfb55c9f-1cc5-4782-a199-60294812fec1', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d600c-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:11', '{\"物资编码\":\"CONS001\",\"批次号\":\"CONS001-B202401\",\"原实际数量\":30.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS001\",\"批次号\":\"CONS001-B202401\",\"新实际数量\":30.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:11\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('d22ac2e8-5794-4e7d-abf1-a00a2c1ede80', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d6431-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:41', '{\"物资编码\":\"EQP002\",\"批次号\":\"-\",\"原实际数量\":1.0,\"原差异\":0.000}', '{\"物资编码\":\"EQP002\",\"批次号\":\"-\",\"新实际数量\":1.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:41\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('def05e01-5d06-4589-b04c-5605506d3c72', '18', 'STOCK_COUNT_ISSUE_SUCCESS', 'stock_counts', 'SC-20251118-003', '2025-11-18 18:09:48', '{\"盘点编号\":\"SC-20251118-003\",\"原状态\":\"草稿\",\"明细数量\":\"0（未生成）\"}', '{\"盘点编号\":\"SC-20251118-003\",\"新状态\":\"已下发\",\"生成明细数量\":0,\"下发时间\":\"2025-11-18 18:09:48\",\"操作人\":\"王仓库\"}', '', '手动下发盘点任务，生成库存明细');
INSERT INTO `audit_logs` VALUES ('deff6017-5c3f-477c-afdd-77ad11d7fc0c', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-010', '2025-11-18 18:26:50', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-010\",\"盘点范围\":\"WH005-生物样本库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:26:50\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('df417e7b-629d-4aa8-9195-d7defa91c60f', '18', 'LOCATION_UPDATE', 'locations', '19', '2025-11-18 18:42:09', '{\"原库位名称\":\"培养皿货位\",\"原库位类型\":\"bin\",\"原危化品类型\":\"实验耗材\",\"原温控范围\":\"常温\"}', '{\"新库位名称\":\"培养皿货位\",\"新库位类型\":\"bin\",\"新危化品类型\":\"实验耗材\",\"新温控范围\":\"常温\",\"新状态\":\"启用\"}', '', '仓库管理员修改库位信息');
INSERT INTO `audit_logs` VALUES ('e0392009-3a03-47fd-bcbf-b8222cc044d6', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-002', '2025-11-18 18:05:55', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-002\",\"盘点范围\":\"WH002-危化品仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:05:55\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('e2a42cd7-b085-4e94-a309-fb1a447fdcb3', '10', 'RESERVATION_CREATE', 'reservations', 'ae9f5516-604a-4a6c-9280-30abdd8f4c79', '2025-11-18 20:37:12', NULL, '{\"预约单号\":\"RS-20251118-001\",\"设备名称\":\"电子天平\",\"预约时段\":\"2025-11-18 21:33 - 2025-11-18 22:33\",\"预约用途\":\"教学\",\"申请状态\":\"requested（待审核）\"}', '本地', '实验人员提交设备预约申请');
INSERT INTO `audit_logs` VALUES ('e2fc1096-ac01-456c-b08e-a691cbe02ec5', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-009', '2025-11-18 18:26:45', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-009\",\"盘点范围\":\"WH004-设备仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:26:45\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('e303a1cf-c46c-11f0-a379-00ff9a0531b3', '18', 'STOCK_TRANSFER', 'stock_batches', '1', '2025-11-18 18:53:59', '{\"物资ID\":\"1\",\"物资名称\":\"一次性离心管\",\"批次ID\":\"1\",\"批次号\":\"CONS001-B202401\",\"源库位ID\":\"17\",\"源库位名称\":\"离心管货位(WH001-Z01-R01-B01)\",\"转移前库存数量\":30.000,\"计量单位\":\"盒\"}', '{\"物资ID\":\"1\",\"物资名称\":\"一次性离心管\",\"批次ID\":\"1\",\"批次号\":\"CONS001-B202401\",\"源库位ID\":\"17\",\"目标库位ID\":\"2903c3d4-c46b-11f0-a379-00ff9a0531b3\",\"目标库位名称\":\"123(123)\",\"转移数量\":1.0,\"转移后源库位剩余数量\":29.000,\"计量单位\":\"盒\",\"操作类型\":\"手动移库\"}', '', '手动移库');
INSERT INTO `audit_logs` VALUES ('e3a462e9-abee-4886-936a-1726608333cd', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-008', '2025-11-18 18:26:36', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-008\",\"盘点范围\":\"WH003-低温仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:26:36\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('e40f5663-cadb-4c34-a93c-bc0e2e3ab043', '10', 'BORROW_CREATE', 'borrow_orders', '9fde3e93-8a0f-41b2-8301-64b47a73ea6e', '2025-11-18 20:51:37', NULL, '{\"借用单号\":\"BR-20251118-002\",\"所属实验室\":\"LAB010-细胞培养实验室2\",\"借用用途\":\"教学\",\"申请物资总数\":1,\"预计归还日期\":\"2025-11-25\"}', '本地', '实验人员提交借用申请，等待审批');
INSERT INTO `audit_logs` VALUES ('e51980ed-495f-4e5b-bce7-457b82b2d9ca', '10', 'BORROW_RETURN', 'borrow_orders', 'bee52f71-82b2-4b41-b75f-d2c0d03b0234', '2025-11-18 20:50:53', '{\"借用单号\":\"BR-20251118-001\",\"归还前已还数量\":0.000,\"本次计划归还数量\":1.0,\"物资名称\":\"培养皿\"}', '{\"借用单号\":\"BR-20251118-001\",\"归还物资名称\":\"培养皿\",\"物资规格\":\"90mm，50个/包\",\"本次实际归还数量\":1.0,\"归还后总已还数量\":1.000,\"剩余未还数量\":0.000,\"归还备注\":\"bee52f71-82b2-4b41-b75f-d2c0d03b0234\"}', '本地', '实验人员归还借用物资，库存已更新');
INSERT INTO `audit_logs` VALUES ('e614e4c0-eefb-4f7f-8068-3429d1fe8fec', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d7e1c-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:36:57', '{\"物资编码\":\"CONS001\",\"批次号\":\"BATCH-20251118-733160\",\"原实际数量\":1.0,\"原差异\":0.000}', '{\"物资编码\":\"CONS001\",\"批次号\":\"BATCH-20251118-733160\",\"新实际数量\":1.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:36:57\"}', '', '手动修改盘点实际数量');
INSERT INTO `audit_logs` VALUES ('e748282c-ceea-403b-a805-bff2d1f741d8', '18', 'STOCK_COUNT_SUBMIT_REVIEW_SUCCESS', 'stock_counts', 'SC-20251118-011', '2025-11-18 18:40:03', '{\"盘点编号\":\"SC-20251118-011\",\"原状态\":\"盘点中\",\"未完成明细数量\":0}', '{\"盘点编号\":\"SC-20251118-011\",\"新状态\":\"待审核\",\"提交时间\":\"2025-11-18 18:40:03\",\"差异汇总\":\"总差异数量：1.000\\n差异明细数：1\",\"操作人\":\"王仓库\"}', '', '手动提交盘点结果审核');
INSERT INTO `audit_logs` VALUES ('e84089b9-3f1a-44c7-8ff5-4adbad16fab8', '18', 'PO_STATUS_UPDATE', 'purchase_orders', '1', '2025-11-18 19:37:55', '{\"原状态\":\"received\"}', '{\"新状态\":\"received\",\"未完全入库明细数\":0}', '', '采购单部分入库后更新状态');
INSERT INTO `audit_logs` VALUES ('e9adab0a-fbfb-4b42-bbd0-e9096aa79805', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-006', '2025-11-18 18:24:45', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-006\",\"盘点范围\":\"WH001-主仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:24:45\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('ead2f9a0-c46c-11f0-a379-00ff9a0531b3', '18', 'STOCK_TRANSFER', 'stock_batches', 'e2f61a2d-c46c-11f0-a379-00ff9a0531b3', '2025-11-18 18:54:12', '{\"物资ID\":\"1\",\"物资名称\":\"一次性离心管\",\"批次ID\":\"e2f61a2d-c46c-11f0-a379-00ff9a0531b3\",\"批次号\":\"CONS001-B202401\",\"源库位ID\":\"2903c3d4-c46b-11f0-a379-00ff9a0531b3\",\"源库位名称\":\"123(123)\",\"转移前库存数量\":1.000,\"计量单位\":\"盒\"}', '{\"物资ID\":\"1\",\"物资名称\":\"一次性离心管\",\"批次ID\":\"e2f61a2d-c46c-11f0-a379-00ff9a0531b3\",\"批次号\":\"CONS001-B202401\",\"源库位ID\":\"2903c3d4-c46b-11f0-a379-00ff9a0531b3\",\"目标库位ID\":\"17\",\"目标库位名称\":\"离心管货位(WH001-Z01-R01-B01)\",\"转移数量\":1.0,\"转移后源库位剩余数量\":0.000,\"计量单位\":\"盒\",\"操作类型\":\"手动移库\"}', '', '手动移库');
INSERT INTO `audit_logs` VALUES ('ecab6a45-8325-45bd-be91-c118c160f1ee', '18', 'STOCK_COUNT_CREATE_SUCCESS', 'stock_counts', 'SC-20251118-003', '2025-11-18 18:06:16', '{\"状态\":\"无任务\"}', '{\"盘点编号\":\"SC-20251118-003\",\"盘点范围\":\"WH001-主仓库\",\"状态\":\"草稿\",\"创建时间\":\"2025-11-18 18:06:16\",\"创建人\":\"王仓库\"}', '', '手动创建盘点任务，备注：');
INSERT INTO `audit_logs` VALUES ('f51211f0-1ed2-441e-a940-35c890337e91', '18', 'STOCK_TRANSFER', 'stock_batches', '1', '2025-11-18 18:53:59', '{\"源库位ID\":\"17\",\"源库位名称\":\"离心管货位(WH001-Z01-R01-B01)\",\"转移前库存数量\":30.000,\"物资名称\":\"一次性离心管\",\"批次号\":\"CONS001-B202401\"}', '{\"目标库位ID\":\"2903c3d4-c46b-11f0-a379-00ff9a0531b3\",\"目标库位名称\":\"123(123)\",\"转移数量\":1.0,\"转移后源库位剩余数量\":29.000,\"物资单位\":\"盒\",\"转移类型\":\"手动移库\"}', '', '仓库管理员手动转移库存（无关联单据）');
INSERT INTO `audit_logs` VALUES ('ff26e308-6d3a-436d-aa07-c5c0a8a1460c', '18', 'STOCK_COUNT_LINE_UPDATE', 'stock_count_lines', '261d73f1-c46a-11f0-a379-00ff9a0531b3', '2025-11-18 18:37:40', '{\"物资编码\":\"CHEM005\",\"批次号\":\"CHEM005-B202405\",\"原实际数量\":7.0,\"原差异\":0.000}', '{\"物资编码\":\"CHEM005\",\"批次号\":\"CHEM005-B202405\",\"新实际数量\":7.0,\"新差异\":0.000,\"修改时间\":\"2025-11-18 18:37:40\"}', '', '手动修改盘点实际数量');

-- ----------------------------
-- Table structure for borrow_order_items
-- ----------------------------
DROP TABLE IF EXISTS `borrow_order_items`;
CREATE TABLE `borrow_order_items`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `borrow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联borrow_orders.id',
  `item_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联items.id',
  `batch_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外键：关联stock_batches.id（指定批次/序列号）',
  `qty_requested` decimal(14, 3) NOT NULL COMMENT '申请数量',
  `qty_issued` decimal(14, 3) NOT NULL DEFAULT 0.000 COMMENT '已发出数量',
  `qty_returned` decimal(14, 3) NOT NULL DEFAULT 0.000 COMMENT '已归还数量',
  `uom` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计量单位',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_borrow_item_batch`(`batch_id` ASC) USING BTREE,
  INDEX `idx_borrow_item_borrow`(`borrow_id` ASC) USING BTREE,
  INDEX `idx_borrow_item_item`(`item_id` ASC) USING BTREE,
  CONSTRAINT `fk_borrow_item_batch` FOREIGN KEY (`batch_id`) REFERENCES `stock_batches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_borrow_item_borrow` FOREIGN KEY (`borrow_id`) REFERENCES `borrow_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_borrow_item_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '借用/领用单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of borrow_order_items
-- ----------------------------
INSERT INTO `borrow_order_items` VALUES ('1', '1', '1', '1', 5.000, 5.000, 5.000, '盒');
INSERT INTO `borrow_order_items` VALUES ('10', '6', '9', '11', 1.000, 1.000, 0.000, '台');
INSERT INTO `borrow_order_items` VALUES ('11', '6', '10', '12', 1.000, 1.000, 0.000, '台');
INSERT INTO `borrow_order_items` VALUES ('12', '6', '8', '9', 1.000, 1.000, 0.000, '台');
INSERT INTO `borrow_order_items` VALUES ('13', '8', '16', '16', 5.000, 0.000, 0.000, '瓶');
INSERT INTO `borrow_order_items` VALUES ('14', '8', '18', '18', 3.000, 0.000, 0.000, '瓶');
INSERT INTO `borrow_order_items` VALUES ('15', '8', '20', '20', 2.000, 0.000, 0.000, '瓶');
INSERT INTO `borrow_order_items` VALUES ('16', '8', '19', '19', 4.000, 0.000, 0.000, '瓶');
INSERT INTO `borrow_order_items` VALUES ('17', '10', '20', '20', 5.000, 0.000, 0.000, '瓶');
INSERT INTO `borrow_order_items` VALUES ('18', '10', '16', '16', 10.000, 0.000, 0.000, '瓶');
INSERT INTO `borrow_order_items` VALUES ('19', '10', '18', '18', 8.000, 0.000, 0.000, '瓶');
INSERT INTO `borrow_order_items` VALUES ('2', '1', '2', '2', 4.000, 4.000, 4.000, '盒');
INSERT INTO `borrow_order_items` VALUES ('20', '10', '15', '15', 3.000, 0.000, 0.000, '瓶');
INSERT INTO `borrow_order_items` VALUES ('3', '1', '3', '3', 3.000, 3.000, 3.000, '包');
INSERT INTO `borrow_order_items` VALUES ('4', '1', '7', '7', 2.000, 2.000, 2.000, '盒');
INSERT INTO `borrow_order_items` VALUES ('5', '4', '8', '8', 1.000, 0.000, 0.000, '台');
INSERT INTO `borrow_order_items` VALUES ('6', '4', '9', '10', 1.000, 0.000, 0.000, '台');
INSERT INTO `borrow_order_items` VALUES ('7', '4', '10', '12', 1.000, 0.000, 0.000, '台');
INSERT INTO `borrow_order_items` VALUES ('8', '4', '11 ', '13', 1.000, 0.000, 0.000, '台');
INSERT INTO `borrow_order_items` VALUES ('8e8eb7df-74ac-4cb3-ae80-a313f3b24947', '9fde3e93-8a0f-41b2-8301-64b47a73ea6e', '3', '3', 1.000, 1.000, 0.000, '包');
INSERT INTO `borrow_order_items` VALUES ('9', '6', '14', '14', 1.000, 1.000, 0.000, '台');
INSERT INTO `borrow_order_items` VALUES ('936a44b8-82f2-4e4c-9a6e-11514d6ab9a4', 'bee52f71-82b2-4b41-b75f-d2c0d03b0234', '3', '3', 1.000, 1.000, 1.000, '包');

-- ----------------------------
-- Table structure for borrow_orders
-- ----------------------------
DROP TABLE IF EXISTS `borrow_orders`;
CREATE TABLE `borrow_orders`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `borrow_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '借用单号（唯一）',
  `requester_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '申请人ID：关联users.id',
  `lab_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属实验室ID：关联labs.id',
  `status` enum('draft','submitted','approving','approved','rejected','issued','partially_returned','returned','overdue') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'draft' COMMENT '借用单状态机',
  `expected_return_date` date NULL DEFAULT NULL COMMENT '预计归还日期（设备用）',
  `purpose` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '借用用途/项目号',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_borrow_no`(`borrow_no` ASC) USING BTREE,
  INDEX `fk_borrow_requester`(`requester_id` ASC) USING BTREE,
  INDEX `idx_borrow_status`(`status` ASC) USING BTREE,
  INDEX `idx_borrow_lab`(`lab_id` ASC) USING BTREE,
  CONSTRAINT `fk_borrow_lab` FOREIGN KEY (`lab_id`) REFERENCES `labs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_borrow_requester` FOREIGN KEY (`requester_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '借用/领用单表头表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of borrow_orders
-- ----------------------------
INSERT INTO `borrow_orders` VALUES ('1', 'BOR2024001', '21', '1', 'returned', NULL, '有机化学实验', '2025-10-11 18:43:29', '2025-10-11 18:43:29');
INSERT INTO `borrow_orders` VALUES ('10', 'BOR2024010', '30', '10', 'rejected', NULL, '违规领用硫酸', '2025-10-11 18:43:29', '2025-10-11 18:43:29');
INSERT INTO `borrow_orders` VALUES ('11', 'BOR2025010', '10', '6', 'overdue', '2025-10-20', '细菌培养', '2025-10-20 22:28:41', '2025-10-20 22:28:41');
INSERT INTO `borrow_orders` VALUES ('2', 'BOR2024002', '22', '1', 'returned', NULL, '无机化学实验', '2025-10-11 18:43:29', '2025-10-20 22:26:04');
INSERT INTO `borrow_orders` VALUES ('3', 'BOR2024003', '23', '3', 'issued', '2025-10-15', '材料合成实验', '2025-10-11 18:43:29', '2025-10-18 13:28:51');
INSERT INTO `borrow_orders` VALUES ('4', 'BOR2024004', '24', '4', 'approved', '2024-06-15', '高效液相检测', '2025-10-11 18:43:29', '2025-10-11 18:43:29');
INSERT INTO `borrow_orders` VALUES ('5', 'BOR2024005', '25', '5', 'issued', '2024-06-10', '电子天平称量', '2025-10-11 18:43:29', '2025-10-11 18:43:29');
INSERT INTO `borrow_orders` VALUES ('6', 'BOR2024006', '26', '6', 'overdue', '2024-06-05', '磁力搅拌实验', '2025-10-11 18:43:29', '2025-10-11 18:43:29');
INSERT INTO `borrow_orders` VALUES ('7', 'BOR2024007', '27', '6', 'overdue', '2024-06-08', '细胞培养', '2025-10-11 18:43:29', '2025-10-20 22:26:58');
INSERT INTO `borrow_orders` VALUES ('8', 'BOR2024008', '28', '17', 'approving', NULL, '硝酸腐蚀实验', '2025-10-11 18:43:29', '2025-10-20 22:26:45');
INSERT INTO `borrow_orders` VALUES ('9', 'BOR2024009', '29', '9', 'approved', NULL, '氢氧化钠滴定', '2025-10-11 18:43:29', '2025-10-11 18:43:29');
INSERT INTO `borrow_orders` VALUES ('9fde3e93-8a0f-41b2-8301-64b47a73ea6e', 'BR-20251118-002', '10', '10', 'issued', '2025-11-25', '教学', '2025-11-18 20:51:37', '2025-11-18 20:53:35');
INSERT INTO `borrow_orders` VALUES ('bee52f71-82b2-4b41-b75f-d2c0d03b0234', 'BR-20251118-001', '10', '10', 'returned', '2025-11-25', '教学用品', '2025-11-18 20:32:53', '2025-11-18 20:50:53');

-- ----------------------------
-- Table structure for consumable_specs
-- ----------------------------
DROP TABLE IF EXISTS `consumable_specs`;
CREATE TABLE `consumable_specs`  (
  `item_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键：关联items.id（仅items.type=consumable/chemical）',
  `storage_cond` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存储条件（如2-8℃/避光）',
  `shelf_life_days` int NULL DEFAULT NULL COMMENT '保质期（天）',
  `msds_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'MSDS链接（危化品必填）',
  `cas_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'CAS号（化学品专属）',
  `lot_tracking` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用批次追踪',
  PRIMARY KEY (`item_id`) USING BTREE,
  CONSTRAINT `fk_consumable_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '耗材/化学品扩展属性表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of consumable_specs
-- ----------------------------
INSERT INTO `consumable_specs` VALUES ('1', '常温干燥，避免阳光直射', 365, 'https://msds.example.com/CONS001_centrifuge_tube.pdf', '-', 1);
INSERT INTO `consumable_specs` VALUES ('15', '阴凉通风（<25℃），远离火源', 180, 'https://msds.example.com/CHEM001_ethanol.pdf', '64-17-5', 1);
INSERT INTO `consumable_specs` VALUES ('16', '阴凉避光（<20℃），单独存放（防腐蚀托盘）', 90, 'https://msds.example.com/CHEM002_nitric_acid.pdf', '7697-37-2', 1);
INSERT INTO `consumable_specs` VALUES ('17', '常温干燥，密封保存', 365, 'https://msds.example.com/CHEM003_sodium_chloride.pdf', '7647-14-5', 1);
INSERT INTO `consumable_specs` VALUES ('18', '阴凉干燥（<25℃），密封防潮（防腐蚀容器）', 180, 'https://msds.example.com/CHEM004_sodium_hydroxide.pdf', '1310-73-2', 1);
INSERT INTO `consumable_specs` VALUES ('19', '阴凉通风（<25℃），远离火源（防爆柜）', 180, 'https://msds.example.com/CHEM005_methanol.pdf', '67-56-1', 1);
INSERT INTO `consumable_specs` VALUES ('2', '常温干燥，密封保存', 270, 'https://msds.example.com/CONS002_pipette_tip.pdf', '-', 1);
INSERT INTO `consumable_specs` VALUES ('20', '阴凉避光（<20℃），单独存放（防腐蚀防爆柜）', 90, 'https://msds.example.com/CHEM006_sulfuric_acid.pdf', '7664-93-9', 1);
INSERT INTO `consumable_specs` VALUES ('3', '常温干燥，防潮', 180, 'https://msds.example.com/CONS003_petri_dish.pdf', '-', 1);
INSERT INTO `consumable_specs` VALUES ('4', '常温干燥，避免潮湿', 365, 'https://msds.example.com/CONS004_qualitative_filter.pdf', '-', 1);
INSERT INTO `consumable_specs` VALUES ('5', '常温干燥，避免碰撞', 730, 'https://msds.example.com/CONS005_glass_beaker.pdf', '-', 1);
INSERT INTO `consumable_specs` VALUES ('6', '常温干燥，无磁场干扰', 365, 'https://msds.example.com/CONS006_magnetic_stir_bar.pdf', '-', 1);
INSERT INTO `consumable_specs` VALUES ('7', '常温干燥，避光', 180, 'https://msds.example.com/CONS007_nitrile_glove.pdf', '-', 1);

-- ----------------------------
-- Table structure for departments
-- ----------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称（唯一）',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上级部门ID：关联departments.id（支持层级结构）',
  `manager_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门负责人ID：关联users.id',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE,
  INDEX `fk_departments_parent`(`parent_id` ASC) USING BTREE,
  INDEX `fk_departments_manager`(`manager_id` ASC) USING BTREE,
  CONSTRAINT `fk_departments_manager` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_departments_parent` FOREIGN KEY (`parent_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门/课题组表（支持层级）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of departments
-- ----------------------------
INSERT INTO `departments` VALUES ('1', '化学与材料学院', NULL, '1', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('10', '细胞生物学系', '2', '10', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('11', '生物化学系', '2', '11', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('12', '凝聚态物理系', '3', '12', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('13', '光学系', '3', '13', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('14', '机械工程系', '4', '14', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('15', '电气工程系', '4', '15', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('2', '生命科学学院', NULL, '2', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('3', '物理学院', NULL, '3', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('4', '工程学院', NULL, '4', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('5', '环境学院', NULL, '5', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('6', '有机化学系', '1', '6', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('7', '无机化学系', '1', '7', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('8', '材料科学系', '1', '8', '2025-10-11 18:13:29');
INSERT INTO `departments` VALUES ('9', '分子生物学系', '2', '9', '2025-10-11 18:13:29');

-- ----------------------------
-- Table structure for equipment_specs
-- ----------------------------
DROP TABLE IF EXISTS `equipment_specs`;
CREATE TABLE `equipment_specs`  (
  `item_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键：关联items.id（仅items.type=equipment）',
  `asset_tag_prefix` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资产标签前缀（如EQ-）',
  `serial_required` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否按序列号管理',
  `calibration_interval_days` int NULL DEFAULT NULL COMMENT '检定（校准）周期（天）',
  `usage_unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用计量单位（如小时/次数）',
  PRIMARY KEY (`item_id`) USING BTREE,
  CONSTRAINT `fk_equipment_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备扩展属性表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of equipment_specs
-- ----------------------------
INSERT INTO `equipment_specs` VALUES ('10', 'STIR-', 0, 365, '小时');
INSERT INTO `equipment_specs` VALUES ('11 ', 'ULTRA-', 0, 365, '小时');
INSERT INTO `equipment_specs` VALUES ('12', 'UV-', 1, 180, '小时');
INSERT INTO `equipment_specs` VALUES ('13', 'DRY-', 0, 365, '小时');
INSERT INTO `equipment_specs` VALUES ('14', 'CENT-', 1, 180, '小时');
INSERT INTO `equipment_specs` VALUES ('8', 'HPLC-', 1, 180, '小时');
INSERT INTO `equipment_specs` VALUES ('9', 'BAL-', 1, 90, '次数');

-- ----------------------------
-- Table structure for item_stock_relation
-- ----------------------------
DROP TABLE IF EXISTS `item_stock_relation`;
CREATE TABLE `item_stock_relation`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `item_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `batch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `item_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `item_spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `item_unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `item_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `batch_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qty_on_hand` int NOT NULL DEFAULT 0,
  `current_location_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `expiry_date` datetime NULL DEFAULT NULL,
  `sync_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IX_item_stock_relation_item_id`(`item_id` ASC) USING BTREE,
  INDEX `IX_item_stock_relation_batch_id`(`batch_id` ASC) USING BTREE,
  INDEX `IX_item_stock_relation_current_location_id`(`current_location_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of item_stock_relation
-- ----------------------------
INSERT INTO `item_stock_relation` VALUES ('268a9635-bfb0-11f0-80ed-00ff9a0531b3', '0d780720-a1e8-11f0-8b3f-00ff9a0531b3', '41ea0375-a1e8-11f0-8b3f-00ff9a0531b3', 'CONS-001', '一次性丁腈手套', 'M号，100只/盒', '盒', 'consumable', '20250510-CONS001', 27, '38b5a487-a1e8-11f0-8b3f-00ff9a0531b3', '2026-05-10 00:00:00', '2025-11-12 18:12:53');
INSERT INTO `item_stock_relation` VALUES ('3c4b3c85-a331-11f0-8093-1c8341ca6ed2', 'item_001', '4cb10c7d-05ee-4f5d-8c26-d76e41f2da5e', 'TEST001', '测试物资', '标准规格', '个', 'consumable', 'BATCH-20251006-bbfc3b', 0, '38b5a55d-a1e8-11f0-8b3f-00ff9a0531b3', '2026-01-06 00:00:00', '2025-10-07 11:53:50');
INSERT INTO `item_stock_relation` VALUES ('41ea26d8-a1e8-11f0-8b3f-00ff9a0531b3', '0d780a79-a1e8-11f0-8b3f-00ff9a0531b3', '41ea216e-a1e8-11f0-8b3f-00ff9a0531b3', 'CONS-002', '移液器吸头', '1000μL，96个/盒', '盒', 'consumable', '20250515-CONS002', 80, '38b5a487-a1e8-11f0-8b3f-00ff9a0531b3', '2027-05-15 00:00:00', '2025-10-05 20:38:55');
INSERT INTO `item_stock_relation` VALUES ('41ea2d65-a1e8-11f0-8b3f-00ff9a0531b3', '0d780df1-a1e8-11f0-8b3f-00ff9a0531b3', '41ea2908-a1e8-11f0-8b3f-00ff9a0531b3', 'CHEM-001', '浓盐酸', 'AR级，37%浓度，500mL/瓶', '瓶', 'chemical', '20250503-CHEM001', 20, '38b5a4f1-a1e8-11f0-8b3f-00ff9a0531b3', '2025-11-03 00:00:00', '2025-10-05 20:38:55');
INSERT INTO `item_stock_relation` VALUES ('41ea32ee-a1e8-11f0-8b3f-00ff9a0531b3', '0d780df1-a1e8-11f0-8b3f-00ff9a0531b3', '41ea2ee1-a1e8-11f0-8b3f-00ff9a0531b3', 'CHEM-001', '浓盐酸', 'AR级，37%浓度，500mL/瓶', '瓶', 'chemical', '20250520-CHEM001', 15, '38b5a4f1-a1e8-11f0-8b3f-00ff9a0531b3', '2025-11-20 00:00:00', '2025-10-05 20:38:55');
INSERT INTO `item_stock_relation` VALUES ('41ea3b48-a1e8-11f0-8b3f-00ff9a0531b3', '0d780e84-a1e8-11f0-8b3f-00ff9a0531b3', '41ea3539-a1e8-11f0-8b3f-00ff9a0531b3', 'CHEM-002', '无水乙醇', 'AR级，99.5%浓度，500mL/瓶', '瓶', 'chemical', '20250504-CHEM002', 30, '38b5a55d-a1e8-11f0-8b3f-00ff9a0531b3', '2025-11-04 00:00:00', '2025-10-05 20:38:55');
INSERT INTO `item_stock_relation` VALUES ('41ea4ac7-a1e8-11f0-8b3f-00ff9a0531b3', '0d780e84-a1e8-11f0-8b3f-00ff9a0531b3', '41ea4056-a1e8-11f0-8b3f-00ff9a0531b3', 'CHEM-002', '无水乙醇', 'AR级，99.5%浓度，500mL/瓶', '瓶', 'chemical', '20250525-CHEM002', 25, '38b5a55d-a1e8-11f0-8b3f-00ff9a0531b3', '2025-11-25 00:00:00', '2025-10-05 20:38:55');
INSERT INTO `item_stock_relation` VALUES ('41ea50cc-a1e8-11f0-8b3f-00ff9a0531b3', '0d780c78-a1e8-11f0-8b3f-00ff9a0531b3', '41ea4ca9-a1e8-11f0-8b3f-00ff9a0531b3', 'EQ-001', '电子分析天平', '型号FA2004，量程200g，精度0.1mg', '台', 'equipment', NULL, 1, '38b5a5bb-a1e8-11f0-8b3f-00ff9a0531b3', NULL, '2025-10-05 20:38:55');
INSERT INTO `item_stock_relation` VALUES ('41ea5677-a1e8-11f0-8b3f-00ff9a0531b3', '0d780c78-a1e8-11f0-8b3f-00ff9a0531b3', '41ea540c-a1e8-11f0-8b3f-00ff9a0531b3', 'EQ-001', '电子分析天平', '型号FA2004，量程200g，精度0.1mg', '台', 'equipment', NULL, 1, '38b5a5bb-a1e8-11f0-8b3f-00ff9a0531b3', NULL, '2025-10-05 20:38:55');
INSERT INTO `item_stock_relation` VALUES ('41ea593b-a1e8-11f0-8b3f-00ff9a0531b3', '0d780d0c-a1e8-11f0-8b3f-00ff9a0531b3', '41ea5796-a1e8-11f0-8b3f-00ff9a0531b3', 'EQ-002', '高效液相色谱仪', '型号LC-2030，配紫外检测器', '台', 'equipment', NULL, 1, '38b5a61b-a1e8-11f0-8b3f-00ff9a0531b3', NULL, '2025-10-05 20:38:55');
INSERT INTO `item_stock_relation` VALUES ('41ea5bb3-a1e8-11f0-8b3f-00ff9a0531b3', '0d780d0c-a1e8-11f0-8b3f-00ff9a0531b3', '41ea5a33-a1e8-11f0-8b3f-00ff9a0531b3', 'EQ-002', '高效液相色谱仪', '型号LC-2030，配紫外检测器', '台', 'equipment', NULL, 1, '38b5a61b-a1e8-11f0-8b3f-00ff9a0531b3', NULL, '2025-10-05 20:38:55');
INSERT INTO `item_stock_relation` VALUES ('900b6766-a1fe-11f0-8b3f-00ff9a0531b3', '0d780720-a1e8-11f0-8b3f-00ff9a0531b3', '900b62df-a1fe-11f0-8b3f-00ff9a0531b3', 'CONS-001', '一次性丁腈手套', 'M号，100只/盒', '盒', 'consumable', '20250501-CONS001', 20, '75698143-a1f5-11f0-8b3f-00ff9a0531b3', '2026-05-01 00:00:00', '2025-10-05 23:18:35');
INSERT INTO `item_stock_relation` VALUES ('97e518a1-bfa5-11f0-80ed-00ff9a0531b3', '0d780720-a1e8-11f0-8b3f-00ff9a0531b3', '97e51424-bfa5-11f0-80ed-00ff9a0531b3', 'CONS-001', '一次性丁腈手套', 'M号，100只/盒', '盒', 'consumable', '20250501-CONS001', 1, '38b5a3f1-a1e8-11f0-8b3f-00ff9a0531b3', '2026-05-01 00:00:00', '2025-11-12 16:57:18');
INSERT INTO `item_stock_relation` VALUES ('a0fb3ca8-a338-11f0-8093-1c8341ca6ed2', '0d780720-a1e8-11f0-8b3f-00ff9a0531b3', 'a6c90f8f-1a59-4ae0-8d43-8639af40c0c8', 'CONS-001', '一次性丁腈手套', 'M号，100只/盒', '盒', 'consumable', '20250510-CONS001', 1, '38b5a3f1-a1e8-11f0-8b3f-00ff9a0531b3', NULL, '2025-10-07 12:46:46');
INSERT INTO `item_stock_relation` VALUES ('a9571a12-a3f4-11f0-ac06-1c8341ca6ed2', 'item001', 'batch001', 'EQ-004', '透射电子显微镜', 'TEM-200kV', '台', 'equipment', NULL, 1, 'loc006', NULL, '2025-10-08 11:12:45');
INSERT INTO `item_stock_relation` VALUES ('a95780bc-a3f4-11f0-ac06-1c8341ca6ed2', 'item002', 'batch002', 'EQ-006', '高效液相色谱仪', 'HPLC-1260', '台', 'equipment', NULL, 1, 'loc007', NULL, '2025-10-08 11:12:45');
INSERT INTO `item_stock_relation` VALUES ('a9579d9c-a3f4-11f0-ac06-1c8341ca6ed2', 'item003', 'batch003', 'MAT-001', '纳米样品载网', '铜网200目', '盒', 'consumable', 'BN-20250401', 50, 'loc006', '2028-03-31 00:00:00', '2025-10-08 11:12:45');
INSERT INTO `item_stock_relation` VALUES ('a957a48a-a3f4-11f0-ac06-1c8341ca6ed2', 'item004', 'batch004', 'CHEM-007', '色谱纯甲醇', '500mL/瓶', '瓶', 'chemical', 'CH-20250501', 30, 'loc007', '2026-10-31 00:00:00', '2025-10-08 11:12:45');
INSERT INTO `item_stock_relation` VALUES ('aa63e1b6-bfa0-11f0-80ed-00ff9a0531b3', '0d780720-a1e8-11f0-8b3f-00ff9a0531b3', '41e9f7ce-a1e8-11f0-8b3f-00ff9a0531b3', 'CONS-001', '一次性丁腈手套', 'M号，100只/盒', '盒', 'consumable', '20250501-CONS001', 28, '38b5a24f-a1e8-11f0-8b3f-00ff9a0531b3', '2026-05-01 00:00:00', '2025-11-12 16:22:02');
INSERT INTO `item_stock_relation` VALUES ('aa640431-bfa0-11f0-80ed-00ff9a0531b3', '0d780720-a1e8-11f0-8b3f-00ff9a0531b3', 'aa64000a-bfa0-11f0-80ed-00ff9a0531b3', 'CONS-001', '一次性丁腈手套', 'M号，100只/盒', '盒', 'consumable', '20250501-CONS001', 1, '38b5a487-a1e8-11f0-8b3f-00ff9a0531b3', '2026-05-01 00:00:00', '2025-11-12 16:22:02');
INSERT INTO `item_stock_relation` VALUES ('b508f417-bfaf-11f0-80ed-00ff9a0531b3', 'item_001', '1998cead-23b1-47f2-a8be-84c27f09006f', 'TEST001', '测试物资', '标准规格', '个', 'consumable', 'BATCH-20251112-139382', 9, '38b5a55d-a1e8-11f0-8b3f-00ff9a0531b3', '2026-02-12 00:00:00', '2025-11-12 18:09:42');
INSERT INTO `item_stock_relation` VALUES ('df3556ad-a335-11f0-8093-1c8341ca6ed2', '550e8400-e29b-41d4-a716-446655440003', 'acec41c2-4234-47e7-8f1f-62f635baa7bb', 'ITEM001', '测试物资', NULL, '个', 'consumable', 'BATCH-20251006-1bc953', 0, '38b5a4f1-a1e8-11f0-8b3f-00ff9a0531b3', '2026-01-30 00:00:00', '2025-10-07 12:27:02');
INSERT INTO `item_stock_relation` VALUES ('df7b98a4-a289-11f0-ba15-1c8341ca6ed2', '0d780720-a1e8-11f0-8b3f-00ff9a0531b3', '525f9274-9891-4b2b-a524-52c685fca763', 'CONS-001', '一次性丁腈手套', 'M号，100只/盒', '盒', 'consumable', 'BATCH-20251006-455804', 1, '38b5a55d-a1e8-11f0-8b3f-00ff9a0531b3', '2026-01-06 00:00:00', '2025-10-06 15:55:49');
INSERT INTO `item_stock_relation` VALUES ('e467ca5f-a1fe-11f0-8b3f-00ff9a0531b3', '0d780a79-a1e8-11f0-8b3f-00ff9a0531b3', '41ea0ea7-a1e8-11f0-8b3f-00ff9a0531b3', 'CONS-002', '移液器吸头', '1000μL，96个/盒', '盒', 'consumable', '20250502-CONS002', 90, '38b5a487-a1e8-11f0-8b3f-00ff9a0531b3', '2027-05-02 00:00:00', '2025-10-05 23:20:57');
INSERT INTO `item_stock_relation` VALUES ('e467ed03-a1fe-11f0-8b3f-00ff9a0531b3', '0d780a79-a1e8-11f0-8b3f-00ff9a0531b3', 'e467e943-a1fe-11f0-8b3f-00ff9a0531b3', 'CONS-002', '移液器吸头', '1000μL，96个/盒', '盒', 'consumable', '20250502-CONS002', 10, '88a92fb8-a1ea-11f0-8b3f-00ff9a0531b3', '2027-05-02 00:00:00', '2025-10-05 23:20:57');
INSERT INTO `item_stock_relation` VALUES ('f9630ae8-bfaf-11f0-80ed-00ff9a0531b3', '550e8400-e29b-41d4-a716-446655440003', 'd3d2cb31-ee1d-4e2a-bad5-0ba3504ab10d', 'ITEM001', '测试物资', NULL, '个', 'consumable', 'BATCH-20251112-8afcbd', 9, 'loc006', '2026-02-12 00:00:00', '2025-11-12 18:11:37');

-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物资编码（唯一）',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物资名称',
  `type` enum('consumable','equipment','chemical') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'consumable' COMMENT '物资类型：耗材/设备/化学品',
  `spec` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '通用规格型号',
  `unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计量单位（如盒/瓶/台/次）',
  `category` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '自定义分类（如玻璃器皿/分析仪器）',
  `min_stock` decimal(14, 3) NULL DEFAULT 0.000 COMMENT '安全库存数量',
  `reorder_point` decimal(14, 3) NULL DEFAULT 0.000 COMMENT '订货点数量',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '推荐供应商ID：关联suppliers.id',
  `active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code` ASC) USING BTREE,
  INDEX `fk_items_supplier`(`supplier_id` ASC) USING BTREE,
  CONSTRAINT `fk_items_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '物资主数据表（统一管理耗材/设备/化学品）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of items
-- ----------------------------
INSERT INTO `items` VALUES ('1', 'CONS001', '一次性离心管', 'consumable', '10mL，100支/盒', '盒', '塑料耗材', 10.000, 5.000, '1', 1);
INSERT INTO `items` VALUES ('10', 'EQP003', '磁力搅拌器', 'equipment', 'IKA RCT basic，5点加热', '台', '加热设备', 5.000, 2.000, '7', 1);
INSERT INTO `items` VALUES ('11 ', 'EQP004', '超声波清洗器', 'equipment', 'KQ-500DE，500mL', '台', '清洗设备', 3.000, 1.000, '7', 1);
INSERT INTO `items` VALUES ('12', 'EQP005', '紫外可见分光光度计', 'equipment', 'Shimadzu UV-1800', '台', '分析仪器', 1.000, 0.000, '8', 1);
INSERT INTO `items` VALUES ('13', 'EQP006', '鼓风干燥箱', 'equipment', 'DHG-9140A，室温+10~250℃', '台', '干燥设备', 2.000, 1.000, '8', 1);
INSERT INTO `items` VALUES ('14', 'EQP007', '高速离心机', 'equipment', 'Sigma 3-18K，最大转速18000rpm', '台', '分离设备', 2.000, 1.000, '9', 1);
INSERT INTO `items` VALUES ('15', 'CHEM001', '乙醇（分析纯）', 'chemical', '500mL/瓶，纯度≥99.7%', '瓶', '有机溶剂', 5.000, 2.000, '11', 1);
INSERT INTO `items` VALUES ('16', 'CHEM002', '硝酸（分析纯）', 'chemical', '500mL/瓶，浓度65%', '瓶', '腐蚀性试剂', 3.000, 1.000, '12', 1);
INSERT INTO `items` VALUES ('17', 'CHEM003', '氯化钠（分析纯）', 'chemical', '500g/瓶，纯度≥99.5%', '瓶', '无机盐', 4.000, 2.000, '11', 1);
INSERT INTO `items` VALUES ('18', 'CHEM004', '氢氧化钠（分析纯）', 'chemical', '500g/瓶，纯度≥98%', '瓶', '腐蚀性试剂', 3.000, 1.000, '12', 1);
INSERT INTO `items` VALUES ('19', 'CHEM005', '甲醇（分析纯）', 'chemical', '500mL/瓶，纯度≥99.8%', '瓶', '有机溶剂', 5.000, 2.000, '13', 1);
INSERT INTO `items` VALUES ('2', 'CONS002', '移液器吸头', 'consumable', '1000μL，96支/盒', '盒', '塑料耗材', 20.000, 10.000, '1', 1);
INSERT INTO `items` VALUES ('20', 'CHEM006', '硫酸（分析纯）', 'chemical', '500mL/瓶，浓度98%', '瓶', '腐蚀性试剂', 2.000, 1.000, '13', 1);
INSERT INTO `items` VALUES ('21', '123', '测试物资', 'consumable', '大号 100只/每盒', '盒', '分析仪器', 100.000, 50.000, '1', 1);
INSERT INTO `items` VALUES ('3', 'CONS003', '培养皿', 'consumable', '90mm，50个/包', '包', '塑料耗材', 15.000, 8.000, '2', 1);
INSERT INTO `items` VALUES ('4', 'CONS004', '定性滤纸', 'consumable', '11cm，100张/盒', '盒', '纸质耗材', 8.000, 4.000, '2', 1);
INSERT INTO `items` VALUES ('5', 'CONS005', '玻璃烧杯', 'consumable', '500mL，10个/箱', '箱', '玻璃器皿', 5.000, 2.000, '3', 1);
INSERT INTO `items` VALUES ('6', 'CONS006', '磁力搅拌子', 'consumable', 'Φ10mm，20个/包', '包', '金属耗材', 6.000, 3.000, '3', 1);
INSERT INTO `items` VALUES ('7', 'CONS007', '一次性丁腈手套', 'consumable', '大号，100只/盒', '盒', '防护耗材', 25.000, 12.000, '4', 1);
INSERT INTO `items` VALUES ('8', 'EQP001', '高效液相色谱仪', 'equipment', 'Agilent 1260，配紫外检测器', '台', '分析仪器', 1.000, 0.000, '6', 1);
INSERT INTO `items` VALUES ('9', 'EQP002', '电子天平', 'equipment', 'Mettler Toledo PL2002，精度0.1mg', '台', '称量仪器', 2.000, 1.000, '6', 1);
INSERT INTO `items` VALUES ('item_001', 'MAT-GLOVE-001', '一次性丁腈手套', 'consumable', 'XL号，100只/盒', '盒', '防护用品', 5.000, 10.000, '1', 1);
INSERT INTO `items` VALUES ('item_002', 'MAT-ALCOHOL-001', '75%酒精消毒液', 'consumable', '500ml/瓶', '瓶', '消毒用品', 3.000, 5.000, '1', 1);

-- ----------------------------
-- Table structure for lab_memberships
-- ----------------------------
DROP TABLE IF EXISTS `lab_memberships`;
CREATE TABLE `lab_memberships`  (
  `lab_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联labs.id',
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联users.id',
  `role_in_lab` enum('member','manager','owner') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'member' COMMENT '实验室内角色：成员/管理员/所有者',
  `active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效（避免删除）',
  PRIMARY KEY (`lab_id`, `user_id`) USING BTREE,
  INDEX `fk_lab_members_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_lab_members_lab` FOREIGN KEY (`lab_id`) REFERENCES `labs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_lab_members_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '实验室-成员关联表（控制实验室级权限）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lab_memberships
-- ----------------------------
INSERT INTO `lab_memberships` VALUES ('1', '1', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('1', '21', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('1', '22', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('1', '23', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('10', '10', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('10', '28', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('10', '29', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('10', '30', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('15', '16', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('2', '2', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('2', '24', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('2', '25', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('2', '26', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('3', '27', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('3', '28', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('3', '29', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('3', '3', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('4', '21', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('4', '22', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('4', '30', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('4', '4', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('5', '23', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('5', '24', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('5', '25', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('5', '5', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('6', '26', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('6', '27', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('6', '28', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('6', '6', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('7', '21', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('7', '29', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('7', '30', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('7', '7', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('8', '16', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('8', '22', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('8', '23', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('8', '24', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('8', '8', 'manager', 1);
INSERT INTO `lab_memberships` VALUES ('9', '25', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('9', '26', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('9', '27', 'member', 1);
INSERT INTO `lab_memberships` VALUES ('9', '9', 'manager', 1);

-- ----------------------------
-- Table structure for labs
-- ----------------------------
DROP TABLE IF EXISTS `labs`;
CREATE TABLE `labs`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实验室编码（唯一）',
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实验室名称',
  `department_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属部门ID：关联departments.id',
  `location_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物理位置描述（如A栋302）',
  `manager_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '实验室负责人ID：关联users.id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code` ASC) USING BTREE,
  INDEX `fk_labs_department`(`department_id` ASC) USING BTREE,
  INDEX `fk_labs_manager`(`manager_id` ASC) USING BTREE,
  CONSTRAINT `fk_labs_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_labs_manager` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '实验室信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of labs
-- ----------------------------
INSERT INTO `labs` VALUES ('1', 'LAB001', '有机化学实验室1', '1', 'A栋101室', '1');
INSERT INTO `labs` VALUES ('10', 'LAB010', '细胞培养实验室2', '2', 'B栋202室', '10');
INSERT INTO `labs` VALUES ('11', 'LAB011', '生物化学实验室1', '2', 'B栋301室', '11');
INSERT INTO `labs` VALUES ('12', 'LAB012', '生物化学实验室2', '2', 'B栋302室', '12');
INSERT INTO `labs` VALUES ('13', 'LAB013', '凝聚态物理实验室1', '3', 'C栋101室', '13');
INSERT INTO `labs` VALUES ('14', 'LAB014', '凝聚态物理实验室2', '3', 'C栋102室', '14');
INSERT INTO `labs` VALUES ('15', 'LAB015', '光学实验室1', '3', 'C栋201室', '15');
INSERT INTO `labs` VALUES ('16', 'LAB016', '光学实验室2', '3', 'C栋202室', '16');
INSERT INTO `labs` VALUES ('17', 'LAB017', '机械加工实验室1', '4', 'D栋101室', '17');
INSERT INTO `labs` VALUES ('18', 'LAB018', '机械加工实验室2', '4', 'D栋102室', '18');
INSERT INTO `labs` VALUES ('19', 'LAB019', '电路实验室1', '4', 'D栋201室', '19');
INSERT INTO `labs` VALUES ('2', 'LAB002', '有机化学实验室2', '1', 'A栋102室', '2');
INSERT INTO `labs` VALUES ('20', 'LAB020', '电路实验室2', '4', 'D栋202室', '20');
INSERT INTO `labs` VALUES ('3', 'LAB003', '无机化学实验室1', '1', 'A栋201室', '3');
INSERT INTO `labs` VALUES ('4', 'LAB004', '无机化学实验室2', '1', 'A栋202室', '4');
INSERT INTO `labs` VALUES ('5', 'LAB005', '材料合成实验室1', '1', 'A栋301室', '5');
INSERT INTO `labs` VALUES ('6', 'LAB006', '材料合成实验室2', '1', 'A栋302室', '6');
INSERT INTO `labs` VALUES ('7', 'LAB007', '分子生物学实验室1', '2', 'B栋101室', '7');
INSERT INTO `labs` VALUES ('8', 'LAB008', '分子生物学实验室2', '2', 'B栋102室', '8');
INSERT INTO `labs` VALUES ('9', 'LAB009', '细胞培养实验室1', '2', 'B栋201室', '9');

-- ----------------------------
-- Table structure for locations
-- ----------------------------
DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '库位编码（唯一）',
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '库位名称',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上级库位ID：关联locations.id（支持层级：仓库→库区→货架→货位）',
  `type` enum('warehouse','zone','rack','bin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'warehouse' COMMENT '库位类型：仓库/库区/货架/货位',
  `temperature_range` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '温控范围（如2-8℃）',
  `hazard_class` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '危化品适配分类（如腐蚀性/易燃性）',
  `active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code` ASC) USING BTREE,
  INDEX `fk_locations_parent`(`parent_id` ASC) USING BTREE,
  CONSTRAINT `fk_locations_parent` FOREIGN KEY (`parent_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '仓储库位表（多级结构）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of locations
-- ----------------------------
INSERT INTO `locations` VALUES ('1', 'WH001', '主仓库', NULL, 'warehouse', '常温（15-25℃）', NULL, 1);
INSERT INTO `locations` VALUES ('10', 'WH002-Z01', '腐蚀性试剂区', '2', 'zone', '2-20℃', '腐蚀性', 1);
INSERT INTO `locations` VALUES ('11', 'WH002-Z02', '易燃试剂区', '2', 'zone', '2-20℃', '易燃性', 1);
INSERT INTO `locations` VALUES ('12', 'WH002-Z03', '毒性试剂区', '2', 'zone', '2-20℃', '毒性', 1);
INSERT INTO `locations` VALUES ('13', 'WH001-Z01-R01', '塑料耗材货架', '6', 'rack', '常温', NULL, 1);
INSERT INTO `locations` VALUES ('14', 'WH001-Z01-R02', '纸质耗材货架', '6', 'rack', '常温', NULL, 1);
INSERT INTO `locations` VALUES ('15', 'WH001-Z01-R03', '金属耗材货架', '6', 'rack', '常温', NULL, 1);
INSERT INTO `locations` VALUES ('16', 'WH001-Z01-R04', '橡胶耗材货架', '6', 'rack', '常温', NULL, 1);
INSERT INTO `locations` VALUES ('17', 'WH001-Z01-R01-B01', '离心管货位', '13', 'bin', '常温', NULL, 1);
INSERT INTO `locations` VALUES ('18', 'WH001-Z01-R01-B02', '移液器吸头货位', '13', 'bin', '常温', NULL, 1);
INSERT INTO `locations` VALUES ('19', 'WH001-Z01-R01-B03', '培养皿货位', '13', 'bin', '常温', '实验耗材', 1);
INSERT INTO `locations` VALUES ('2', 'WH002', '危化品仓库', NULL, 'warehouse', '阴凉（2-20℃）', '腐蚀性/易燃性/毒性', 1);
INSERT INTO `locations` VALUES ('20', 'WH001-Z01-R01-B04', '试剂瓶货位', '13', 'bin', '常温', NULL, 1);
INSERT INTO `locations` VALUES ('3', 'WH003', '低温仓库', NULL, 'warehouse', '冷藏（2-8℃）', NULL, 1);
INSERT INTO `locations` VALUES ('4', 'WH004', '设备仓库', NULL, 'warehouse', '常温干燥', NULL, 1);
INSERT INTO `locations` VALUES ('5', 'WH005', '生物样本库', NULL, 'warehouse', '冷冻（-20℃）', NULL, 1);
INSERT INTO `locations` VALUES ('6', 'WH001-Z01', '耗材库区', '1', 'zone', '常温', NULL, 1);
INSERT INTO `locations` VALUES ('7', 'WH001-Z02', '玻璃器皿库区', '1', 'zone', '常温', NULL, 1);
INSERT INTO `locations` VALUES ('8', 'WH001-Z03', '电子元件库区', '1', 'zone', '常温干燥', NULL, 1);
INSERT INTO `locations` VALUES ('9', 'WH001-Z04', '办公用品库区', '1', 'zone', '常温', NULL, 1);

-- ----------------------------
-- Table structure for maintenance_orders
-- ----------------------------
DROP TABLE IF EXISTS `maintenance_orders`;
CREATE TABLE `maintenance_orders`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `mo_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '维护单号（唯一）',
  `item_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联items.id（仅设备）',
  `batch_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外键：关联stock_batches.id（设备序列号）',
  `type` enum('preventive','repair','calibration') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '维护类型：预防性保养/维修/检定',
  `status` enum('draft','submitted','approving','approved','in_progress','completed','failed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'draft' COMMENT '维护单状态机',
  `scheduled_date` date NULL DEFAULT NULL COMMENT '计划维护日期',
  `completed_at` datetime NULL DEFAULT NULL COMMENT '实际完成时间',
  `downtime_hours` decimal(10, 2) NULL DEFAULT NULL COMMENT '停机小时数',
  `cost` decimal(14, 2) NULL DEFAULT 0.00 COMMENT '维护成本',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维护说明（如故障描述/检定结果）',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of maintenance_orders
-- ----------------------------
INSERT INTO `maintenance_orders` VALUES ('1', 'MO2024001', '8', '8', 'preventive', 'completed', '2025-10-21', '2025-10-21 16:00:00', 8.00, 500.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:06:38');
INSERT INTO `maintenance_orders` VALUES ('10', 'MO2024010', '10', '15', 'calibration', 'approved', '2025-09-10', '2025-09-10 13:04:40', 20.00, 2000.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:36:13');
INSERT INTO `maintenance_orders` VALUES ('11', 'MO2024011', '14', '14', 'calibration', 'completed', '2025-10-03', '2025-10-02 13:06:47', 4.00, 1800.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:10:17');
INSERT INTO `maintenance_orders` VALUES ('12', 'MO2024012', '13', '16', 'calibration', 'completed', '2024-06-05', '2024-06-06 14:00:00', 3.00, 1000.00, NULL, '2025-10-11 18:47:39', '2025-10-11 18:47:39');
INSERT INTO `maintenance_orders` VALUES ('13', 'MO20230203725', '1', '4', 'preventive', 'completed', '2025-10-14', '2025-10-14 12:00:00', 2.10, 763.97, '', '2025-10-16 19:00:36', '2025-10-21 13:34:02');
INSERT INTO `maintenance_orders` VALUES ('14', 'MO20251001', '14', '12', 'calibration', 'failed', '2025-10-21', '2025-10-22 13:12:02', 30.00, 1110.00, NULL, '2025-10-21 13:12:19', '2025-10-21 13:12:19');
INSERT INTO `maintenance_orders` VALUES ('2', 'MO2024002', '9', '10', 'preventive', 'completed', '2025-10-22', '2025-10-21 12:00:00', 4.00, 300.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:37:28');
INSERT INTO `maintenance_orders` VALUES ('3', 'MO2024003', '14', '14', 'repair', 'completed', '2025-10-05', '2025-10-22 13:37:36', 6.00, 400.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:37:48');
INSERT INTO `maintenance_orders` VALUES ('4', 'MO2024004', '12', '15', 'preventive', 'approved', '2025-10-21', '2025-10-20 13:39:23', 0.00, 0.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:39:26');
INSERT INTO `maintenance_orders` VALUES ('5', 'MO2024005', '10', '12', 'repair', 'completed', '2025-10-21', '2025-10-19 10:00:00', 24.00, 1200.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:39:36');
INSERT INTO `maintenance_orders` VALUES ('6', 'MO2024006', '11 ', '13', 'repair', 'failed', '2025-10-21', '2025-10-20 15:00:00', 16.00, 800.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:39:45');
INSERT INTO `maintenance_orders` VALUES ('7', 'MO2024007', '13', '16', 'repair', 'approved', '2025-10-20', '2025-10-20 13:39:50', 0.00, 0.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:39:58');
INSERT INTO `maintenance_orders` VALUES ('8', 'MO2024008', '8', '9', 'repair', 'cancelled', '2025-10-21', '2025-10-20 13:40:02', 0.00, 0.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:40:05');
INSERT INTO `maintenance_orders` VALUES ('9', 'MO2024009', '9', '11', 'calibration', 'completed', '2025-10-21', '2025-10-22 09:00:00', 2.00, 1500.00, NULL, '2025-10-11 18:47:39', '2025-10-21 13:40:16');
INSERT INTO `maintenance_orders` VALUES ('15', 'MO2015011', '14', '14', 'calibration', 'completed', '2025-10-20', NULL, NULL, 0.00, NULL, '2025-10-21 13:33:37', '2025-10-21 13:33:44');
INSERT INTO `maintenance_orders` VALUES ('16', 'MO2025012', '13', '12', 'calibration', 'completed', '2025-10-20', '2025-10-19 13:42:05', 12.00, 0.00, NULL, '2025-10-21 13:42:09', '2025-10-21 13:42:30');
INSERT INTO `maintenance_orders` VALUES ('17', 'MO2025013', '8', '3', 'calibration', 'completed', '2025-10-21', '2025-10-20 13:43:25', 13.00, 0.00, NULL, '2025-10-21 13:43:33', '2025-10-21 13:43:33');
INSERT INTO `maintenance_orders` VALUES ('18', 'MO2025014', '12', '2', 'calibration', 'completed', '2025-10-21', '2025-10-20 13:46:40', 123.00, 0.00, NULL, '2025-10-21 13:46:46', '2025-10-21 13:46:46');
INSERT INTO `maintenance_orders` VALUES ('19', 'MO2025015', '11', '2', 'calibration', 'completed', '0205-10-21', '2025-10-15 13:48:13', 19.00, 0.00, NULL, '2025-10-21 13:48:17', '2025-10-21 13:50:25');

-- ----------------------------
-- Table structure for purchase_order_items
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order_items`;
CREATE TABLE `purchase_order_items`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `po_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联purchase_orders.id',
  `item_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联items.id',
  `qty_ordered` decimal(14, 3) NOT NULL COMMENT '订购数量',
  `qty_received` decimal(14, 3) NOT NULL DEFAULT 0.000 COMMENT '已收货数量',
  `unit_price` decimal(14, 2) NOT NULL DEFAULT 0.00 COMMENT '含税单价',
  `uom` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计量单位',
  `need_by_date` date NULL DEFAULT NULL COMMENT '需求日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_po_item_po`(`po_id` ASC) USING BTREE,
  INDEX `idx_po_item_item`(`item_id` ASC) USING BTREE,
  CONSTRAINT `fk_po_item_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_po_item_po` FOREIGN KEY (`po_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '采购订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of purchase_order_items
-- ----------------------------
INSERT INTO `purchase_order_items` VALUES ('1', '1', '1', 50.000, 52.000, 120.00, '盒', '2024-01-20');
INSERT INTO `purchase_order_items` VALUES ('10', '4', '9', 4.000, 5.000, 6500.00, '台', '2024-02-25');
INSERT INTO `purchase_order_items` VALUES ('11', '4', '10', 5.000, 5.000, 1200.00, '台', '2024-02-25');
INSERT INTO `purchase_order_items` VALUES ('12', '4', '11 ', 3.000, 3.000, 4800.00, '台', '2024-02-25');
INSERT INTO `purchase_order_items` VALUES ('13', '7', '15', 40.000, 40.000, 50.00, '瓶', '2024-03-20');
INSERT INTO `purchase_order_items` VALUES ('14', '7', '17', 30.000, 30.000, 50.00, '瓶', '2024-03-20');
INSERT INTO `purchase_order_items` VALUES ('15', '7', '19', 25.000, 25.000, 65.00, '瓶', '2024-03-20');
INSERT INTO `purchase_order_items` VALUES ('16', '7', '18', 10.000, 10.000, 130.00, '瓶', '2024-03-20');
INSERT INTO `purchase_order_items` VALUES ('17', '8', '16', 20.000, 0.000, 80.00, '瓶', '2024-03-25');
INSERT INTO `purchase_order_items` VALUES ('18', '8', '18', 20.000, 0.000, 130.00, '瓶', '2024-03-25');
INSERT INTO `purchase_order_items` VALUES ('19', '8', '20', 15.000, 0.000, 150.00, '瓶', '2024-03-25');
INSERT INTO `purchase_order_items` VALUES ('2', '1', '2', 40.000, 42.000, 62.50, '盒', '2024-01-20');
INSERT INTO `purchase_order_items` VALUES ('20', '8', '17', 20.000, 0.000, 50.00, '瓶', '2024-03-25');
INSERT INTO `purchase_order_items` VALUES ('3', '1', '3', 25.000, 25.000, 90.00, '包', '2024-01-20');
INSERT INTO `purchase_order_items` VALUES ('4', '1', '4', 15.000, 15.000, 45.00, '盒', '2024-01-20');
INSERT INTO `purchase_order_items` VALUES ('5', '2', '5', 20.000, 21.000, 180.00, '箱', '2024-01-30');
INSERT INTO `purchase_order_items` VALUES ('6', '2', '6', 32.000, 33.000, 81.25, '包', '2024-01-30');
INSERT INTO `purchase_order_items` VALUES ('7', '2', '7', 50.000, 50.000, 35.00, '盒', '2024-01-30');
INSERT INTO `purchase_order_items` VALUES ('8', '2', '1', 10.000, 10.000, 120.00, '盒', '2024-01-30');
INSERT INTO `purchase_order_items` VALUES ('9', '4', '8', 2.000, 2.000, 65000.00, '台', '2024-02-25');
INSERT INTO `purchase_order_items` VALUES ('po_item_001', 'po_test_001', 'item_001', 10.000, 6.000, 50.00, '盒', '2024-06-15');
INSERT INTO `purchase_order_items` VALUES ('po_item_002', 'po_test_001', 'item_002', 5.000, 0.000, 15.00, '瓶', '2024-06-15');

-- ----------------------------
-- Table structure for purchase_orders
-- ----------------------------
DROP TABLE IF EXISTS `purchase_orders`;
CREATE TABLE `purchase_orders`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `po_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '采购订单号（唯一）',
  `requester_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '申请人ID：关联users.id',
  `supplier_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '供应商ID：关联suppliers.id',
  `status` enum('draft','submitted','approving','approved','rejected','ordered','partially_received','received','closed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'draft' COMMENT '订单状态机',
  `expected_date` date NULL DEFAULT NULL COMMENT '期望到货日期',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_po_no`(`po_no` ASC) USING BTREE,
  INDEX `fk_po_supplier`(`supplier_id` ASC) USING BTREE,
  INDEX `idx_po_status`(`status` ASC) USING BTREE,
  INDEX `idx_po_requester`(`requester_id` ASC) USING BTREE,
  CONSTRAINT `fk_po_requester` FOREIGN KEY (`requester_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_po_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '采购订单表头表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of purchase_orders
-- ----------------------------
INSERT INTO `purchase_orders` VALUES ('1', 'PO2024001', '1', '1', 'received', '2024-01-20', '2025-10-11 18:41:44', '2025-11-18 19:37:55');
INSERT INTO `purchase_orders` VALUES ('2', 'PO2024002', '3', '2', 'received', '2024-01-30', '2025-10-11 18:41:44', '2025-11-18 19:38:09');
INSERT INTO `purchase_orders` VALUES ('3', 'PO2024003', '5', '3', 'ordered', '2024-02-10', '2025-10-11 18:41:44', '2025-10-11 18:41:44');
INSERT INTO `purchase_orders` VALUES ('4', 'PO2024004', '2', '6', 'ordered', '2024-02-25', '2025-10-11 18:41:44', '2025-11-18 19:34:45');
INSERT INTO `purchase_orders` VALUES ('5', 'PO2024005', '4', '7', 'received', '2024-03-05', '2025-10-11 18:41:44', '2025-11-18 19:34:56');
INSERT INTO `purchase_orders` VALUES ('6', 'PO2024006', '6', '8', 'received', '2024-03-15', '2025-10-11 18:41:44', '2025-11-18 19:35:00');
INSERT INTO `purchase_orders` VALUES ('7', 'PO2024007', '1', '11', 'ordered', '2024-03-20', '2025-10-11 18:41:44', '2025-11-18 19:35:06');
INSERT INTO `purchase_orders` VALUES ('8', 'PO2024008', '3', '12', 'submitted', '2024-03-25', '2025-10-11 18:41:44', '2025-10-11 18:41:44');
INSERT INTO `purchase_orders` VALUES ('po_test_001', 'PO-TEST-20240601', '1', '1', 'partially_received', '2024-06-10', '2024-06-01 09:30:00', '2025-11-18 20:06:47');

-- ----------------------------
-- Table structure for reservations
-- ----------------------------
DROP TABLE IF EXISTS `reservations`;
CREATE TABLE `reservations`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `item_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联items.id（仅设备）',
  `requester_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '预约人ID：关联users.id',
  `start_time` datetime NOT NULL COMMENT '预约开始时间',
  `end_time` datetime NOT NULL COMMENT '预约结束时间',
  `purpose` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预约备注',
  `status` enum('requested','approving','approved','rejected','checked_in','checked_out','no_show','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'requested' COMMENT '预约状态机',
  `borrow_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联借用单ID：关联borrow_orders.id（签到后生成）',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_reserve_requester`(`requester_id` ASC) USING BTREE,
  INDEX `fk_reserve_borrow`(`borrow_id` ASC) USING BTREE,
  INDEX `idx_reserve_item_time`(`item_id` ASC, `start_time` ASC, `end_time` ASC) USING BTREE,
  INDEX `idx_reserve_status`(`status` ASC) USING BTREE,
  CONSTRAINT `fk_reserve_borrow` FOREIGN KEY (`borrow_id`) REFERENCES `borrow_orders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_reserve_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_reserve_requester` FOREIGN KEY (`requester_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备预约表（时间段预留）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reservations
-- ----------------------------
INSERT INTO `reservations` VALUES ('1', '10', '12', '2025-10-18 21:19:51', '2025-10-19 21:19:57', NULL, 'checked_in', '1', '\'有机样品检测，使用24小时\'', '2025-10-20 21:20:50');
INSERT INTO `reservations` VALUES ('10', '13', '16', '2025-10-15 12:49:11', '2025-10-08 12:49:17', NULL, 'no_show', '2', '‘爽约’', '2025-10-21 12:49:48');
INSERT INTO `reservations` VALUES ('11', '13', '16', '2025-10-21 12:57:48', '2025-10-21 13:57:51', NULL, 'completed', '2', '‘完成’', '2025-10-21 12:58:14');
INSERT INTO `reservations` VALUES ('12', '12', '21', '2025-10-07 12:58:55', '2025-10-07 14:58:59', NULL, 'approved', '10', '‘完成’', '2025-10-21 12:59:15');
INSERT INTO `reservations` VALUES ('13', '17', '23', '2025-10-13 13:00:30', '2025-10-13 14:00:34', NULL, 'no_show', '10', '13', '2025-10-21 13:00:45');
INSERT INTO `reservations` VALUES ('2', '14', '10', '2025-10-07 21:22:52', '2025-10-21 21:22:56', NULL, 'completed', '2', '\'无机试剂称量，持续使用3小时\'', '2025-10-20 21:23:03');
INSERT INTO `reservations` VALUES ('3', '9', '13', '2025-10-20 21:32:13', '2025-10-22 00:41:19', NULL, 'completed', '10', '\'test,10xi\'', '2025-10-20 21:32:38');
INSERT INTO `reservations` VALUES ('4', '8', '11', '2025-10-06 21:33:32', '2025-10-20 21:33:38', NULL, 'checked_in', '10', NULL, '2025-10-20 21:33:49');
INSERT INTO `reservations` VALUES ('5', '10', '10', '2025-10-06 21:35:50', '2025-10-07 21:35:54', NULL, 'completed', '10', NULL, '2025-10-07 21:36:07');
INSERT INTO `reservations` VALUES ('6', '11 ', '10', '2025-10-19 21:37:02', '2025-10-20 21:37:05', NULL, 'checked_in', '10', NULL, '2025-10-14 21:37:17');
INSERT INTO `reservations` VALUES ('7', '12', '10', '2025-10-13 21:38:40', '2025-10-21 21:38:45', NULL, 'completed', '3', '7', '2025-10-20 21:38:49');
INSERT INTO `reservations` VALUES ('8', '13', '1', '2025-10-15 21:39:29', '2025-10-15 22:39:34', NULL, 'completed', '3', NULL, '2025-10-20 21:39:49');
INSERT INTO `reservations` VALUES ('9', '10', '10', '2025-10-13 12:47:33', '2025-10-14 12:47:41', NULL, 'no_show', '10', '‘爽约’', '2025-10-21 12:48:10');
INSERT INTO `reservations` VALUES ('ae9f5516-604a-4a6c-9280-30abdd8f4c79', '9', '10', '2025-11-18 21:33:01', '2025-11-18 22:33:01', '教学', 'requested', NULL, NULL, '2025-11-18 20:37:12');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色编码（唯一，如ADMIN/WAREHOUSE_MANAGER）',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色说明',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('ADMIN', 'ADMIN', '系统管理员', '负责系统配置、用户与角色管理', '2025-10-11 17:35:14');
INSERT INTO `roles` VALUES ('APPROVER', 'APPROVER', '审批人', '负责采购、借用等业务审批', '2025-10-11 17:35:14');
INSERT INTO `roles` VALUES ('LAB_MANAGER', 'LAB_MANAGER', '实验管理员', '负责物资台账、库存与审批配置', '2025-10-11 17:35:14');
INSERT INTO `roles` VALUES ('LAB_USER', 'LAB_USER', '实验人员', '提交借用/预约/请购申请', '2025-10-11 17:35:14');
INSERT INTO `roles` VALUES ('SAFETY_OFFICER', 'SAFETY_OFFICER', '安全合规员', '负责危化品与维护合规监督', '2025-10-11 17:35:14');
INSERT INTO `roles` VALUES ('WAREHOUSE_MANAGER', 'WAREHOUSE_MANAGER', '仓库管理员', '负责入库、出库、盘点操作', '2025-10-11 17:35:14');

-- ----------------------------
-- Table structure for stock_batches
-- ----------------------------
DROP TABLE IF EXISTS `stock_batches`;
CREATE TABLE `stock_batches`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `item_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联items.id',
  `batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '批号（耗材/化学品用）',
  `serial_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '序列号（设备用）',
  `mfg_date` date NULL DEFAULT NULL COMMENT '生产日期',
  `expiry_date` date NULL DEFAULT NULL COMMENT '失效日期（耗材/化学品用）',
  `current_location_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '当前库位ID：关联locations.id',
  `qty_on_hand` decimal(14, 3) NOT NULL DEFAULT 0.000 COMMENT '账面库存数量',
  `status` enum('available','reserved','borrowed','maintenance','disposed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'available' COMMENT '库存状态：可用/预留/已借出/维护中/已报废',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_stock_batch_location`(`current_location_id` ASC) USING BTREE,
  INDEX `idx_item_batch`(`item_id` ASC, `batch_no` ASC) USING BTREE,
  INDEX `idx_item_serial`(`item_id` ASC, `serial_no` ASC) USING BTREE,
  CONSTRAINT `fk_stock_batch_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_stock_batch_location` FOREIGN KEY (`current_location_id`) REFERENCES `locations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '库存批次/序列号表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_batches
-- ----------------------------
INSERT INTO `stock_batches` VALUES ('1', '1', 'CONS001-B202401', '-', '2024-01-10', '2025-01-09', '17', 30.000, 'available');
INSERT INTO `stock_batches` VALUES ('10', '9', '-', 'BAL2024001', '2024-02-10', NULL, '17', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('11', '9', '-', 'BAL2024002', '2024-02-10', NULL, '17', 1.000, 'reserved');
INSERT INTO `stock_batches` VALUES ('11a0f708-b47e-4bf6-9f6a-1e1fbd06f2ff', '7', 'BATCH-20251118-cc9231', NULL, NULL, '2026-02-18', '19', 50.000, 'borrowed');
INSERT INTO `stock_batches` VALUES ('12', '10', '-', 'STIR2024001', '2024-03-05', NULL, '17', 1.000, 'maintenance');
INSERT INTO `stock_batches` VALUES ('13', '11 ', '-', 'ULTRA2024001', '2024-03-15', NULL, '17', 1.000, 'disposed');
INSERT INTO `stock_batches` VALUES ('14', '14', '-', 'CENT2024001', '2024-04-20', NULL, '18', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('15', '15', 'CHEM001-B202403', '-', '2024-03-20', '2025-10-19', '18', 8.000, 'available');
INSERT INTO `stock_batches` VALUES ('16', '16', 'CHEM002-B202404', '-', '2024-04-05', '2024-07-04', '18', 5.000, 'available');
INSERT INTO `stock_batches` VALUES ('17', '17', 'CHEM003-B202404', '-', '2024-04-10', '2025-04-09', '18', 6.000, 'available');
INSERT INTO `stock_batches` VALUES ('18', '18', 'CHEM004-B202404', '-', '2024-04-15', '2024-10-14', '13', 4.000, 'available');
INSERT INTO `stock_batches` VALUES ('19', '19', 'CHEM005-B202405', '-', '2024-05-01', '2024-11-01', '19', 7.000, 'available');
INSERT INTO `stock_batches` VALUES ('1dcd3834-7562-4541-b34a-63063d7fa10b', '6', 'BATCH-20251118-5a4746', NULL, NULL, '2026-02-18', '19', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('2', '2', 'CONS002-B202401', '-', '2024-01-15', '2024-11-04', '19', 40.000, 'available');
INSERT INTO `stock_batches` VALUES ('20', '20', 'CHEM006-B202405', '-', '2024-05-05', '2024-09-13', '20', 3.000, 'available');
INSERT INTO `stock_batches` VALUES ('21', '21', '123', '123123', '2025-11-04', '2025-12-27', '19', 50.000, 'available');
INSERT INTO `stock_batches` VALUES ('2b1c4b88-a3a2-40ed-af10-2f9b4447ccd4', '2', 'BATCH-20251118-2f75aa', NULL, NULL, '2026-02-18', '19', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('3', '3', 'CONS003-B202402', '-', '2024-02-05', '2025-10-31', '20', 22.000, 'available');
INSERT INTO `stock_batches` VALUES ('4', '4', 'CONS004-B202402', '-', '2024-02-10', '2025-02-09', '18', 15.000, 'available');
INSERT INTO `stock_batches` VALUES ('4b5f1d5a-770c-4b6d-9fe3-12d4f1ac0f95', '5', 'BATCH-20251118-25f581', NULL, NULL, '2026-02-18', '19', 20.000, 'available');
INSERT INTO `stock_batches` VALUES ('4f23d137-63af-4671-b7d7-914f92b1f49b', '5', 'BATCH-20251118-ef9a94', NULL, NULL, '2026-02-18', '19', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('5', '5', 'CONS005-B202403', '-', '2024-03-01', '2026-02-28', '19', 10.000, 'available');
INSERT INTO `stock_batches` VALUES ('6', '6', 'CONS006-B202403', '-', '2024-03-05', '2025-03-04', '20', 12.000, 'available');
INSERT INTO `stock_batches` VALUES ('7', '7', 'CONS007-B202404', '-', '2024-04-10', '2024-10-09', '19', 35.000, 'available');
INSERT INTO `stock_batches` VALUES ('8', '8', '-', 'HPLC2024001', '2024-01-20', NULL, '20', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('8693ad10-55c7-419b-a892-4d206cc05f4b', '1', 'BATCH-20251118-859e0f', NULL, NULL, '2026-02-18', '19', 10.000, 'available');
INSERT INTO `stock_batches` VALUES ('87575097-5036-4cd8-9d2a-5512420970c6', '2', 'BATCH-20251118-56ce6c', NULL, NULL, '2026-02-18', '19', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('8cc7cc98-4689-4777-a0c2-40be6a45900b', 'item_001', 'BATCH-20251118-b45530', NULL, NULL, '2026-02-18', '19', 3.000, 'available');
INSERT INTO `stock_batches` VALUES ('9', '8', '-', 'HPLC2024002', '2024-01-20', NULL, '19', 1.000, 'maintenance');
INSERT INTO `stock_batches` VALUES ('9a832a3c-7e6e-47df-941e-ac6a744da561', '3', 'CONS003-B202402', NULL, NULL, NULL, '19', 2.000, 'available');
INSERT INTO `stock_batches` VALUES ('9f51578b-c8f0-4a68-a6a7-7f94fb1b14de', '9', 'BATCH-20251118-21b448', NULL, NULL, '2026-02-18', '19', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('ab24937d-9359-4e13-a836-14d8a45df534', '1', 'BATCH-20251118-a640d7', NULL, NULL, '2026-02-18', '19', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('acae988b-43e6-4581-92a6-e863b2881dee', '6', 'BATCH-20251118-e990b5', NULL, NULL, '2026-02-18', '19', 32.000, 'available');
INSERT INTO `stock_batches` VALUES ('b21026a7-4e59-428a-88f7-4fea761a0ed0', '1', 'BATCH-20251118-733160', NULL, NULL, '2026-02-18', '19', 1.000, 'available');
INSERT INTO `stock_batches` VALUES ('f2c9b611-0c46-4d7e-af33-25b0626bfb5c', 'item_001', 'BATCH-20251118-33d778', NULL, NULL, '2026-02-18', '19', 3.000, 'available');

-- ----------------------------
-- Table structure for stock_count_lines
-- ----------------------------
DROP TABLE IF EXISTS `stock_count_lines`;
CREATE TABLE `stock_count_lines`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `count_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联stock_counts.id',
  `item_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联items.id',
  `batch_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外键：关联stock_batches.id（批次/序列号）',
  `location_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '盘点库位ID：关联locations.id',
  `qty_book` decimal(14, 3) NOT NULL COMMENT '账面数量（从stock_batches同步）',
  `qty_counted` decimal(14, 3) NOT NULL DEFAULT 0.000 COMMENT '实际盘点数量',
  `variance` decimal(14, 3) NOT NULL DEFAULT 0.000 COMMENT '差异数量（盘点数-账面数）',
  `review_status` enum('pending','ok','investigate','adjusted') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT '差异审核状态：待审核/无差异/需调查/已调整',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '差异说明',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_count_line_batch`(`batch_id` ASC) USING BTREE,
  INDEX `fk_count_line_location`(`location_id` ASC) USING BTREE,
  INDEX `idx_count_line_count`(`count_id` ASC) USING BTREE,
  INDEX `idx_count_line_item`(`item_id` ASC) USING BTREE,
  CONSTRAINT `fk_count_line_batch` FOREIGN KEY (`batch_id`) REFERENCES `stock_batches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_count_line_count` FOREIGN KEY (`count_id`) REFERENCES `stock_counts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_count_line_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_count_line_location` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '盘点任务明细表（按物资/批次记录差异）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_count_lines
-- ----------------------------
INSERT INTO `stock_count_lines` VALUES ('1', '1', '1', '1', '13', 30.000, 30.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('10', '5', '6', '6', '15', 12.000, 12.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('11', '5', '4', '4', '14', 15.000, 14.000, -1.000, 'investigate', NULL);
INSERT INTO `stock_count_lines` VALUES ('12', '5', '1', '1', '13', 30.000, 30.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('13', '6', '6', '6', '15', 12.000, 12.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('14', '6', '8', '8', '4', 2.000, 2.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('15', '6', '9', '10', '4', 4.000, 4.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('16', '6', '14', '14', '4', 1.000, 1.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('17', '8', '7', '7', '9', 35.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('18', '8', '4', '4', '14', 15.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('19', '8', '3', '3', '13', 25.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('2', '1', '2', '2', '13', 40.000, 40.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('20', '8', '2', '2', '13', 40.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d600c-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '1', '1', '17', 30.000, 30.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d6431-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '9', '10', '17', 1.000, 1.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d6f79-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '14', '14', '18', 1.000, 1.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d70a0-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '15', '15', '18', 8.000, 8.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d717b-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '16', '16', '18', 5.000, 5.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7265-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '17', '17', '18', 6.000, 6.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d732a-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '18', '18', '13', 4.000, 4.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d73f1-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '19', '19', '19', 7.000, 7.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d74b0-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '2', '2', '19', 40.000, 40.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d757c-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '20', '20', '20', 3.000, 3.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7642-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '21', '21', '19', 50.000, 50.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7702-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '3', '3', '20', 25.000, 25.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d77c8-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '4', '4', '18', 15.000, 15.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7884-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '5', '4b5f1d5a-770c-4b6d-9fe3-12d4f1ac0f95', '19', 20.000, 20.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7949-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '5', '5', '19', 10.000, 10.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7a02-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '6', '6', '20', 12.000, 12.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7abc-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '7', '7', '19', 35.000, 34.000, -1.000, 'investigate', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7bbc-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '8', '8', '20', 1.000, 1.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7c8f-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '1', '8693ad10-55c7-419b-a892-4d206cc05f4b', '19', 10.000, 10.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7d5e-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '6', 'acae988b-43e6-4581-92a6-e863b2881dee', '19', 32.000, 32.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('261d7e1c-c46a-11f0-a379-00ff9a0531b3', 'e735d14b-0167-411e-b6fc-4f3d3b02bf2f', '1', 'b21026a7-4e59-428a-88f7-4fea761a0ed0', '19', 1.000, 1.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('3', '1', '3', '3', '13', 25.000, 25.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07e981-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '1', '1', '17', 30.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07ed1c-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '9', '10', '17', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07ee70-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '14', '14', '18', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07ef51-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '15', '15', '18', 8.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f024-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '16', '16', '18', 5.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f0f7-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '17', '17', '18', 6.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f216-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '18', '18', '13', 4.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f2db-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '19', '19', '19', 7.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f3a3-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '6', '1dcd3834-7562-4541-b34a-63063d7fa10b', '19', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f474-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '2', '2', '19', 40.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f53b-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '20', '20', '20', 3.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f809-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '21', '21', '19', 50.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f8cf-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '2', '2b1c4b88-a3a2-40ed-af10-2f9b4447ccd4', '19', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07f99b-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '3', '3', '20', 22.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07fa69-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '4', '4', '18', 15.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07fb2c-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '5', '4b5f1d5a-770c-4b6d-9fe3-12d4f1ac0f95', '19', 20.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07fbf4-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '5', '4f23d137-63af-4671-b7d7-914f92b1f49b', '19', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07fcb9-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '5', '5', '19', 10.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07fd80-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '6', '6', '20', 12.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07fe9d-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '7', '7', '19', 35.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c07ff69-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '8', '8', '20', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c080030-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '1', '8693ad10-55c7-419b-a892-4d206cc05f4b', '19', 10.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c0800f0-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '2', '87575097-5036-4cd8-9d2a-5512420970c6', '19', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c0801b6-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', 'item_001', '8cc7cc98-4689-4777-a0c2-40be6a45900b', '19', 3.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c080284-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '3', '9a832a3c-7e6e-47df-941e-ac6a744da561', '19', 2.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c080366-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '9', '9f51578b-c8f0-4a68-a6a7-7f94fb1b14de', '19', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c080423-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '1', 'ab24937d-9359-4e13-a836-14d8a45df534', '19', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c0804dc-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '6', 'acae988b-43e6-4581-92a6-e863b2881dee', '19', 32.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c08059c-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', '1', 'b21026a7-4e59-428a-88f7-4fea761a0ed0', '19', 1.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('3c080658-c47a-11f0-a379-00ff9a0531b3', 'db4ac769-c63f-47c8-a085-b07e889cfd30', 'item_001', 'f2c9b611-0c46-4d7e-af33-25b0626bfb5c', '19', 3.000, 0.000, 0.000, 'pending', NULL);
INSERT INTO `stock_count_lines` VALUES ('4', '1', '7', '7', '13', 35.000, 35.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('5', '2', '16', '16', '10', 5.000, 4.000, -1.000, 'adjusted', NULL);
INSERT INTO `stock_count_lines` VALUES ('6', '2', '18', '18', '10', 4.000, 4.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('7', '2', '20', '20', '10', 3.000, 2.000, -1.000, 'adjusted', NULL);
INSERT INTO `stock_count_lines` VALUES ('8', '2', '17', '17', '12', 6.000, 6.000, 0.000, 'ok', NULL);
INSERT INTO `stock_count_lines` VALUES ('9', '5', '5', '5', '7', 10.000, 9.000, -1.000, 'investigate', NULL);

-- ----------------------------
-- Table structure for stock_counts
-- ----------------------------
DROP TABLE IF EXISTS `stock_counts`;
CREATE TABLE `stock_counts`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `count_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '盘点编号（唯一）',
  `location_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '盘点范围起点库位ID：关联locations.id（含子库位）',
  `status` enum('draft','issued','counting','review','approved','adjusted','closed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'draft' COMMENT '盘点任务状态机',
  `initiator_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发起人ID：关联users.id',
  `started_at` datetime NULL DEFAULT NULL COMMENT '盘点开始时间',
  `closed_at` datetime NULL DEFAULT NULL COMMENT '盘点结束时间',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '盘点说明（如季度盘点/专项盘点）',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_count_no`(`count_no` ASC) USING BTREE,
  INDEX `fk_count_initiator`(`initiator_id` ASC) USING BTREE,
  INDEX `idx_count_location`(`location_id` ASC) USING BTREE,
  INDEX `idx_count_status`(`status` ASC) USING BTREE,
  CONSTRAINT `fk_count_initiator` FOREIGN KEY (`initiator_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_count_location` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '盘点任务表头表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_counts
-- ----------------------------
INSERT INTO `stock_counts` VALUES ('058a1871-306f-4068-a5c2-5289ccc87766', 'SC-20251118-004', '1', 'issued', '18', '2025-11-18 18:13:37', NULL, '', '2025-11-18 18:13:29');
INSERT INTO `stock_counts` VALUES ('0acae8ea-f205-4fd7-9292-1e6b41f97b1c', 'SC-20251118-008', '3', 'issued', '18', '2025-11-18 18:26:40', NULL, '', '2025-11-18 18:26:36');
INSERT INTO `stock_counts` VALUES ('1', 'SC2024001', '13', 'closed', '4', '2024-06-01 09:00:00', '2024-06-01 16:00:00', NULL, '2025-10-11 18:48:55');
INSERT INTO `stock_counts` VALUES ('2', 'SC2024002', '10', 'adjusted', '5', '2024-06-02 09:00:00', '2024-06-02 15:30:00', NULL, '2025-10-11 18:48:55');
INSERT INTO `stock_counts` VALUES ('25ee7570-1d6f-4b07-888f-b325a99481dd', 'SC-20251118-005', '1', 'draft', '18', NULL, NULL, '', '2025-11-18 18:14:32');
INSERT INTO `stock_counts` VALUES ('3', 'SC2024003', '4', 'closed', '6', '2024-06-03 08:30:00', '2024-06-03 14:00:00', NULL, '2025-10-11 18:48:55');
INSERT INTO `stock_counts` VALUES ('4', 'SC2024004', '11', 'counting', '4', '2024-06-04 09:00:00', '2025-07-29 13:30:20', NULL, '2025-10-11 18:48:55');
INSERT INTO `stock_counts` VALUES ('5', 'SC2024005', '7', 'review', '5', '2024-06-05 09:00:00', '2025-10-21 13:30:25', NULL, '2025-10-11 18:48:55');
INSERT INTO `stock_counts` VALUES ('530b214c-92cf-4f0f-bab5-0ec722ef29cb', 'SC-20251118-006', '1', 'issued', '18', '2025-11-18 18:24:50', NULL, '', '2025-11-18 18:24:45');
INSERT INTO `stock_counts` VALUES ('6', 'SC2024006', '15', 'counting', '6', '2024-06-06 08:30:00', '2025-10-30 13:30:28', NULL, '2025-10-11 18:48:55');
INSERT INTO `stock_counts` VALUES ('6478f662-2158-4dda-ab89-d4e191018a43', 'SC-20251118-007', '2', 'issued', '18', '2025-11-18 18:26:30', NULL, '', '2025-11-18 18:26:25');
INSERT INTO `stock_counts` VALUES ('7', 'SC2024007', '12', 'draft', '4', '2025-08-12 13:30:39', '2025-10-21 13:30:32', NULL, '2025-10-11 18:48:55');
INSERT INTO `stock_counts` VALUES ('8', 'SC2024008', '9', 'cancelled', '5', '2024-06-07 09:00:00', '2024-06-07 09:30:00', NULL, '2025-10-11 18:48:55');
INSERT INTO `stock_counts` VALUES ('81563769-25dc-40f7-b168-3db8fa6d656b', 'SC-20251118-002', '2', 'counting', '18', '2025-11-18 18:08:08', NULL, '', '2025-11-18 18:05:55');
INSERT INTO `stock_counts` VALUES ('988bbe9d-3291-4bca-8899-08393ddcf4c9', 'SC-20251118-010', '5', 'counting', '18', '2025-11-18 18:26:59', NULL, '', '2025-11-18 18:26:50');
INSERT INTO `stock_counts` VALUES ('aba73cc7-4fa0-481a-bb38-893fe418ef6a', 'SC-20251118-003', '1', 'counting', '18', '2025-11-18 18:09:48', NULL, '', '2025-11-18 18:06:16');
INSERT INTO `stock_counts` VALUES ('d66e20c3-8932-4304-9d9b-fbaabbbd4cc3', 'SC-20251118-009', '4', 'issued', '18', '2025-11-18 18:26:54', NULL, '', '2025-11-18 18:26:45');
INSERT INTO `stock_counts` VALUES ('db4ac769-c63f-47c8-a085-b07e889cfd30', 'SC-20251118-012', '1', 'counting', '18', '2025-11-18 20:29:32', NULL, '', '2025-11-18 20:29:25');
INSERT INTO `stock_counts` VALUES ('e305830b-6976-47a3-beda-82ce1e6abfd7', 'SC-20251118-001', '1', 'counting', '18', '2025-11-18 18:09:37', NULL, '', '2025-11-18 18:05:00');
INSERT INTO `stock_counts` VALUES ('e735d14b-0167-411e-b6fc-4f3d3b02bf2f', 'SC-20251118-011', '1', 'review', '18', '2025-11-18 18:34:23', NULL, '', '2025-11-18 18:34:18');

-- ----------------------------
-- Table structure for stock_transactions
-- ----------------------------
DROP TABLE IF EXISTS `stock_transactions`;
CREATE TABLE `stock_transactions`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID，《Task-D.pdf》表13核心字段）',
  `tx_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '事务发生时间（文档原字段，默认当前时间）',
  `tx_type` enum('receipt','issue','return','transfer','adjustment','dispose','borrow_out','borrow_in','maintenance_out','maintenance_in') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '事务类型（严格按《Task-D.pdf》8.2枚举值，覆盖10类库存操作）',
  `item_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联 items.id（UUID，《Task-D.pdf》表13定义，与物资主表主键类型一致）',
  `batch_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外键：关联 stock_batches.id（UUID，《Task-D.pdf》表13定义，无批次物资可空）',
  `from_location_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '源库位ID：关联 locations.id（UUID，《Task-D.pdf》表13定义，入库时为空）',
  `to_location_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目标库位ID：关联 locations.id（UUID，《Task-D.pdf》表13定义，出库时为空）',
  `qty` decimal(14, 3) NOT NULL COMMENT '事务数量（《Task-D.pdf》表13定义，设备按1或使用量统计）',
  `uom` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计量单位（《Task-D.pdf》表13定义，关联 items.unit 字段）',
  `ref_doc_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联单据类型（《Task-D.pdf》表13定义，如 PO=采购单/BR=借用单/SC=盘点单/MO=维护单）',
  `ref_doc_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联单据ID（UUID，《Task-D.pdf》表13定义，与单据表主键类型一致）',
  `operator_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作人ID：关联 users.id（UUID，《Task-D.pdf》表13定义，记录操作人）',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注（《Task-D.pdf》表13定义，补充事务说明）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tx_batch`(`batch_id` ASC) USING BTREE,
  INDEX `fk_tx_from_location`(`from_location_id` ASC) USING BTREE,
  INDEX `fk_tx_to_location`(`to_location_id` ASC) USING BTREE,
  INDEX `idx_tx_time`(`tx_time` ASC) USING BTREE,
  INDEX `idx_tx_ref`(`ref_doc_type` ASC, `ref_doc_id` ASC) USING BTREE,
  INDEX `idx_tx_item`(`item_id` ASC) USING BTREE,
  INDEX `idx_tx_operator`(`operator_id` ASC) USING BTREE,
  CONSTRAINT `fk_tx_batch` FOREIGN KEY (`batch_id`) REFERENCES `stock_batches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_tx_from_location` FOREIGN KEY (`from_location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_tx_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_tx_operator` FOREIGN KEY (`operator_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_tx_to_location` FOREIGN KEY (`to_location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '库存事务流水表（《Task-D.pdf》表13，全量追溯库存变化）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_transactions
-- ----------------------------
INSERT INTO `stock_transactions` VALUES ('0616ffd4-c473-11f0-a379-00ff9a0531b3', '2025-11-18 19:37:55', 'receipt', '1', 'ab24937d-9359-4e13-a836-14d8a45df534', NULL, '19', 1.000, '盒', 'PURCHASE', '1', '18', '采购入库:IN-20251118193755-012b8a47');
INSERT INTO `stock_transactions` VALUES ('06172d25-c473-11f0-a379-00ff9a0531b3', '2025-11-18 19:37:55', 'receipt', '2', '87575097-5036-4cd8-9d2a-5512420970c6', NULL, '19', 1.000, '盒', 'PURCHASE', '1', '18', '采购入库:IN-20251118193755-012b8a47');
INSERT INTO `stock_transactions` VALUES ('0b7d7db2-458d-4754-a8e0-8caec2aa69ed', '2025-11-18 20:26:21', 'transfer', '3', '3', '20', '19', 1.000, '包', 'TR', 'TR-20251118-001', '18', ' - 吃');
INSERT INTO `stock_transactions` VALUES ('0e772102-c477-11f0-a379-00ff9a0531b3', '2025-11-18 20:06:47', 'receipt', 'item_001', '8cc7cc98-4689-4777-a0c2-40be6a45900b', NULL, '19', 3.000, '盒', 'PURCHASE', 'po_test_001', '18', '采购入库:IN-20251118200647-fd08c66c');
INSERT INTO `stock_transactions` VALUES ('0eb91a97-c473-11f0-a379-00ff9a0531b3', '2025-11-18 19:38:09', 'receipt', '5', '4f23d137-63af-4671-b7d7-914f92b1f49b', NULL, '19', 1.000, '箱', 'PURCHASE', '2', '18', '采购入库:IN-20251118193809-954c7974');
INSERT INTO `stock_transactions` VALUES ('0eb9371b-c473-11f0-a379-00ff9a0531b3', '2025-11-18 19:38:09', 'receipt', '6', '1dcd3834-7562-4541-b34a-63063d7fa10b', NULL, '19', 1.000, '包', 'PURCHASE', '2', '18', '采购入库:IN-20251118193809-954c7974');
INSERT INTO `stock_transactions` VALUES ('0f036066-c461-11f0-a379-00ff9a0531b3', '2025-11-18 17:29:19', 'receipt', '5', '4b5f1d5a-770c-4b6d-9fe3-12d4f1ac0f95', NULL, '19', 20.000, '箱', 'PURCHASE', '2', '18', '采购入库:IN-20251118172919-94028e80');
INSERT INTO `stock_transactions` VALUES ('0f038d4e-c461-11f0-a379-00ff9a0531b3', '2025-11-18 17:29:19', 'receipt', '6', 'acae988b-43e6-4581-92a6-e863b2881dee', NULL, '19', 32.000, '包', 'PURCHASE', '2', '18', '采购入库:IN-20251118172919-94028e80');
INSERT INTO `stock_transactions` VALUES ('0f03aebe-c461-11f0-a379-00ff9a0531b3', '2025-11-18 17:29:19', 'receipt', '7', '11a0f708-b47e-4bf6-9f6a-1e1fbd06f2ff', NULL, '19', 50.000, '盒', 'PURCHASE', '2', '18', '采购入库:IN-20251118172919-94028e80');
INSERT INTO `stock_transactions` VALUES ('0f03cbfc-c461-11f0-a379-00ff9a0531b3', '2025-11-18 17:29:19', 'receipt', '1', '8693ad10-55c7-419b-a892-4d206cc05f4b', NULL, '19', 10.000, '盒', 'PURCHASE', '2', '18', '采购入库:IN-20251118172919-94028e80');
INSERT INTO `stock_transactions` VALUES ('1', '2025-09-01 22:10:05', 'issue', '1', '1', NULL, '13', 50.000, '盒', 'PO', '1', '12', 'PO2024001 收货：一次性离心管，存塑料耗材货架');
INSERT INTO `stock_transactions` VALUES ('10', '2025-10-12 22:10:05', 'issue', '14', '14', '4', NULL, 1.000, '台', 'BR', '6', '12', 'BOR2024006 发料：高速离心机，实验室6借用（超期）');
INSERT INTO `stock_transactions` VALUES ('11', '2025-09-01 22:10:05', 'issue', '1', '1', NULL, '13', 5.000, '盒', 'BR', '1', '12', 'BOR2024001 退料：一次性离心管，实验室1归还');
INSERT INTO `stock_transactions` VALUES ('12', '2025-10-12 22:10:05', 'return', '8', '8', NULL, '4', 1.000, '台', 'BR', '4', '24', 'BOR2024004 退料：高效液相色谱仪，实验室4归还');
INSERT INTO `stock_transactions` VALUES ('13', '2025-10-12 22:10:05', 'return', '16', '16', NULL, '10', 3.000, '瓶', 'BR', '8', '12', 'BOR2024008 退料：硝酸，实验室8归还（未用完）');
INSERT INTO `stock_transactions` VALUES ('14', '2025-10-12 22:10:05', 'return', '7', '7', NULL, '9', 2.000, '盒', 'BR', '1', '24', 'BOR2024001 退料：一次性丁腈手套，实验室1归还');
INSERT INTO `stock_transactions` VALUES ('15', '2025-10-12 22:10:05', 'return', '14', '14', NULL, '4', 1.000, '台', 'BR', '6', '12', 'BOR2024006 退料：高速离心机，实验室6超期归还');
INSERT INTO `stock_transactions` VALUES ('16', '2025-09-01 22:10:05', 'transfer', '1', '1', '13', '7', 10.000, '盒', 'TR', '0', '12', '调拨：一次性离心管从塑料耗材货架（13）到玻璃器皿库区（7）');
INSERT INTO `stock_transactions` VALUES ('17', '2025-10-12 22:10:05', 'transfer', '8', '8', '4', '13', 1.000, '台', 'TR', '0', '24', '调拨：高效液相色谱仪从设备仓库（4）到塑料耗材货架（13）（临时）');
INSERT INTO `stock_transactions` VALUES ('18', '2025-10-12 22:10:05', 'transfer', '16', '16', '10', '11', 2.000, '瓶', 'TR', '0', '12', '调拨：硝酸从腐蚀性试剂区（10）到易燃试剂区（11）（临时存储）');
INSERT INTO `stock_transactions` VALUES ('18cdb1b2-c461-11f0-a379-00ff9a0531b3', '2025-11-18 17:29:35', 'receipt', '1', 'b21026a7-4e59-428a-88f7-4fea761a0ed0', NULL, '19', 1.000, '盒', 'PURCHASE', '1', '18', '采购入库:IN-20251118172935-eb561ea8');
INSERT INTO `stock_transactions` VALUES ('19', '2025-10-12 22:10:05', 'issue', '5', '5', '7', '15', 3.000, '箱', 'TR', '0', '24', '调拨：玻璃烧杯从玻璃器皿库区（7）到金属耗材货架（15）');
INSERT INTO `stock_transactions` VALUES ('1dd158a4-adc4-11f0-b4a1-005056c00001', '2025-07-15 10:00:00', 'issue', '1', '1', '13', NULL, 200.000, '盒', 'BR', 'BOR2024001', '24', '一次性离心管出库，实验室1领用');
INSERT INTO `stock_transactions` VALUES ('1dd1667a-adc4-11f0-b4a1-005056c00001', '2025-07-20 14:30:00', 'issue', '1', '1', '13', NULL, 150.000, '盒', 'BR', 'BOR2024002', '24', '一次性离心管出库，实验室2领用');
INSERT INTO `stock_transactions` VALUES ('1dd16811-adc4-11f0-b4a1-005056c00001', '2025-08-05 09:15:00', 'issue', '1', '1', '13', NULL, 100.000, '盒', 'BR', 'BOR2024003', '24', '一次性离心管出库，实验室3领用');
INSERT INTO `stock_transactions` VALUES ('1de2766e-adc4-11f0-b4a1-005056c00001', '2025-07-10 11:00:00', 'issue', '2', '2', '13', NULL, 300.000, '盒', 'BR', 'BOR2024004', '24', '移液器吸头出库，实验室4领用');
INSERT INTO `stock_transactions` VALUES ('1de27ea8-adc4-11f0-b4a1-005056c00001', '2025-07-18 15:20:00', 'issue', '2', '2', '13', NULL, 250.000, '盒', 'BR', 'BOR2024005', '24', '移液器吸头出库，实验室5领用');
INSERT INTO `stock_transactions` VALUES ('1de280fd-adc4-11f0-b4a1-005056c00001', '2025-08-02 10:30:00', 'issue', '2', '2', '13', NULL, 200.000, '盒', 'BR', 'BOR2024006', '24', '移液器吸头出库，实验室6领用');
INSERT INTO `stock_transactions` VALUES ('1df4d755-adc4-11f0-b4a1-005056c00001', '2025-07-05 09:30:00', 'issue', '3', '3', '13', NULL, 100.000, '包', 'BR', 'BOR2024007', '24', '培养皿出库，实验室7领用');
INSERT INTO `stock_transactions` VALUES ('1df4e663-adc4-11f0-b4a1-005056c00001', '2025-07-22 13:10:00', 'issue', '3', '3', '13', NULL, 80.000, '包', 'BR', 'BOR2024008', '24', '培养皿出库，实验室8领用');
INSERT INTO `stock_transactions` VALUES ('1df4ea84-adc4-11f0-b4a1-005056c00001', '2025-08-08 16:40:00', 'issue', '3', '3', '13', NULL, 120.000, '包', 'BR', 'BOR2024009', '24', '培养皿出库，实验室9领用');
INSERT INTO `stock_transactions` VALUES ('1e0647e5-adc4-11f0-b4a1-005056c00001', '2025-07-12 14:00:00', 'issue', '4', '4', '14', NULL, 150.000, '盒', 'BR', 'BOR2024010', '24', '定性滤纸出库，实验室10领用');
INSERT INTO `stock_transactions` VALUES ('1e0663d3-adc4-11f0-b4a1-005056c00001', '2025-07-25 11:30:00', 'issue', '4', '4', '14', NULL, 120.000, '盒', 'BR', 'BOR2024011', '24', '定性滤纸出库，实验室11领用');
INSERT INTO `stock_transactions` VALUES ('1e066bef-adc4-11f0-b4a1-005056c00001', '2025-08-03 12:10:00', 'issue', '4', '4', '14', NULL, 180.000, '盒', 'BR', 'BOR2024012', '24', '定性滤纸出库，实验室12领用');
INSERT INTO `stock_transactions` VALUES ('2', '2025-10-12 22:10:05', 'receipt', '8', '8', NULL, '4', 2.000, '台', 'PO', '4', '24', 'PO2024004 收货：高效液相色谱仪，存设备仓库');
INSERT INTO `stock_transactions` VALUES ('20', '2025-10-12 22:10:05', 'transfer', '9', '10', '4', '7', 1.000, '台', 'TR', '0', '12', '调拨：电子天平从设备仓库（4）到玻璃器皿库区（7）（实验临时用）');
INSERT INTO `stock_transactions` VALUES ('21', '2025-10-12 22:10:05', 'adjustment', '16', '16', '10', '10', -1.000, '瓶', 'SC', '2', '3', 'SC2024002 差异调整：硝酸短缺1瓶（损耗）');
INSERT INTO `stock_transactions` VALUES ('22', '2025-08-12 22:10:05', 'adjustment', '20', '20', '10', '10', -1.000, '瓶', 'SC', '2', '5', 'SC2024002 差异调整：硫酸短缺1瓶（过期）');
INSERT INTO `stock_transactions` VALUES ('23', '2025-10-12 22:10:05', 'adjustment', '5', '5', '7', '7', -1.000, '箱', 'SC', '5', '3', 'SC2024005 差异调整：玻璃烧杯短缺1箱（破损）');
INSERT INTO `stock_transactions` VALUES ('24', '2025-10-12 22:10:05', 'adjustment', '4', '4', '14', '14', 2.000, '盒', 'SC', '5', '5', 'SC2024005 差异调整：定性滤纸多2盒（漏记）');
INSERT INTO `stock_transactions` VALUES ('25', '2025-10-12 22:10:05', 'issue', '7', '7', '9', '9', 2.000, '盒', 'SC', '2', '3', 'SC2024002 差异调整：丁腈手套短缺3盒（遗失）');
INSERT INTO `stock_transactions` VALUES ('26', '2025-10-12 22:10:05', 'dispose', '4', '4', '14', NULL, 2.000, '盒', 'DS', '0', '5', '报废：定性滤纸过期（2024-02-10生产）');
INSERT INTO `stock_transactions` VALUES ('27', '2025-07-28 22:10:05', 'dispose', '19', '19', '11', NULL, 3.000, '瓶', 'DS', '0', '23', '报废：甲醇过期（2024-05-01生产，易燃）');
INSERT INTO `stock_transactions` VALUES ('28', '2025-10-12 22:10:05', 'dispose', '10', '12', '4', NULL, 1.000, '台', 'DS', '0', '5', '报废：磁力搅拌器损坏（无法维修）');
INSERT INTO `stock_transactions` VALUES ('29', '2025-09-04 22:10:05', 'maintenance_out', '9', '11', '4', NULL, 1.000, '台', 'MO', '9', '6', 'MO2024009 外送：电子天平检定（精度校准）');
INSERT INTO `stock_transactions` VALUES ('3', '2025-10-12 22:10:05', 'receipt', '16', '16', NULL, '10', 20.000, '瓶', 'PO', '8', '12', 'PO2024008 收货：硝酸，存腐蚀性试剂区');
INSERT INTO `stock_transactions` VALUES ('30', '2025-10-12 22:10:05', 'maintenance_in', '9', '11', NULL, '4', 1.000, '台', 'MO', '9', '18', 'MO2024009 归还：电子天平检定完成（合格）');
INSERT INTO `stock_transactions` VALUES ('39ce92e5-ca45-4f61-b6a2-fbfda597a7a9', '2025-11-18 20:50:53', 'borrow_in', '3', '3', NULL, '20', 1.000, '包', 'BR', 'bee52f71-82b2-4b41-b75f-d2c0d03b0234', '10', 'bee52f71-82b2-4b41-b75f-d2c0d03b0234');
INSERT INTO `stock_transactions` VALUES ('4', '2025-08-05 22:10:05', 'receipt', '15', '15', NULL, '11', 40.000, '瓶', 'PO', '7', '24', 'PO2024007 收货：乙醇，存易燃试剂区');
INSERT INTO `stock_transactions` VALUES ('435fe80f-52d1-4636-acd5-49931b824f7f', '2025-11-18 20:27:38', 'transfer', '3', '3', '20', '19', 1.000, '包', 'TR', 'TR-20251118-002', '18', ' - ');
INSERT INTO `stock_transactions` VALUES ('4cde7987-adc4-11f0-b4a1-005056c00001', '2025-07-01 09:00:00', 'issue', '7', '7', '13', NULL, 50.000, '盒', 'BR', 'BOR2024013', '24', '一次性丁腈手套出库，实验室13领用');
INSERT INTO `stock_transactions` VALUES ('4cde83c8-adc4-11f0-b4a1-005056c00001', '2025-07-15 13:30:00', 'issue', '7', '7', '13', NULL, 40.000, '盒', 'BR', 'BOR2024014', '24', '一次性丁腈手套出库，实验室14领用');
INSERT INTO `stock_transactions` VALUES ('4cde868c-adc4-11f0-b4a1-005056c00001', '2025-08-01 10:15:00', 'issue', '7', '7', '13', NULL, 60.000, '盒', 'BR', 'BOR2024015', '24', '一次性丁腈手套出库，实验室15领用');
INSERT INTO `stock_transactions` VALUES ('4cef1a2a-adc4-11f0-b4a1-005056c00001', '2025-07-03 11:00:00', 'issue', '5', '5', '13', NULL, 20.000, '箱', 'BR', 'BOR2024016', '24', '玻璃烧杯出库，实验室16领用');
INSERT INTO `stock_transactions` VALUES ('4cef35bc-adc4-11f0-b4a1-005056c00001', '2025-07-20 15:00:00', 'issue', '5', '5', '13', NULL, 15.000, '箱', 'BR', 'BOR2024017', '24', '玻璃烧杯出库，实验室17领用');
INSERT INTO `stock_transactions` VALUES ('4cef4336-adc4-11f0-b4a1-005056c00001', '2025-08-05 14:30:00', 'issue', '5', '5', '13', NULL, 25.000, '箱', 'BR', 'BOR2024018', '24', '玻璃烧杯出库，实验室18领用');
INSERT INTO `stock_transactions` VALUES ('4d034d68-adc4-11f0-b4a1-005056c00001', '2025-07-08 10:30:00', 'issue', '6', '6', '13', NULL, 30.000, '包', 'BR', 'BOR2024019', '24', '磁力搅拌子出库，实验室19领用');
INSERT INTO `stock_transactions` VALUES ('4d035985-adc4-11f0-b4a1-005056c00001', '2025-07-25 16:00:00', 'issue', '6', '6', '13', NULL, 25.000, '包', 'BR', 'BOR2024020', '24', '磁力搅拌子出库，实验室20领用');
INSERT INTO `stock_transactions` VALUES ('4d035dde-adc4-11f0-b4a1-005056c00001', '2025-08-10 11:15:00', 'issue', '6', '6', '13', NULL, 35.000, '包', 'BR', 'BOR2024021', '24', '磁力搅拌子出库，实验室21领用');
INSERT INTO `stock_transactions` VALUES ('4d177858-adc4-11f0-b4a1-005056c00001', '2025-07-02 14:00:00', 'issue', '15', '15', '14', NULL, 10.000, '瓶', 'BR', 'BOR2024022', '24', '乙醇（分析纯）出库，实验室22领用');
INSERT INTO `stock_transactions` VALUES ('4d178a3a-adc4-11f0-b4a1-005056c00001', '2025-07-12 15:30:00', 'issue', '15', '15', '14', NULL, 8.000, '瓶', 'BR', 'BOR2024023', '24', '乙醇（分析纯）出库，实验室23领用');
INSERT INTO `stock_transactions` VALUES ('4d178c0f-adc4-11f0-b4a1-005056c00001', '2025-08-02 13:45:00', 'issue', '15', '15', '14', NULL, 12.000, '瓶', 'BR', 'BOR2024024', '24', '乙醇（分析纯）出库，实验室24领用');
INSERT INTO `stock_transactions` VALUES ('4d27ab92-adc4-11f0-b4a1-005056c00001', '2025-07-05 16:30:00', 'issue', '16', '16', '14', NULL, 5.000, '瓶', 'BR', 'BOR2024025', '24', '硝酸（分析纯）出库，实验室25领用');
INSERT INTO `stock_transactions` VALUES ('4d27b377-adc4-11f0-b4a1-005056c00001', '2025-07-22 14:15:00', 'issue', '16', '16', '14', NULL, 4.000, '瓶', 'BR', 'BOR2024026', '24', '硝酸（分析纯）出库，实验室26领用');
INSERT INTO `stock_transactions` VALUES ('4d27b52c-adc4-11f0-b4a1-005056c00001', '2025-08-08 15:30:00', 'issue', '16', '16', '14', NULL, 6.000, '瓶', 'BR', 'BOR2024027', '24', '硝酸（分析纯）出库，实验室27领用');
INSERT INTO `stock_transactions` VALUES ('5', '2025-09-05 22:10:05', 'receipt', '9', '10', NULL, '4', 4.000, '台', 'PO', '4', '12', 'PO2024004 收货：电子天平，存设备仓库');
INSERT INTO `stock_transactions` VALUES ('6', '2025-10-08 22:10:05', 'issue', '1', '1', '13', NULL, 5.000, '盒', 'BR', '1', '12', 'BOR2024001 发料：一次性离心管，实验室1领用');
INSERT INTO `stock_transactions` VALUES ('7', '2025-10-23 22:10:05', 'issue', '8', '8', '4', NULL, 1.000, '台', 'BR', '4', '24', 'BOR2024004 发料：高效液相色谱仪，实验室4借用');
INSERT INTO `stock_transactions` VALUES ('8', '2025-09-16 22:10:05', 'issue', '16', '16', '10', NULL, 5.000, '瓶', 'BR', '8', '12', 'BOR2024008 发料：硝酸，实验室8领用（危化品）');
INSERT INTO `stock_transactions` VALUES ('9', '2025-09-08 22:10:05', 'issue', '7', '7', '9', NULL, 2.000, '盒', 'BR', '1', '24', 'BOR2024001 发料：一次性丁腈手套，实验室1领用');
INSERT INTO `stock_transactions` VALUES ('a67f8ccc-b727-420c-89f3-dbd1f9759ab2', '2025-11-18 20:18:41', 'issue', '3', '3', '20', NULL, 1.000, '包', 'OUT', 'OUT-20251118-001', '18', '领用（实验室） - ');
INSERT INTO `stock_transactions` VALUES ('c290f3f3-c46e-11f0-a379-00ff9a0531b3', '2025-11-18 19:07:23', 'receipt', '2', '2b1c4b88-a3a2-40ed-af10-2f9b4447ccd4', NULL, '19', 1.000, '盒', 'PURCHASE', '1', '18', '采购入库:IN-20251118190723-40b14cad');
INSERT INTO `stock_transactions` VALUES ('d2558206-c46e-11f0-a379-00ff9a0531b3', '2025-11-18 19:07:50', 'receipt', '9', '9f51578b-c8f0-4a68-a6a7-7f94fb1b14de', NULL, '19', 1.000, '台', 'PURCHASE', '4', '18', '采购入库:IN-20251118190750-f2b548f6');
INSERT INTO `stock_transactions` VALUES ('fc721a12-c476-11f0-a379-00ff9a0531b3', '2025-11-18 20:06:16', 'receipt', 'item_001', 'f2c9b611-0c46-4d7e-af33-25b0626bfb5c', NULL, '19', 3.000, '盒', 'PURCHASE', 'po_test_001', '18', '采购入库:IN-20251118200616-a2501e6c');

-- ----------------------------
-- Table structure for suppliers
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '供应商名称（唯一）',
  `contact_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系邮箱',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `rating` int NULL DEFAULT NULL COMMENT '评分（1-5分）',
  `active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '供应商信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
INSERT INTO `suppliers` VALUES ('1', '科仪耗材有限公司', '张三', '13800138001', 'supply_consum1@lab.com', '北京市海淀区中关村大街1号', 5, 1);
INSERT INTO `suppliers` VALUES ('10', '国产设备制造中心', '冯二', '13800138010', 'supply_eqp5@lab.com', '成都市武侯区天府大道158号', 4, 1);
INSERT INTO `suppliers` VALUES ('11', '化学试剂有限公司', '陈三', '13800138011', 'supply_chem1@lab.com', '武汉市洪山区珞喻路1037号', 5, 1);
INSERT INTO `suppliers` VALUES ('12', '危化品专营公司', '褚四', '13800138012', 'supply_chem2@lab.com', '青岛市市南区香港中路66号', 4, 1);
INSERT INTO `suppliers` VALUES ('13', '高纯试剂研发中心', '卫五', '13800138013', 'supply_chem3@lab.com', '西安市雁塔区长安中路38号', 5, 1);
INSERT INTO `suppliers` VALUES ('14', '标准品供应公司', '蒋六', '13800138014', 'supply_chem4@lab.com', '长沙市岳麓区麓山南路932号', 4, 1);
INSERT INTO `suppliers` VALUES ('15', '有机溶剂配送中心', '沈七', '13800138015', 'supply_chem5@lab.com', '重庆市渝中区解放碑1号', 3, 1);
INSERT INTO `suppliers` VALUES ('16', '实验室物资综合商城', '韩八', '13800138016', 'supply_all1@lab.com', '北京市朝阳区建国路88号', 4, 1);
INSERT INTO `suppliers` VALUES ('17', '跨国实验室供应商', '杨九', '13800138017', 'supply_all2@lab.com', '上海市浦东新区陆家嘴环路100号', 5, 1);
INSERT INTO `suppliers` VALUES ('18', '区域实验室服务商', '朱十', '13800138018', 'supply_all3@lab.com', '广州市海珠区滨江东路500号', 3, 0);
INSERT INTO `suppliers` VALUES ('19', '高校专属供应商', '秦一', '13800138019', 'supply_all4@lab.com', '杭州市滨江区江南大道1000号', 5, 1);
INSERT INTO `suppliers` VALUES ('2', '实验耗材批发中心', '李四', '13800138002', 'supply_consum2@lab.com', '上海市浦东新区张江路88号', 4, 1);
INSERT INTO `suppliers` VALUES ('20', '应急物资供应站', '尤二', '13800138020', 'supply_all5@lab.com', '深圳市福田区深南大道100号', 4, 1);
INSERT INTO `suppliers` VALUES ('3', '环球耗材贸易公司', '王五', '13800138003', 'supply_consum3@lab.com', '广州市天河区天河路385号', 4, 1);
INSERT INTO `suppliers` VALUES ('4', '东方实验室耗材厂', '赵六', '13800138004', 'supply_consum4@lab.com', '深圳市南山区科技园12号', 3, 1);
INSERT INTO `suppliers` VALUES ('5', '华北耗材配送中心', '孙七', '13800138005', 'supply_consum5@lab.com', '天津市南开区长江道92号', 5, 1);
INSERT INTO `suppliers` VALUES ('6', '精密仪器设备厂', '周八', '13800138006', 'supply_eqp1@lab.com', '苏州市工业园区金鸡湖路158号', 5, 1);
INSERT INTO `suppliers` VALUES ('7', '分析仪器贸易公司', '吴九', '13800138007', 'supply_eqp2@lab.com', '杭州市西湖区文三路45号', 4, 1);
INSERT INTO `suppliers` VALUES ('8', '实验室设备研究院', '郑十', '13800138008', 'supply_eqp3@lab.com', '南京市玄武区珠江路68号', 5, 1);
INSERT INTO `suppliers` VALUES ('9', '进口仪器代理公司', '钱一', '13800138009', 'supply_eqp4@lab.com', '上海市黄浦区外滩路12号', 3, 1);

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles`  (
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联users.id',
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外键：关联roles.id',
  `assigned_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '指派人ID：关联users.id',
  `assigned_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '指派时间',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `fk_user_roles_role`(`role_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户-角色关联表（多对多）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_roles
-- ----------------------------
INSERT INTO `user_roles` VALUES ('1', 'ADMIN', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('10', 'LAB_USER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('11', 'SAFETY_OFFICER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('12', 'WAREHOUSE_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('13', 'ADMIN', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('14', 'APPROVER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('15', 'LAB_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('16', 'LAB_USER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('17', 'SAFETY_OFFICER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('18', 'WAREHOUSE_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('19', 'ADMIN', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('2', 'LAB_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('20', 'APPROVER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('21', 'LAB_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('22', 'LAB_USER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('23', 'SAFETY_OFFICER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('24', 'WAREHOUSE_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('25', 'ADMIN', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('26', 'APPROVER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('27', 'LAB_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('28', 'LAB_USER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('29', 'SAFETY_OFFICER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('3', 'LAB_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('30', 'WAREHOUSE_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('4', 'LAB_USER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('5', 'SAFETY_OFFICER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('6', 'WAREHOUSE_MANAGER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('7', 'ADMIN', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('8', 'APPROVER', 'jw', '2025-10-11 17:59:24');
INSERT INTO `user_roles` VALUES ('9', 'LAB_MANAGER', 'jw', '2025-10-11 17:59:24');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键（UUID）',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名（唯一）',
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码哈希（建议使用BCrypt算法）',
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户姓名',
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱（唯一）',
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` enum('active','disabled','locked') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'active' COMMENT '账户状态：启用/禁用/锁定',
  `last_login_at` datetime NULL DEFAULT NULL COMMENT '最近登录时间',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `uk_email`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', '1', '123', 'Arimura Aoi', 'aoi9@mail.com', '66-373-4036', 'active', '2017-09-19 14:47:11', '2021-06-05 06:38:36', '2025-11-18 16:55:08');
INSERT INTO `users` VALUES ('10', '1234', '123', 'Sean Simmons', 'sisean@hotmail.com', '718-990-4908', 'active', '2005-11-11 17:44:45', '2021-02-17 09:23:53', '2025-11-18 16:56:23');
INSERT INTO `users` VALUES ('11', '123456', '123', 'Emma Ford', 'fordemma@gmail.com', '74-847-0539', 'active', '2002-08-17 08:36:31', '2020-11-27 13:43:12', '2025-11-18 16:56:57');
INSERT INTO `users` VALUES ('12', 'Joe Johnson', '4b25Rqmhlr', 'Joe Johnson', 'johnsonj4@outlook.com', '755-184-9669', 'active', '2018-05-12 04:01:29', '2008-05-11 08:32:29', '2022-07-21 13:48:55');
INSERT INTO `users` VALUES ('13', 'Peter Wilson', 'a0zFX3Omt3', 'Peter Wilson', 'peter67@hotmail.com', '154-8425-6295', 'locked', '2007-10-24 10:11:11', '2011-04-09 07:27:13', '2023-11-12 02:31:41');
INSERT INTO `users` VALUES ('14', 'Jerry Fisher', 'YGgmTuAyTv', 'Jerry Fisher', 'jerryfi@mail.com', '80-8259-6617', 'active', '2025-07-09 20:28:47', '2014-09-29 11:33:25', '2019-01-30 02:18:33');
INSERT INTO `users` VALUES ('15', '12', '123', 'Yuen Hiu Tung', 'yuenht1019@outlook.com', '760-0842-1441', 'active', '2007-03-05 21:04:35', '2011-09-27 17:53:32', '2025-11-18 16:57:35');
INSERT INTO `users` VALUES ('16', 'Che Sze Kwan', '1UJhW7ErkA', 'Che Sze Kwan', 'cszekwan@outlook.com', '5799 805984', 'active', '2004-12-13 23:59:04', '2011-08-11 04:37:27', '2022-08-31 03:54:02');
INSERT INTO `users` VALUES ('17', 'Ueda Nanami', '3QcKlZT8n0', 'Ueda Nanami', 'nu8@outlook.com', '90-9554-8018', 'disabled', '2012-04-01 01:04:47', '2003-05-11 02:34:45', '2021-01-24 00:10:34');
INSERT INTO `users` VALUES ('18', '123', '123', 'Ichikawa Nanami', 'naichik60@gmail.com', '172-8522-4110', 'active', '2009-05-01 04:32:21', '2023-06-14 04:33:51', '2025-11-18 16:54:18');
INSERT INTO `users` VALUES ('19', 'Fang Yunxi', 'zHFN41UrSl', 'Fang Yunxi', 'yunfang2@outlook.com', '80-4488-3897', 'active', '2016-03-16 21:12:25', '2023-05-28 04:03:25', '2003-04-02 05:38:22');
INSERT INTO `users` VALUES ('2', '张三', '123456', 'Jonathan Rivera', 'rivera3@hotmail.com', '11-507-3017', 'active', '2012-06-13 23:17:24', '2004-03-09 00:24:46', '2025-10-11 19:14:24');
INSERT INTO `users` VALUES ('20', '12345', '123', 'Takahashi Yuito', 'takahashiyuito@gmail.com', '90-1634-0116', 'active', '2004-09-10 09:09:55', '2006-03-11 08:09:24', '2025-11-18 16:56:38');
INSERT INTO `users` VALUES ('21', 'Takagi Takuya', 'u9AAukfao0', 'Takagi Takuya', 'taktakagi410@gmail.com', '614-738-2882', 'disabled', '2004-09-19 09:55:19', '2021-01-21 20:49:34', '2013-02-24 02:52:58');
INSERT INTO `users` VALUES ('22', 'Mori Kaito', 'dj4tYfKjP5', 'Mori Kaito', 'mori07@icloud.com', '153-8502-1628', 'locked', '2006-05-27 10:08:36', '2011-08-19 23:13:53', '2005-03-16 00:41:36');
INSERT INTO `users` VALUES ('23', 'Luis Graham', 'bQnU0SUVop', 'Luis Graham', 'grahlui2@outlook.com', '189-6083-5560', 'locked', '2005-12-01 05:07:32', '2022-03-04 02:12:29', '2019-11-19 13:13:49');
INSERT INTO `users` VALUES ('24', 'Fan Yuning', 'sHaKGjbQdi', 'Fan Yuning', 'fany@outlook.com', '7280 530710', 'locked', '2021-12-28 19:00:02', '2004-02-05 15:05:23', '2003-12-13 14:04:14');
INSERT INTO `users` VALUES ('25', 'Robin Barnes', 'yoO0BmU5y9', 'Robin Barnes', 'rbarnes2005@hotmail.com', '74-982-6862', 'locked', '2003-11-25 08:58:25', '2001-11-26 19:57:19', '2009-02-19 20:38:42');
INSERT INTO `users` VALUES ('26', 'Kato Kazuma', 'vn0hJFTNFo', 'Kato Kazuma', 'kazumakato@outlook.com', '(1223) 11 3896', 'locked', '2009-07-26 07:20:20', '2000-06-18 19:48:35', '2007-12-22 10:31:37');
INSERT INTO `users` VALUES ('27', 'Tina Lee', '75c4bsQzQk', 'Tina Lee', 'leetina@yahoo.com', '330-713-0395', 'disabled', '2020-03-23 01:50:00', '2022-04-15 03:17:19', '2024-01-27 07:05:23');
INSERT INTO `users` VALUES ('28', 'Liao Cho Yee', 'mrzEc0vbGc', 'Liao Cho Yee', 'choyeeliao@gmail.com', '212-170-4354', 'active', '2010-08-25 06:20:16', '2018-04-05 00:21:39', '2023-07-03 06:28:36');
INSERT INTO `users` VALUES ('29', 'Sakamoto Riku', 'WVFTS2I5xm', 'Sakamoto Riku', 'sakamotoriku85@outlook.com', '614-535-6905', 'locked', '2022-05-21 21:46:42', '2003-05-01 17:54:01', '2015-07-17 14:21:44');
INSERT INTO `users` VALUES ('3', 'Jiang Xiaoming', '73N3IsKI58', 'Jiang Xiaoming', 'jiangx@outlook.com', '7098 950796', 'active', '2020-08-31 02:10:16', '2013-11-17 03:46:10', '2024-10-29 10:31:28');
INSERT INTO `users` VALUES ('30', 'Tin Wing Suen', 'oo7Ai24uw5', 'Tin Wing Suen', 'tinws@hotmail.com', '52-468-8402', 'active', '2020-06-16 19:11:31', '2022-09-15 11:48:47', '2011-01-22 01:21:47');
INSERT INTO `users` VALUES ('4', 'Li Zhennan', 'zmU9YvdLqg', 'Li Zhennan', 'liz905@gmail.com', '769-6991-1569', 'active', '2002-02-08 03:45:16', '2018-04-02 12:36:28', '2010-10-05 03:08:59');
INSERT INTO `users` VALUES ('5', 'He Zhennan', 'ZIue9vswJC', 'He Zhennan', 'zhennh1963@icloud.com', '3-6989-9104', 'locked', '2008-10-06 01:04:33', '2005-04-09 19:14:35', '2002-09-24 08:05:31');
INSERT INTO `users` VALUES ('550e8400-e29b-41d4-a716-446655440000', 'admin01', '$2a$10$EixZaYbB.rK4fl8x2q8fIOG9v3s6h0F6gFZ0vF5fF5fF5fF5fF5f', '张系统', 'admin01@lab.com', '13800138001', 'active', '2025-08-20 09:00:00', '2025-10-21 12:53:28', '2025-10-21 12:53:28');
INSERT INTO `users` VALUES ('550e8400-e29b-41d4-a716-446655440001', 'lab_mgr01', '$2a$10$EixZaYbB.rK4fl8x2q8fIOG9v3s6h0F6gFZ0vF5fF5fF5fF5fF5f', '李实验', 'lab_mgr01@lab.com', '13800138002', 'active', '2025-08-20 09:30:00', '2025-10-21 12:53:28', '2025-10-21 12:53:28');
INSERT INTO `users` VALUES ('550e8400-e29b-41d4-a716-446655440002', 'ware_mgr01', '$2a$10$EixZaYbB.rK4fl8x2q8fIOG9v3s6h0F6gFZ0vF5fF5fF5fF5fF5f', '王仓库', 'ware_mgr01@lab.com', '13800138003', 'active', '2025-08-20 10:00:00', '2025-10-21 12:53:28', '2025-10-21 12:53:28');
INSERT INTO `users` VALUES ('550e8400-e29b-41d4-a716-446655440003', 'lab_user01', '$2a$10$EixZaYbB.rK4fl8x2q8fIOG9v3s6h0F6gFZ0vF5fF5fF5fF5fF5f', '赵实验', 'lab_user01@lab.com', '13800138004', 'active', '2025-08-20 10:30:00', '2025-10-21 12:53:28', '2025-10-21 12:53:28');
INSERT INTO `users` VALUES ('550e8400-e29b-41d4-a716-446655440004', 'approver01', '$2a$10$EixZaYbB.rK4fl8x2q8fIOG9v3s6h0F6gFZ0vF5fF5fF5fF5fF5f', '孙审批', 'approver01@lab.com', '13800138005', 'active', '2025-08-20 11:00:00', '2025-10-21 12:53:28', '2025-10-21 12:53:28');
INSERT INTO `users` VALUES ('550e8400-e29b-41d4-a716-446655440005', 'safety01', '$2a$10$EixZaYbB.rK4fl8x2q8fIOG9v3s6h0F6gFZ0vF5fF5fF5fF5fF5f', '周安全', 'safety01@lab.com', '13800138006', 'active', '2025-08-20 11:30:00', '2025-10-21 12:53:28', '2025-10-21 12:53:28');
INSERT INTO `users` VALUES ('6', 'Tsang Wai Lam', 'NytHYIcJ1r', 'Tsang Wai Lam', 'wailamts@mail.com', '66-227-2358', 'active', '2001-06-19 16:16:52', '2006-07-22 05:32:22', '2023-07-23 21:52:01');
INSERT INTO `users` VALUES ('7', 'Mori Akina', 'ZAHePIrcwb', 'Mori Akina', 'moria@outlook.com', '5748 576542', 'disabled', '2007-04-14 08:40:17', '2015-12-17 18:47:15', '2005-04-09 13:09:56');
INSERT INTO `users` VALUES ('8', 'Ye Jialun', 'iKrL6FpIHh', 'Ye Jialun', 'jialuye@yahoo.com', '(116) 672 0654', 'locked', '2024-01-08 21:20:44', '2004-02-09 07:55:21', '2007-10-28 13:54:45');
INSERT INTO `users` VALUES ('9', 'Sakamoto Seiko', '9JkWJh9j6M', 'Sakamoto Seiko', 'seikos@outlook.com', '(1865) 10 6691', 'disabled', '2002-09-02 13:44:23', '2014-07-26 18:06:04', '2006-12-13 11:29:12');

-- ----------------------------
-- Procedure structure for GenerateMaintenanceOrders
-- ----------------------------
DROP PROCEDURE IF EXISTS `GenerateMaintenanceOrders`;
delimiter ;;
CREATE PROCEDURE `GenerateMaintenanceOrders`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_equipment_id INT;
    DECLARE max_batch_id INT;
    DECLARE mo_types VARCHAR(20);
    DECLARE downtime_h DECIMAL(5,1);
    DECLARE mo_time DATETIME;
    DECLARE mo_status VARCHAR(20);

    -- 获取有效的设备和批次
    SELECT MAX(id) INTO max_equipment_id FROM items WHERE type = 'equipment';
    SELECT MAX(id) INTO max_batch_id 
    FROM stock_batches 
    WHERE item_id IN (SELECT id FROM items WHERE type = 'equipment');

    IF max_equipment_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No equipment found for maintenance.';
    END IF;

    WHILE i <= 200 DO
        -- 维护类型
        SET mo_types = ELT(FLOOR(RAND() * 3) + 1, 'preventive', 'corrective', 'calibration');

        -- 停机时长
        SET downtime_h = ROUND(CASE 
            WHEN mo_types = 'preventive' THEN RAND() * 6 + 2   -- 2~8h
            WHEN mo_types = 'corrective' THEN RAND() * 20 + 4  -- 4~24h
            ELSE RAND() * 3 + 1                               -- 1~4h
        END, 1);

        -- 维护时间
        SET mo_time = DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 730) DAY);

        -- 状态
        SET mo_status = ELT(FLOOR(RAND() * 4) + 1, 'completed', 'in_progress', 'approved', 'rejected');

        -- 构造唯一且合理的 MO 编号（例如 MO20240501123）
        SET @mo_no = CONCAT('MO', DATE_FORMAT(mo_time, '%Y%m%d'), LPAD(FLOOR(RAND() * 999), 3, '0'));

        -- 完成时间：仅 completed 状态有值
        SET @completed_at = IF(mo_status = 'completed', DATE_ADD(mo_time, INTERVAL FLOOR(RAND() * 24) HOUR), NULL);

        -- 插入维护订单
        INSERT INTO maintenance_orders (
            id, mo_no, item_id, batch_id, type,
            status, scheduled_date, completed_at,
            downtime_hours, cost, note
        ) VALUES (
            UUID(),                    -- 真实 UUID
            @mo_no,                   -- 唯一编号
            FLOOR(RAND() * max_equipment_id) + 1,
            IF(max_batch_id IS NOT NULL, FLOOR(RAND() * max_batch_id) + 1, NULL),
            mo_types,
            mo_status,
            mo_time,
            @completed_at,
            downtime_h,
            ROUND(RAND() * 1000 + 200, 2), -- 成本 200~1200
            CONCAT('自动生成：', mo_types, ' 维护任务')
        );

        SET i = i + 1;
    END WHILE;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GenerateReservations
-- ----------------------------
DROP PROCEDURE IF EXISTS `GenerateReservations`;
delimiter ;;
CREATE PROCEDURE `GenerateReservations`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_equipment_id INT;
    DECLARE max_requester_id INT;
    DECLARE start_t DATETIME;
    DECLARE end_t DATETIME;
    DECLARE res_status VARCHAR(20);
    DECLARE random_borrow_id INT;

    -- 只选择 type='equipment' 的 item
    SELECT MAX(id) INTO max_equipment_id FROM items WHERE type = 'equipment';
    SELECT MAX(id) INTO max_requester_id FROM users;

    IF max_equipment_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No equipment items found in items table.';
    END IF;

    WHILE i <= 300 DO
        -- 随机开始时间（工作日的白天）
        SET start_t = DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 730) DAY);
        SET start_t = TIMESTAMP(start_t, SEC_TO_TIME(FLOOR(RAND() * 8 + 9) * 3600)); -- 9~17点之间

        -- 随机持续时间：1~4小时
        SET end_t = DATE_ADD(start_t, INTERVAL FLOOR(RAND() * 4) + 1 HOUR);

        -- 使用简短状态名防止 VARCHAR 截断（建议不超过15字符）
        SET res_status = ELT(
            FLOOR(RAND() * 5) + 1,
            'approved',
            'checked_in',
            'completed',
            'overdue',
            'no_show'
        );

        -- 是否有关联借用单（70%概率有关联）
        SET random_borrow_id = IF(RAND() > 0.3, FLOOR(RAND() * 10) + 1, NULL);

        -- 插入预约记录
        INSERT INTO reservations (
            id, item_id, requester_id, start_time, end_time, status, borrow_id, note
        ) VALUES (
            UUID(),
            FLOOR(RAND() * max_equipment_id) + 1,
            FLOOR(RAND() * max_requester_id) + 1,
            start_t,
            end_t,
            res_status,
            random_borrow_id,
            CONCAT('设备预约 - ', res_status)
        );

        SET i = i + 1;
    END WHILE;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table consumable_specs
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_check_chemical_msds`;
delimiter ;;
CREATE TRIGGER `trg_check_chemical_msds` BEFORE INSERT ON `consumable_specs` FOR EACH ROW BEGIN
    DECLARE item_type ENUM('consumable', 'equipment', 'chemical');
    -- 获取对应物资类型
    SELECT type INTO item_type FROM items WHERE id = NEW.item_id;
    -- 化学品必须填写MSDS链接
    IF item_type = 'chemical' AND NEW.msds_url IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '化学品必须上传MSDS链接（consumable_specs.msds_url不能为空）';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table reservations
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_check_reserve_conflict`;
delimiter ;;
CREATE TRIGGER `trg_check_reserve_conflict` BEFORE INSERT ON `reservations` FOR EACH ROW BEGIN
    DECLARE conflict_count INT DEFAULT 0;
    -- 查询同设备、状态为有效（未取消/未失效）且时间重叠的预约
    SELECT COUNT(*) INTO conflict_count
    FROM reservations
    WHERE item_id = NEW.item_id
      AND status IN ('requested', 'approving', 'approved', 'checked_in', 'checked_out')
      -- 时间重叠条件：新预约开始时间 < 已有预约结束时间 且 新预约结束时间 > 已有预约开始时间
      AND NEW.start_time < end_time
      AND NEW.end_time > start_time;
    
    -- 存在冲突则报错
    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '设备预约时间与已有有效预约重叠，请调整时间段';
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
