# GitHub Actions iOS 构建指南

本文档详细介绍如何使用 GitHub Actions 自动构建 iOS 应用。

---

## 📋 前提条件

1. **GitHub 账号** - 免费注册：https://github.com
2. **Flutter 项目** - 已创建并可在本地运行
3. **Git 安装** - 用于版本控制

---

## 🚀 快速开始

### 步骤 1：将项目上传到 GitHub

#### 方法一：使用命令行

```bash
# 1. 进入项目目录
cd d:\douyinkaifangpingtai\code\mobilecode\my_tool_app

# 2. 初始化 Git 仓库（如果还没有）
git init

# 3. 添加所有文件
git add .

# 4. 提交
git commit -m "Initial commit"

# 5. 在 GitHub 创建新仓库
# 访问 https://github.com/new 创建仓库
# 仓库名称建议：my_tool_app

# 6. 关联远程仓库（替换为你的仓库地址）
git remote add origin https://github.com/huangqiyueyue/my_tool_app.git

# 7. 推送到 GitHub
git branch -M main
git push -u origin main
```

#### 方法二：使用 GitHub Desktop

1. 下载 GitHub Desktop：https://desktop.github.com
2. File → Add Local Repository
3. 选择项目目录
4. Publish repository 到 GitHub

---

### 步骤 2：查看 Actions

1. 打开你的 GitHub 仓库页面
2. 点击 **Actions** 标签页
3. 你会看到自动检测到的 workflow
4. 点击 "I understand my workflows, go ahead and run them"

---

### 步骤 3：手动触发构建

1. 点击左侧 "Build iOS IPA" workflow
2. 点击 "Run workflow" 按钮
3. 选择分支（main 或 master）
4. 点击 "Run workflow"
5. 等待构建完成（通常 10-20 分钟）

---

## 📱 安装 IPA 到手机

### 构建产物位置

构建完成后：
1. 进入 **Actions** 页面
2. 点击构建任务
3. 向下滚动到 "Artifacts" 部分
4. 下载以下文件：
   - `ios-build.zip` - 包含 Runner.app 或 Runner.ipa

### 安装到 iPhone/iPad（需要 Mac）

#### 方法一：使用 Xcode（推荐）

1. 将 IPA 文件传输到 Mac
2. 双击 IPA 文件打开 Xcode
3. 连接 iOS 设备
4. 选择你的设备
5. 点击 Run

#### 方法二：使用命令行

```bash
# 在 Mac 上安装 IPA
xcrun simctl install booted Runner.ipa

# 或使用第三方工具如 ios-deploy
ios-deploy -b Runner.ipa
```

---

## 🔧 自定义配置

### 修改 Flutter 版本

编辑 `.github/workflows/flutter_build.yml`：

```yaml
- name: Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.24.0'  # 修改为你需要的版本
```

查看可用的 Flutter 版本：https://docs.flutter.dev/release/archive

### 修改 macOS 虚拟机版本

```yaml
jobs:
  build_ios:
    runs-on: macos-14  # 可选: macos-13, macos-14
```

可用版本：
- `macos-13` - Xcode 14.x
- `macos-14` - Xcode 15.x（推荐）

---

## ⚠️ 注意事项

### iOS 代码签名

上述配置使用了 `--no-codesign` 参数，适用于：
- ✅ 模拟器测试
- ✅ 内部测试（Ad Hoc）
- ❌ App Store 发布（需要有效的签名证书）

### App Store 发布

要发布到 App Store，你需要：

1. **Apple Developer 账号** - $99/年
2. **签名证书和配置文件**
3. **修改 workflow 添加签名步骤**

如需发布到 App Store，请告诉我，我可以帮你配置。

---

## 📊 监控构建状态

### 查看构建日志

1. 进入仓库 **Actions** 页面
2. 点击构建任务名称
3. 点击左侧的 jobs
4. 查看每个步骤的详细日志

### 接收邮件通知

1. 进入仓库 **Settings** → **Notifications**
2. 启用 **GitHub Actions** 通知
3. 选择通知方式（邮件/Slack）

---

## 🔍 常见问题

### Q: 构建失败怎么办？

**A:** 检查错误日志：
1. 点击失败的 workflow
2. 查看具体失败的步骤
3. 常见问题：
   - Flutter 版本不兼容
   - iOS 依赖安装失败
   - 代码签名问题

### Q: 构建时间太长？

**A:** 优化策略：
1. 启用 Flutter 缓存
2. 使用更高配置的 macOS
3. 分离 iOS 和 Android 构建

### Q: 免费额度用完了怎么办？

**A:**
- 等待下个月重置（每月 2000 分钟）
- 优化构建流程减少时间
- 申请 GitHub Education（学生免费）

---

## 📞 获取帮助

如果遇到问题：

1. 查看 GitHub Actions 文档：https://docs.github.com/actions
2. 查看 Flutter 文档：https://docs.flutter.dev
3. 在仓库中创建 Issue 提问

---

## ✅ 下一步

构建成功后，你可以：

1. **测试应用** - 在模拟器或真机上测试
2. **添加更多功能** - 继续开发新功能
3. **配置持续部署** - 自动发布到 TestFlight

需要我帮你配置 App Store 发布流程吗？
