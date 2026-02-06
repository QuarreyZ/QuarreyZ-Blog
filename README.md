# QuarreyZ-Blog
quarrey-z 的博客（纯前端静态站点）

## 文件系统目录规范

### 1. 总体规则
- `index.html` 位于仓库根目录。
- 博客内容为 `.md` 文件，可放在根目录或任意子目录。
- 每一级目录下可包含一个固定名称的素材目录 `__assets`，此目录 **不会** 被继续扫描。
- 每一级目录需要提供 `pack.json`，用于声明可进入的子目录（`dic`）与本级文章（`blog`）。

### 2. 建议目录结构
```
/
├─ index.html
├─ README.md
├─ about.md
├─ pack.json
├─ __assets/
│  ├─ about.png
│  └─ home.png
└─ posts/
   ├─ first.md
   ├─ second.md
   ├─ pack.json
   ├─ __assets/
   │  ├─ posts.png
   │  ├─ first.jpg
   │  └─ second.webp
   └─ notes/
      ├─ note-1.md
      ├─ pack.json
      └─ __assets/
         ├─ notes.png
         └─ note-1.png
```

### 3. pack.json 约定
每一级目录一个 `pack.json`，结构示例：
```json
{
  "dic": ["posts", "notes"],
  "blog": ["about.md", "hello"]
}
```
- `dic`：允许进入的子目录名（相对当前目录）。
- `blog`：本级 Markdown 文件名（可写 `hello.md` 或 `hello`）。
- `__assets` 无需出现在 `dic` 中，也不会被扫描。

### 4. 封面规则
- **文章封面**：在同级目录的 `__assets/` 中，若存在与 `.md` 同名的图片文件，即作为该文章封面。  
  例如：`posts/__assets/first.jpg` → `posts/first.md` 的封面
- **目录封面**：在同级目录的 `__assets/` 中，若存在与目录同名的图片文件，即作为该目录封面。  
  例如：`posts/__assets/posts.png` → `posts/` 的封面

支持的封面格式：`png`、`jpg`、`jpeg`、`webp`、`avif`、`gif`

### 5. 资源放置与引用
- 图片/视频可以在 Markdown 中用相对路径引用（相对于当前 `.md` 所在目录）。
- 建议把正文使用的素材也放到该级别的 `__assets/` 目录下，便于管理。

### 6. Cloudflare Pages 说明
- 页面通过浏览器 `fetch` 同源静态文件读取 Markdown。
- 不依赖目录列表，只依赖每级 `pack.json`。

## 如何创建新的文件夹

### 1. 创建目录与素材目录
例如新增 `posts/`：
```
posts/
├─ __assets/
```
- `__assets/` 用来放该级 Markdown 的图片/视频/封面。
- `__assets/` 不需要写进 `dic`，也不会被扫描。

### 2. 添加 pack.json
在 `posts/` 下创建 `pack.json`，声明本级文章与子目录：
```json
{
  "dic": ["notes"],
  "blog": ["first.md", "second"]
}
```
- `dic`：允许进入的子目录名（相对当前目录）。
- `blog`：本级 Markdown 文件名，可写 `xxx` 或 `xxx.md`。

### 3. 写入 Markdown
- 在 `posts/` 内创建 `first.md`、`second.md`。
- 对应素材放在 `posts/__assets/`。

## Markdown 语法说明（详尽）

### 1. 标题
```md
# 一级标题
## 二级标题
### 三级标题
```

### 2. 段落与换行
直接空行分段，单行文本会自动换行。

### 3. 列表
```md
- 项目 A
- 项目 B
```
```md
1. 项目一
2. 项目二
```

### 4. 加粗、斜体、删除线
```md
**加粗**
*斜体*
~~删除线~~
```

### 5. 链接
```md
[OpenAI](https://openai.com)
```

### 6. 代码块（高亮）
````md
```js
console.log("hello");
```
````

### 7. 图片（本级 __assets）
```md
![图片描述](./__assets/example.png)
```
说明：`图片描述` 会作为图片注解（caption）显示在图片下方。

### 8. 视频（本级 __assets）
推荐写 HTML 标签，支持 `mp4/webm/mov`：
```md
<video controls preload="metadata" src="./__assets/demo.mov"></video>
```
说明：可用 `title` 或 `data-caption` 作为视频注解：
```md
<video controls preload="metadata" src="./__assets/demo.mov" title="我的视频"></video>
```

### 9. 数学公式（KaTeX）
行内公式：
```md
$a+b=c$
```
块级公式：
```md
$$a+b=c$$
```

### 10. 视频站链接预览（YouTube / Bilibili）
直接粘贴链接即可自动嵌入播放：
```md
https://www.youtube.com/watch?v=dQw4w9WgXcQ
```
```md
https://www.bilibili.com/video/BV1xx411c7mD
```
说明：链接文字会作为嵌入视频的注解（caption）。示例：
```md
[我的视频](https://www.bilibili.com/video/BV1xx411c7mD)
```

### 11. 脚注
写法示例：
```md
这是一句话[^1]

[^1]: 这里是脚注内容。
```
