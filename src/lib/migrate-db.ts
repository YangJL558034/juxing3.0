/**
 * 数据库字段迁移脚本
 * 运行此脚本确保数据库包含所有必要的字段
 */

import { initDatabase } from './database';

async function migrate() {
  console.log('开始数据库迁移...');
  
  try {
    // 初始化数据库（包含表创建和字段迁移）
    initDatabase();
    
    console.log('数据库迁移完成！');
    console.log('所有必要的字段已添加或确认存在。');
  } catch (error) {
    console.error('迁移失败:', error);
    throw error;
  }
}

// 运行迁移
migrate().catch(console.error);
