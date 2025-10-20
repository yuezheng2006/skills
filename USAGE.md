# Skills Marketplace 使用指南

这个仓库是 Vincent Yang 维护的 Claude Skills Marketplace，包含官方示例和自定义扩展。

## 📦 包含的 Plugins

### 1. **custom-skills** (自定义技能) ⭐
我的自定义技能集合：
- **code-extractor** - 基于 repomix 的源码提取工具

### 2. **example-skills** (官方示例)
Anthropic 官方示例技能（从 anthropics/skills fork）：
- skill-creator, mcp-builder, canvas-design, algorithmic-art
- internal-comms, webapp-testing, artifacts-builder
- slack-gif-creator, theme-factory, brand-guidelines

### 3. **document-skills** (官方文档处理)
Anthropic 官方文档处理技能（从 anthropics/skills fork）：
- xlsx, docx, pptx, pdf

---

## 🚀 快速开始

### 在 Claude Code 中安装

#### 仅安装自定义技能（推荐）

```bash
# 添加 marketplace
/plugin marketplace add yuezheng2006/skills

# 安装自定义技能
/plugin install custom-skills@yuezheng2006/skills
```

#### 安装所有技能

```bash
# 添加 marketplace
/plugin marketplace add yuezheng2006/skills

# 安装各个 plugin
/plugin install custom-skills@yuezheng2006/skills
/plugin install example-skills@yuezheng2006/skills
/plugin install document-skills@yuezheng2006/skills
```

---

## 💡 使用建议

### 推荐方式：双 Marketplace 策略

```bash
# 1. 添加官方 marketplace（获取官方最新更新）
/plugin marketplace add anthropics/skills

# 2. 添加我的 marketplace（获取自定义 skills）
/plugin marketplace add yuezheng2006/skills

# 3. 选择性安装
/plugin install example-skills@anthropics/skills      # 官方示例
/plugin install custom-skills@yuezheng2006/skills     # 我的自定义
```

**优点：**
- 官方 skills 保持最新
- 自定义 skills 独立维护
- 避免版本冲突

---

## 🔧 自定义技能详解

### code-extractor

基于 repomix CLI 的源码提取工具。

**功能：**
- 全量代码提取（自动排除 node_modules）
- 前 N + 后 N 行提取（默认 3000+3000）
- 模式过滤提取（支持 glob 模式）
- 多格式输出（XML/Markdown/Plain）

**使用示例：**
```bash
# 安装后，在 Claude Code 中直接提及即可
"使用 code-extractor 提取这个项目的所有 TypeScript 代码"

"用 code-extractor 获取前 2000 行和后 2000 行代码，输出 markdown"
```

**手动运行脚本：**
```bash
# 全量提取
bash code-extractor/scripts/extract-full.sh . markdown

# 头尾提取
bash code-extractor/scripts/extract-head-tail.sh . 3000 3000 markdown

# 模式过滤
bash code-extractor/scripts/extract-filtered.sh . "*.ts,*.tsx" markdown
```

详细文档：[code-extractor/SKILL.md](./code-extractor/SKILL.md)

---

## 📚 官方 Skills 说明

### example-skills 示例技能

详见官方文档：https://github.com/anthropics/skills

**包含：**
- **skill-creator** - 创建新技能的指南
- **mcp-builder** - 构建 MCP 服务器
- **artifacts-builder** - 构建 React artifacts
- **canvas-design** - 视觉设计
- **algorithmic-art** - 生成艺术
- 等...

### document-skills 文档处理

详见官方文档：https://github.com/anthropics/skills/tree/main/document-skills

**包含：**
- **xlsx** - Excel 表格处理
- **docx** - Word 文档处理
- **pptx** - PowerPoint 演示文稿处理
- **pdf** - PDF 文档处理

---

## 🔄 更新与维护

### 自定义 Skills
由 Vincent Yang 维护，直接在此仓库更新。

### 官方 Skills
Fork 自 anthropics/skills，可能不会频繁同步。

**建议：** 如需官方 skills 的最新版本，请直接使用官方 marketplace：
```bash
/plugin marketplace add anthropics/skills
```

---

## 📝 贡献

欢迎提交 PR 添加新的自定义 skills！

### 添加新 Skill 的步骤

1. 创建 skill 目录和 SKILL.md
2. 更新 `.claude-plugin/marketplace.json`
3. 提交 PR

---

## 📄 许可证

- **自定义 skills (custom-skills/)**: Apache 2.0
- **官方 skills (example-skills/, document-skills/)**: 见各 skill 的 LICENSE

---

## 🔗 相关链接

- 官方 Skills 仓库: https://github.com/anthropics/skills
- Claude Skills 文档: https://docs.claude.com/en/docs/skills
- repomix 官网: https://repomix.com
