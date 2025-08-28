# 博客系统模板

基于 MoonBit、Rabbit-TEA 和 Tailwind CSS 的博客系统模板。

## 功能简介
- 博客首页：展示所有文章列表
- 文章详情页：点击文章标题可查看内容
- 响应式设计，支持移动端

## 快速开始

克隆本仓库并在项目目录下运行：

```
moon update
moon add Yoorkin/rabbit-tea
npm i
npm run dev
```
或使用 bun：
```
moon update
moon add Yoorkin/rabbit-tea
bun i
bun run dev
```

## 目录结构
- src/index.html         # 入口 HTML
- src/styles.css         # Tailwind CSS 样式
- src/main/              # MoonBit 主代码
    - main.mbt           # 博客主逻辑
    - aliases.mbt        # 函数/类型别名
    - moon.pkg.json      # MoonBit 包配置
- target/js/release/     # 构建输出

## 发布构建
```
npm run build
```
或使用 bun：
```
bun run build
```

发布内容会生成在 `src/dist` 目录。

---

本模板仅为前端演示，文章数据为静态模拟，可扩展为后端或文件读取。
