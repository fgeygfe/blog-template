///| 消息类型
enum Msg {
  ToHome
  ToPost1
  ToPost2
  Search(String) // 新增：搜索消息
  SelectTag(String) // 新增：标签选择消息
}

///| 状态类型
struct Model {
  page : Int // 0:首页, 1:详情1, 2:详情2
  search : String // 新增：搜索关键词
  tag : String // 新增：当前标签
}

struct Post {
  id: Int
  emoji: String
  title: String
  author: String
  date: String
  summary: String
  tag: String
  click: Msg
}

///| 更新函数
fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
  match msg {
    ToHome => (none(), { page: 0, search: "", tag: "" })
    ToPost1 => (none(), { page: 1, search: model.search, tag: model.tag })
    ToPost2 => (none(), { page: 2, search: model.search, tag: model.tag })
    Search(keyword) => (none(), { page: 0, search: keyword, tag: model.tag })
    SelectTag(tag) => (none(), { page: 0, search: model.search, tag: tag })
  }
}

///| 首页视图
fn view_home(model: Model) -> Html[Msg] {
  let posts = [
    {
      id: 1,
      emoji: "👩‍💻", 
      title: "MoonBit 博客系统开发初探",
      author: "Zhuanz2",
      date: "2025-08-20",
      summary: "这是第一篇博客内容，支持 Markdown 格式。",
      tag: "MoonBit",
      click: ToPost1
    },
    {
      id: 2,
      emoji: "🦄",
      title: "Rabbit-tea 框架介绍", 
      author: "Yoorkin",
      date: "2025-08-21",
      summary: "Rabbit-tea 是 MoonBit 的前端框架，适合多页应用开发。",
      tag: "前端",
      click: ToPost2
    }
  ]
  
  let tags = ["全部", "MoonBit", "前端"]
  
  let filtered_posts = posts.filter(fn(post) {
    (model.tag == "" || model.tag == "全部" || post.tag == model.tag) &&
    (model.search == "" || post.title.contains(model.search) || post.summary.contains(model.search))
  })

  div(
    class="min-h-screen bg-gradient-to-br from-pink-200 via-pink-100 to-white flex flex-col items-center justify-between",
    [
      div(
        class="w-full py-6 bg-gradient-to-r from-pink-400 to-pink-200 shadow-lg",
        [
          h1(
            class="text-5xl font-extrabold text-white text-center drop-shadow mb-2",
            [text("🌸 MoonBit 博客")]
          ),
          p(
            class="text-lg text-pink-50 text-center", 
            [text("欢迎来到更美观的博客首页！")]
          )
        ]
      ),
      
      // 搜索框
      div(class="w-full max-w-2xl px-4 mt-6 flex gap-2", [
        button(
          class="px-4 py-2 bg-blue-100 text-blue-700 rounded-lg hover:bg-blue-200",
          click=Search("MoonBit"),
          [text("搜索: MoonBit")]
        ),
        button(
          class="px-4 py-2 bg-blue-100 text-blue-700 rounded-lg hover:bg-blue-200",
          click=Search("前端"),
          [text("搜索: 前端")]
        ),
        button(
          class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200",
          click=Search(""),
          [text("清除搜索")]
        )
      ]),
      
      // 标签栏
      div(
        class="w-full max-w-2xl px-4 mt-2 flex gap-2",
        tags.map(fn(tag) {
          let btn_class = if model.tag == tag {
            "bg-pink-500 text-white px-3 py-1 rounded-full"
          } else {
            "bg-pink-100 text-pink-700 px-3 py-1 rounded-full"
          }
          button(
            class=btn_class,
            click=SelectTag(tag),
            [text(tag)]
          )
        })
      ),
      
      // 博客列表
      div(
        class="w-full max-w-2xl px-4 py-8 space-y-8",
        if filtered_posts.length() == 0 {
          [div(class="text-center text-pink-400 py-8", [text("没有找到相关博客")])]
        } else {
          filtered_posts.map(fn(post) {
            div(
              class="bg-white rounded-2xl shadow-xl p-8 flex items-center gap-6 hover:scale-105 transition-all duration-300 border-b-2 border-pink-100",
              [
                div(class="text-4xl", [text(post.emoji)]),
                div(class="flex-1", [
                  h1(class="text-2xl font-bold mb-2 text-pink-700", [text(post.title)]),
                  p(class="text-xs text-gray-400 mb-2", [text("作者：" + post.author + " · " + post.date)]),
                  p(class="text-base text-gray-600 mb-4 line-clamp-2", [text(post.summary)]),
                  div(class="mb-2", [
                    div(class="bg-pink-100 text-pink-700 px-2 py-1 rounded-full text-xs", [text(post.tag)])
                  ]),
                  button(
                    class="inline-flex items-center gap-2 px-4 py-2 bg-pink-500 text-white rounded-full shadow hover:bg-pink-600 active:scale-95 transition",
                    click=post.click,
                    [text("阅读详情"), text("→")]
                  )
                ])
              ]
            )
          })
        }
      ),
      
      // 底部版权
      div(
        class="w-full py-4 text-center text-xs text-pink-600 bg-pink-50 border-t border-pink-200 mt-8",
        [text("© 2025 MoonBit 博客 Demo · Powered by rabbit-tea & Tailwind CSS")]
      )
    ]
  )
}

///| 详情页1视图
fn view_post1() -> Html[Msg] {
  div(class="min-h-screen bg-gradient-to-br from-pink-200 via-pink-100 to-white flex flex-col items-center", [
    div(class="w-full max-w-2xl bg-white rounded-2xl shadow-xl p-10 mt-10", [
      div(class="flex items-center gap-4 mb-6", [
        div(class="text-3xl", [text("👩‍💻")]),
        h1(class="text-3xl font-bold text-pink-700", [text("MoonBit 博客系统开发初探")])
      ]),
      p(class="text-xs text-gray-400 mb-2", [text("作者：Zhuanz2 · 2025-08-20")]),
      div(class="border-b border-pink-100 mb-6", [text("")]),
      div(class="prose prose-pink max-w-none text-gray-700 mb-8", [text("这里是博客正文内容。")]),
      button(class="inline-flex items-center gap-2 px-4 py-2 bg-pink-500 text-white rounded-full shadow hover:bg-pink-600 active:scale-95 transition", click=ToHome, [text("返回首页"), text("🏠")])
    ]),
    div(class="w-full py-4 text-center text-xs text-pink-600 bg-pink-50 border-t border-pink-200 mt-8", [
      text("© 2025 MoonBit 博客 Demo · Powered by rabbit-tea & Tailwind CSS")
    ])
  ])
}

///| 详情页2视图
fn view_post2() -> Html[Msg] {
  div(class="min-h-screen bg-gradient-to-br from-pink-200 via-pink-100 to-white flex flex-col items-center", [
    div(class="w-full max-w-2xl bg-white rounded-2xl shadow-xl p-10 mt-10", [
      div(class="flex items-center gap-4 mb-6", [
        div(class="text-3xl", [text("🦄")]),
        h1(class="text-3xl font-bold text-pink-700", [text("Rabbit-tea 框架介绍")])
      ]),
      p(class="text-xs text-gray-400 mb-2", [text("作者：Yoorkin · 2025-08-21")]),
      div(class="border-b border-pink-100 mb-6", [text("")]),
      div(class="prose prose-pink max-w-none text-gray-700 mb-8", [text("这里是 Rabbit-tea 介绍正文内容。")]),
      button(class="inline-flex items-center gap-2 px-4 py-2 bg-pink-500 text-white rounded-full shadow hover:bg-pink-600 active:scale-95 transition", click=ToHome, [text("返回首页"), text("🏠")])
    ]),
    div(class="w-full py-4 text-center text-xs text-pink-600 bg-pink-50 border-t border-pink-200 mt-8", [
      text("© 2025 MoonBit 博客 Demo · Powered by rabbit-tea & Tailwind CSS")
    ])
  ])
}

///| 总视图
fn view(model : Model) -> Html[Msg] {
  match model.page {
    0 => view_home(model)
    1 => view_post1()
    2 => view_post2()
    _ => div(class="", [text("页面不存在")])
  }
}

fn main {
  let model = { page: 0, search: "", tag: "" }
  @tea.startup(model=model, update=update, view=view)
}