///| 消息类型
enum Msg {
  ToHome
  ToPost1
  ToPost2
}

///| 状态类型
struct Model {
  page : Int // 0:首页, 1:详情1, 2:详情2
}

///| 更新函数
fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
  match msg {
    ToHome => (none(), { page: 0 })
    ToPost1 => (none(), { page: 1 })
    ToPost2 => (none(), { page: 2 })
  }
}

///| 首页视图
fn view_home() -> Html[Msg] {
  div(
    class="min-h-screen bg-gradient-to-br from-pink-200 via-pink-100 to-white flex flex-col items-center justify-between",
    [
      // 顶部导航
      div(
        class="w-full py-6 bg-gradient-to-r from-pink-400 to-pink-200 shadow-lg",
        [
          h1(
            class="text-5xl font-extrabold text-white text-center drop-shadow mb-2",
            [text("🌸 MoonBit 博客")],
          ),
          p(class="text-lg text-pink-50 text-center", [
            text("欢迎来到更美观的博客首页！"),
          ]),
        ],
      ),
      // 博客列表
      div(class="w-full max-w-2xl px-4 py-8 space-y-8", [
        div(
          class="bg-white rounded-2xl shadow-xl p-8 flex items-center gap-6 hover:scale-105 transition-all duration-300 border-b-2 border-pink-100",
          [
            div(class="text-4xl", [text("👩‍💻")]),
            div(class="flex-1", [
              h1(class="text-2xl font-bold mb-2 text-pink-700", [
                text("MoonBit 博客系统开发初探"),
              ]),
              p(class="text-xs text-gray-400 mb-2", [
                text("作者：Zhuanz2 · 2025-08-20"),
              ]),
              p(class="text-base text-gray-600 mb-4 line-clamp-2", [
                text("这是第一篇博客内容，支持 Markdown 格式。"),
              ]),
              button(
                click=ToPost1,
                class="inline-flex items-center gap-2 px-4 py-2 bg-pink-500 text-white rounded-full shadow hover:bg-pink-600 active:scale-95 transition",
                [text("阅读详情"), text("→")],
              ),
            ]),
          ],
        ),
        div(
          class="bg-white rounded-2xl shadow-xl p-8 flex items-center gap-6 hover:scale-105 transition-all duration-300 border-b-2 border-pink-100",
          [
            div(class="text-4xl", [text("🦄")]),
            div(class="flex-1", [
              h1(class="text-2xl font-bold mb-2 text-pink-700", [
                text("Rabbit-tea 框架介绍"),
              ]),
              p(class="text-xs text-gray-400 mb-2", [
                text("作者：Yoorkin · 2025-08-21"),
              ]),
              p(class="text-base text-gray-600 mb-4 line-clamp-2", [
                text(
                  "Rabbit-tea 是 MoonBit 的前端框架，适合多页应用开发。",
                ),
              ]),
              button(
                click=ToPost2,
                class="inline-flex items-center gap-2 px-4 py-2 bg-pink-500 text-white rounded-full shadow hover:bg-pink-600 active:scale-95 transition",
                [text("阅读详情"), text("→")],
              ),
            ]),
          ],
        ),
      ]),
      // 底部版权
      div(
        class="w-full py-4 text-center text-xs text-pink-600 bg-pink-50 border-t border-pink-200 mt-8",
        [
          text(
            "© 2025 MoonBit 博客 Demo · Powered by rabbit-tea & Tailwind CSS",
          ),
        ],
      ),
    ],
  )
}

///| 详情页1视图
fn view_post1() -> Html[Msg] {
  div(class="min-h-screen bg-gradient-to-br from-pink-200 via-pink-100 to-white flex flex-col items-center", [
    div(class="w-full max-w-2xl bg-white rounded-2xl shadow-xl p-10 mt-10", [
      div(class="flex items-center gap-4 mb-6", [
        div(class="text-3xl", [text("👩‍💻")]),
        h1(class="text-3xl font-bold text-pink-700", [text("MoonBit 博客系统开发初探")]),
      ]),
      p(class="text-xs text-gray-400 mb-2", [text("作者：Zhuanz2 · 2025-08-20")]),
      div(class="border-b border-pink-100 mb-6", [text("")]),
      div(class="prose prose-pink max-w-none text-gray-700 mb-8", [text("这里是博客正文内容。")]),
      button(click=ToHome, class="inline-flex items-center gap-2 px-4 py-2 bg-pink-500 text-white rounded-full shadow hover:bg-pink-600 active:scale-95 transition", [text("返回首页"), text("🏠")]),
    ]),
    div(class="w-full py-4 text-center text-xs text-pink-600 bg-pink-50 border-t border-pink-200 mt-8", [
      text("© 2025 MoonBit 博客 Demo · Powered by rabbit-tea & Tailwind CSS")
    ]),
  ])
}

///| 详情页2视图
fn view_post2() -> Html[Msg] {
  div(class="min-h-screen bg-gradient-to-br from-pink-200 via-pink-100 to-white flex flex-col items-center", [
    div(class="w-full max-w-2xl bg-white rounded-2xl shadow-xl p-10 mt-10", [
      div(class="flex items-center gap-4 mb-6", [
        div(class="text-3xl", [text("🦄")]),
        h1(class="text-3xl font-bold text-pink-700", [text("Rabbit-tea 框架介绍")]),
      ]),
      p(class="text-xs text-gray-400 mb-2", [text("作者：Yoorkin · 2025-08-21")]),
      div(class="border-b border-pink-100 mb-6", [text("")]),
      div(class="prose prose-pink max-w-none text-gray-700 mb-8", [text("这里是 Rabbit-tea 介绍正文内容。")]),
      button(click=ToHome, class="inline-flex items-center gap-2 px-4 py-2 bg-pink-500 text-white rounded-full shadow hover:bg-pink-600 active:scale-95 transition", [text("返回首页"), text("🏠")]),
    ]),
    div(class="w-full py-4 text-center text-xs text-pink-600 bg-pink-50 border-t border-pink-200 mt-8", [
      text("© 2025 MoonBit 博客 Demo · Powered by rabbit-tea & Tailwind CSS")
    ]),
  ])
}

///| 总视图
fn view(model : Model) -> Html[Msg] {
  match model.page {
    0 => view_home()
    1 => view_post1()
    2 => view_post2()
    _ => div([text("页面不存在")])
  }
}


// 直接用 view，无需 safe_view

fn main {
  let model = { page: 0 }
  @tea.startup(model=model, update=update, view=view)
}


