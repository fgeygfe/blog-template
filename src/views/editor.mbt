using @html {div, h1, p, button, text, input}
using @cmark_html { render }
using @dom {document}
///|
/// Markdown 编辑器视图（简版）：左侧输入，右侧预览
pub fn view_editor(model : @types.Model) -> Html[@types.Msg] {
  let theme_bg = if model.dark_theme { "bg-gray-900" } else { "bg-gradient-to-br from-pink-100 to-white" }
  let card_bg = if model.dark_theme { "bg-gray-800" } else { "bg-white" }
  let text_color = if model.dark_theme { "text-white" } else { "text-gray-800" }
  let rendered = (try? render(safe=false, strict=true, model.markdown_content))
    .unwrap_or("")

// 简化预览：先以纯文本展示渲染结果（后续可替换为 external 节点挂载 HTML）

  div(class="min-h-screen " + theme_bg, [
    @component.navbar(model),
    div(class="pt-24 pb-16 px-4", [
      div(class="max-w-6xl mx-auto " + card_bg + " rounded-xl shadow-xl p-6", [
        h1(class="text-2xl font-bold mb-4 " + text_color, [text("📝 Markdown 编辑器")]),
        div(class="flex flex-col md:flex-row gap-6", [
          // 输入区
          div(class="md:w-1/2 w-full", [
            p(class="mb-2 " + text_color, [text("输入内容：")]),
          // 这里用 input 代替 textarea（rabbit-tea 目前未提供 textarea），可多次换行粘贴
          @html.input(class="w-full p-3 border rounded-lg min-h-[200px]", value=model.markdown_content, input=@types.Msg::UpdateMarkdown, children=[]),
            div(class="mt-4 flex gap-3", [
              button(
                class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600",
                click=@types.Msg::TogglePreview,
                [text(if model.preview_mode { "隐藏预览" } else { "显示预览" })],
              ),
              button(
                class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600",
                click=@types.Msg::SavePost,
                [text("保存")],
              ),
              button(
                class="px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600",
                click=@types.Msg::CancelEdit,
                [text("取消")],
              ),
            ]),
          ]),
          // 预览区
          div(class="md:w-1/2 w-full", [
            p(class="mb-2 " + text_color, [text("预览：")]),
            if model.preview_mode {
              div(class="p-4 border rounded-lg overflow-auto", [text(rendered)])
            } else {
              div(class="p-4 border rounded-lg text-gray-500", [text("点击“显示预览”查看渲染结果")])
            }
          ]),
        ]),
      ]),
    ]),
  ])
}


