@echo off
REM========================================
REM CRM 系统 Windows 部署脚本
REM Author: 小羊羔
REM Date: 2026-05-23
REM========================================

echo ========================================
echo      CRM 系统自动化部署脚本
echo ========================================

REM 项目目录
set PROJECT_DIR=C:\inetpub\wwwroot\juxing3.0

REM 进入项目目录
cd /d %PROJECT_DIR%
if errorlevel 1 (
    echo 项目目录不存在，请检查路径！
    pause
    exit /b 1
)

REM 拉取最新代码
echo [1/6] 拉取最新代码...
git pull origin main
if errorlevel 1 (
    echo Git 拉取失败！
    pause
    exit /b 1
)

REM 安装依赖
echo [2/6] 安装依赖...
call pnpm install
if errorlevel 1 (
    echo 依赖安装失败！
    pause
    exit /b 1
)

REM 构建项目
echo [3/6] 构建项目...
call pnpm run build
if errorlevel 1 (
    echo 项目构建失败！
    pause
    exit /b 1
)

REM 创建数据目录
echo [4/6] 创建数据目录...
if not exist "data" mkdir data
if not exist "uploads" mkdir uploads

REM 重启 IIS
echo [5/6] 重启 IIS...
iisreset /restart
if errorlevel 1 (
    echo IIS 重启失败，请手动重启！
)

REM 完成
echo [6/6] 部署完成！
echo ========================================
echo      部署完成！
echo ========================================
echo 访问地址: http://your-domain.com
pause
