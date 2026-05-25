#!/bin/bash

#========================================
# CRM 系统服务器部署脚本
# Author: 小羊羔
# Date: 2026-05-23
#========================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 项目目录
PROJECT_DIR="/var/www/juxing3.0"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}     CRM 系统自动化部署脚本${NC}"
echo -e "${GREEN}========================================${NC}"

# 进入项目目录
cd $PROJECT_DIR || exit

# 拉取最新代码
echo -e "${YELLOW}[1/6] 拉取最新代码...${NC}"
git pull origin main

# 安装依赖
echo -e "${YELLOW}[2/6] 安装依赖...${NC}"
pnpm install

# 构建项目
echo -e "${YELLOW}[3/6] 构建项目...${NC}"
pnpm run build

# 创建数据目录
echo -e "${YELLOW}[4/6] 创建数据目录...${NC}"
mkdir -p data uploads

# 设置权限
echo -e "${YELLOW}[5/6] 设置权限...${NC}"
chmod -R 755 data uploads

# 重启服务
echo -e "${YELLOW}[6/6] 重启服务...${NC}"
pm2 restart crm-system || pm2 start "pnpm run start" --name crm-system

# 保存 PM2 配置
pm2 save

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}     部署完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "${YELLOW}访问地址: http://your-domain.com${NC}"
echo -e "${YELLOW}日志查看: pm2 logs crm-system${NC}"
