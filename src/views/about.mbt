///|
/// 关于页面
pub fn view_about(model : @types.Model) -> Html[@types.Msg] {
  let bg_class = if model.dark_theme {
    "bg-gray-900"
  } else {
    "bg-gradient-to-br from-pink-100 to-white"
  }
  let card_bg = if model.dark_theme { "bg-gray-800" } else { "bg-white" }
  let text_color = if model.dark_theme { "text-white" } else { "text-gray-800" }
  div(class="min-h-screen " + bg_class, [
    @component.navbar(model),
    div(class="pt-24 pb-16 px-4", [
      div(class="max-w-4xl mx-auto " + card_bg + " rounded-xl shadow-xl p-8", [
        div(class="text-center mb-8", [
          div(class="text-6xl mb-4", [text("🌸")]),
          h1(class="text-4xl font-bold " + text_color + " mb-4", [
            text("关于 MoonBit 博客"),
          ]),
          p(class="text-xl text-gray-600", [
            text("探索现代编程语言的魅力"),
          ]),
        ]),
        div(class="prose prose-lg max-w-none " + text_color, [
          h2(class="text-2xl font-bold mb-4", [text("项目介绍")]),
          p(class="mb-6 leading-relaxed", [
            text(
              "这是一个使用 MoonBit 语言和 rabbit-tea 框架构建的现代化博客系统。",
            ),
            text(
              "项目展示了函数式编程在前端开发中的应用，以及 WebAssembly 技术的强大潜力。",
            ),
          ]),
          h2(class="text-2xl font-bold mb-4", [text("技术栈")]),
          div(class="grid md:grid-cols-2 gap-4 mb-6", [
            div(class="p-4 bg-pink-50 rounded-lg", [
              @html.h3(class="font-bold text-pink-700", [text("🚀 MoonBit")]),
              p(class="text-sm text-gray-600", [
                text(
                  "现代化的编程语言，专为云计算和边缘计算设计",
                ),
              ]),
            ]),
            div(class="p-4 bg-blue-50 rounded-lg", [
              @html.h3(class="font-bold text-blue-700", [text("🦄 Rabbit-tea")]),
              p(class="text-sm text-gray-600", [
                text("基于 TEA 架构的前端框架"),
              ]),
            ]),
            div(class="p-4 bg-green-50 rounded-lg", [
              @html.h3(class="font-bold text-green-700", [text("🎨 Tailwind CSS")]),
              p(class="text-sm text-gray-600", [
                text("实用优先的 CSS 框架"),
              ]),
            ]),
            div(class="p-4 bg-purple-50 rounded-lg", [
              @html.h3(class="font-bold text-purple-700", [text("🌐 WebAssembly")]),
              p(class="text-sm text-gray-600", [
                text("高性能的 Web 运行时技术"),
              ]),
            ]),
          ]),
        ]),
        div(class="text-center", [
          button(
            class="px-6 py-3 bg-pink-500 text-white rounded-lg hover:bg-pink-600 transition",
            click=@types.Msg::ToHome,
            [text("🏠 返回首页")],
          ),
        ]),
      ]),
    ]),
  ])
}
