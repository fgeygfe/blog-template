///| 消息类型 - 扩展了更多交互功能
enum Msg {
  ToHome
  ToPost1
  ToPost2
  ToPost3
  ToPost4
  ToAbout
  Search(String)
  SelectTag(String)
  ToggleTheme
  LikePost(Int)
  SharePost(Int)
  LoadMorePosts
  ToggleMenu
}
///| 状态类型 - 添加了主题、菜单状态等
struct Model {
  page : Int // 0:首页, 1-4:详情页, 5:关于页
  search : String
  tag : String
  dark_theme : Bool
  menu_open : Bool
  liked_posts : Array[Int]
  posts_per_page : Int
  current_posts_count : Int
}
///| 博客文章结构 - 添加了更多字段
struct Post {
  id: Int
  emoji: String
  title: String
  author: String
  date: String
  summary: String
  content: String
  tag: String
  likes: Int
  read_time: String
  click: Msg
}
///| 更新函数 - 处理新增的消息类型
fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
  match msg {
    ToHome => (none(), { ..model, page: 0, menu_open: false })
    ToPost1 => (none(), { ..model, page: 1, menu_open: false })
    ToPost2 => (none(), { ..model, page: 2, menu_open: false })
    ToPost3 => (none(), { ..model, page: 3, menu_open: false })
    ToPost4 => (none(), { ..model, page: 4, menu_open: false })
    ToAbout => (none(), { ..model, page: 5, menu_open: false })
    Search(keyword) => (none(), { ..model, page: 0, search: keyword })
    SelectTag(tag) => (none(), { ..model, page: 0, tag: tag })
    ToggleTheme => (none(), { ..model, dark_theme: !model.dark_theme })
    ToggleMenu => (none(), { ..model, menu_open: !model.menu_open })
    LikePost(id) => {
      if model.liked_posts.contains(id) {
        model.liked_posts.retain(fn(x) { x != id })
      } else {
        model.liked_posts.push(id)
      }
      (none(), model)
    }
    SharePost(_id) => (none(), model) // 可以添加分享逻辑
    LoadMorePosts => (none(), { ..model, current_posts_count: model.current_posts_count + model.posts_per_page })
  }
}
///| 获取所有博客文章
fn get_all_posts() -> Array[Post] {
  [
    {
      id: 1,
      emoji: "👩‍💻", 
      title: "MoonBit 博客系统开发初探",
      author: "Zhuanz2",
      date: "2025-01-20",
      summary: "探索使用 MoonBit 和 rabbit-tea 框架构建现代化博客系统的最佳实践。",
      content: "在这篇文章中，我们将深入探讨如何使用 MoonBit 语言和 rabbit-tea 框架来构建一个功能完整的博客系统...",
      tag: "MoonBit",
      likes: 42,
      read_time: "5 分钟",
      click: ToPost1
    },
    {
      id: 2,
      emoji: "🦄",
      title: "Rabbit-tea 框架深度解析", 
      author: "Yoorkin",
      date: "2025-01-18",
      summary: "Rabbit-tea 是 MoonBit 生态中的前端框架，采用 TEA 架构模式，适合构建可维护的 Web 应用。",
      content: "Rabbit-tea 框架基于 The Elm Architecture (TEA) 设计模式，提供了一种函数式的方式来构建用户界面...",
      tag: "前端",
      likes: 38,
      read_time: "8 分钟",
      click: ToPost2
    },
    {
      id: 3,
      emoji: "🚀",
      title: "WebAssembly 在现代 Web 开发中的应用",
      author: "DevExpert",
      date: "2025-01-15",
      summary: "WebAssembly 正在改变 Web 开发的游戏规则，让我们看看如何在项目中有效利用这项技术。",
      content: "WebAssembly (WASM) 是一种新的编码方式，可以在现代的网络浏览器中运行...",
      tag: "WebAssembly",
      likes: 56,
      read_time: "12 分钟",
      click: ToPost3
    },
    {
      id: 4,
      emoji: "🎨",
      title: "函数式编程设计模式实战",
      author: "FPMaster",
      date: "2025-01-12",
      summary: "通过实际案例学习函数式编程的核心概念和设计模式，提升代码质量和可维护性。",
      content: "函数式编程不仅仅是一种编程范式，更是一种思维方式...",
      tag: "编程",
      likes: 34,
      read_time: "10 分钟",
      click: ToPost4
    }
  ]
}
///| 导航栏组件
fn navbar(model: Model) -> Html[Msg] {
  let theme_bg = if model.dark_theme { "bg-gray-800" } else { "bg-white" }
  let theme_text = if model.dark_theme { "text-white" } else { "text-gray-800" }
  
  div(class="fixed top-0 w-full z-50 " + theme_bg + " shadow-lg", [
    div(class="max-w-6xl mx-auto px-4 py-3 flex justify-between items-center", [
      button(
        class="text-2xl font-bold " + theme_text,
        click=ToHome,
        [text("🌸 MoonBit Blog")]
      ),
      div(class="hidden md:flex space-x-6", [
        button(class="hover:text-pink-500 " + theme_text, click=ToHome, [text("首页")]),
        button(class="hover:text-pink-500 " + theme_text, click=ToAbout, [text("关于")]),
        button(
          class="px-3 py-1 rounded-full border " + (if model.dark_theme { "border-gray-600" } else { "border-gray-300"}),
          click=ToggleTheme,
          [text(if model.dark_theme { "🌞" } else { "🌙" })]
        )
      ]),
      button(
        class="md:hidden " + theme_text,
        click=ToggleMenu,
        [text("☰")]
      )
    ])
  ])
}
///| 首页视图 - 增强版
fn view_home(model: Model) -> Html[Msg] {
  let posts = get_all_posts()
  let tags = ["全部", "MoonBit", "前端", "WebAssembly", "编程"]
  
  let filtered_posts = posts.filter(fn(post) {
    (model.tag == "" || model.tag == "全部" || post.tag == model.tag) &&
    (model.search == "" || post.title.contains(model.search) || post.summary.contains(model.search))
  })

  let bg_class = if model.dark_theme { 
    "min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900" 
  } else { 
    "min-h-screen bg-gradient-to-br from-pink-200 via-pink-100 to-white" 
  }

  div(class=bg_class, [
    navbar(model),
    
    div(class="pt-20", [
      // 英雄区域
      div(class="text-center py-16 px-4", [
        h1(
          class="text-6xl font-extrabold mb-4 " + (if model.dark_theme { "text-white" } else { "text-gray-800" }),
          [text("🌸 欢迎来到 MoonBit 世界")]
        ),
        p(
          class="text-xl mb-8 " + (if model.dark_theme { "text-gray-300" } else { "text-gray-600" }),
          [text("探索现代编程语言的魅力，分享技术见解与实践经验")]
        )
      ]),
      
      // 搜索和标签区域
      div(class="max-w-4xl mx-auto px-4 mb-8", [
        div(class="flex flex-wrap gap-3 mb-6 justify-center", [
          button(
            class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition",
            click=Search("MoonBit"),
            [text("🔍 搜索: MoonBit")]
          ),
          button(
            class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 transition",
            click=Search("前端"),
            [text("🔍 搜索: 前端")]
          ),
          button(
            class="px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 transition",
            click=Search(""),
            [text("✨ 清除搜索")]
          )
        ]),
        
        div(
          class="flex flex-wrap gap-2 justify-center",
          tags.map(fn(tag) {
            let is_active = model.tag == tag
            let btn_class = if is_active {
              "bg-pink-500 text-white px-4 py-2 rounded-full shadow-lg"
            } else {
              let base = "px-4 py-2 rounded-full transition hover:shadow-md"
              if model.dark_theme {
                base + " bg-gray-700 text-gray-200 hover:bg-gray-600"
              } else {
                base + " bg-white text-gray-700 hover:bg-gray-100"
              }
            }
            button(
              class=btn_class,
              click=SelectTag(tag),
              [text(tag)]
            )
          })
        )
      ]),
      
      // 博客列表
      div(class="max-w-4xl mx-auto px-4 pb-16", [
        if filtered_posts.length() == 0 {
          div(class="text-center py-16", [
            div(class="text-6xl mb-4", [text("📝")]),
            p(class="text-xl " + (if model.dark_theme { "text-gray-400" } else { "text-gray-500" }), [text("暂无相关文章")])
          ])
        } else {
          div(
            class="grid gap-8 md:grid-cols-2",
            filtered_posts.map(fn(post) {
              let card_bg = if model.dark_theme { "bg-gray-800" } else { "bg-white" }
              let card_text = if model.dark_theme { "text-white" } else { "text-gray-800" }
              let is_liked = model.liked_posts.contains(post.id)
              
              div(
                class=card_bg + " rounded-xl shadow-xl p-6 hover:scale-105 transition-all duration-300 border " + 
                      (if model.dark_theme { "border-gray-700" } else { "border-gray-100" }),
                [
                  div(class="flex items-start justify-between mb-4", [
                    div(class="text-3xl", [text(post.emoji)]),
                    div(class="flex gap-2", [
                      button(
                        class="text-xl " + (if is_liked { "text-red-500" } else { "text-gray-400" }),
                        click=LikePost(post.id),
                        [text(if is_liked { "❤️" } else { "🤍" })]
                      ),
                      button(
                        class="text-xl text-gray-400 hover:text-blue-500",
                        click=SharePost(post.id),
                        [text("🔗")]
                      )
                    ])
                  ]),
                  h2(class="text-xl font-bold mb-3 " + card_text, [text(post.title)]),
                  div(class="flex items-center gap-4 text-sm text-gray-500 mb-3", [
                    text("👤 " + post.author),
                    text("📅 " + post.date),
                    text("⏱️ " + post.read_time)
                  ]),
                  p(class="text-gray-600 mb-4 line-clamp-3", [text(post.summary)]),
                  div(class="flex justify-between items-center", [
                    div(
                      class="bg-pink-100 text-pink-700 px-3 py-1 rounded-full text-sm",
                      [text(post.tag)]
                    ),
                    button(
                      class="px-4 py-2 bg-pink-500 text-white rounded-lg hover:bg-pink-600 transition flex items-center gap-2",
                      click=post.click,
                      [text("阅读全文"), text("→")]
                    )
                  ]),
                  div(class="mt-3 flex items-center gap-2 text-sm text-gray-500", [
                    text("👍 " + post.likes.to_string() + " 赞")
                  ])
                ]
              )
            })
          )
        }
      ])
    ])
  ])
}
///| 文章详情页模板
fn view_post_detail(post: Post, model: Model) -> Html[Msg] {
  let bg_class = if model.dark_theme { "bg-gray-900" } else { "bg-gradient-to-br from-pink-100 to-white" }
  let card_bg = if model.dark_theme { "bg-gray-800" } else { "bg-white" }
  let text_color = if model.dark_theme { "text-white" } else { "text-gray-800" }
  
  div(class="min-h-screen " + bg_class, [
    navbar(model),
    div(class="pt-24 pb-16 px-4", [
      div(class="max-w-4xl mx-auto " + card_bg + " rounded-xl shadow-xl p-8", [
        div(class="flex items-center gap-4 mb-6", [
          div(class="text-4xl", [text(post.emoji)]),
          div(class="flex-1", [
            h1(class="text-3xl font-bold " + text_color, [text(post.title)]),
            div(class="flex items-center gap-4 mt-2 text-sm text-gray-500", [
              text("👤 " + post.author),
              text("📅 " + post.date),
              text("⏱️ " + post.read_time),
              text("👍 " + post.likes.to_string() + " 赞")
            ])
          ])
        ]),
        div(class="border-b border-gray-200 mb-8", [text("")]),
        div(class="prose prose-lg max-w-none " + text_color + " mb-8", [
          p(class="text-lg leading-relaxed", [text(post.content)])
        ]),
        div(class="flex gap-4", [
          button(
            class="px-6 py-3 bg-pink-500 text-white rounded-lg hover:bg-pink-600 transition flex items-center gap-2",
            click=ToHome,
            [text("🏠 返回首页")]
          ),
          button(
            class="px-6 py-3 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition flex items-center gap-2",
            click=LikePost(post.id),
            [text("👍 点赞")]
          ),
          button(
            class="px-6 py-3 bg-green-500 text-white rounded-lg hover:bg-green-600 transition flex items-center gap-2",
            click=SharePost(post.id),
            [text("🔗 分享")]
          )
        ])
      ])
    ])
  ])
}
///| 详情页视图函数
fn view_post1(model: Model) -> Html[Msg] {
  let posts = get_all_posts()
  view_post_detail(posts[0], model)
}

fn view_post2(model: Model) -> Html[Msg] {
  let posts = get_all_posts()
  view_post_detail(posts[1], model)
}

fn view_post3(model: Model) -> Html[Msg] {
  let posts = get_all_posts()
  view_post_detail(posts[2], model)
}

fn view_post4(model: Model) -> Html[Msg] {
  let posts = get_all_posts()
  view_post_detail(posts[3], model)
}
///| 关于页面
fn view_about(model: Model) -> Html[Msg] {
  let bg_class = if model.dark_theme { "bg-gray-900" } else { "bg-gradient-to-br from-pink-100 to-white" }
  let card_bg = if model.dark_theme { "bg-gray-800" } else { "bg-white" }
  let text_color = if model.dark_theme { "text-white" } else { "text-gray-800" }
  
  div(class="min-h-screen " + bg_class, [
    navbar(model),
    div(class="pt-24 pb-16 px-4", [
      div(class="max-w-4xl mx-auto " + card_bg + " rounded-xl shadow-xl p-8", [
        div(class="text-center mb-8", [
          div(class="text-6xl mb-4", [text("🌸")]),
          h1(class="text-4xl font-bold " + text_color + " mb-4", [text("关于 MoonBit 博客")]),
          p(class="text-xl text-gray-600", [text("探索现代编程语言的魅力")])
        ]),
        div(class="prose prose-lg max-w-none " + text_color, [
          h2(class="text-2xl font-bold mb-4", [text("项目介绍")]),
          p(class="mb-6 leading-relaxed", [
            text("这是一个使用 MoonBit 语言和 rabbit-tea 框架构建的现代化博客系统。"),
            text("项目展示了函数式编程在前端开发中的应用，以及 WebAssembly 技术的强大潜力。")
          ]),
          h2(class="text-2xl font-bold mb-4", [text("技术栈")]),
          div(class="grid md:grid-cols-2 gap-4 mb-6", [
            div(class="p-4 bg-pink-50 rounded-lg", [
              h3(class="font-bold text-pink-700", [text("🚀 MoonBit")]),
              p(class="text-sm text-gray-600", [text("现代化的编程语言，专为云计算和边缘计算设计")])
            ]),
            div(class="p-4 bg-blue-50 rounded-lg", [
              h3(class="font-bold text-blue-700", [text("🦄 Rabbit-tea")]),
              p(class="text-sm text-gray-600", [text("基于 TEA 架构的前端框架")])
            ]),
            div(class="p-4 bg-green-50 rounded-lg", [
              h3(class="font-bold text-green-700", [text("🎨 Tailwind CSS")]),
              p(class="text-sm text-gray-600", [text("实用优先的 CSS 框架")])
            ]),
            div(class="p-4 bg-purple-50 rounded-lg", [
              h3(class="font-bold text-purple-700", [text("🌐 WebAssembly")]),
              p(class="text-sm text-gray-600", [text("高性能的 Web 运行时技术")])
            ])
          ])
        ]),
        div(class="text-center", [
          button(
            class="px-6 py-3 bg-pink-500 text-white rounded-lg hover:bg-pink-600 transition",
            click=ToHome,
            [text("🏠 返回首页")]
          )
        ])
      ])
    ])
  ])
}
///| 主视图路由
fn view(model : Model) -> Html[Msg] {
  match model.page {
    0 => view_home(model)
    1 => view_post1(model)
    2 => view_post2(model)
    3 => view_post3(model)
    4 => view_post4(model)
    5 => view_about(model)
    _ => div(class="min-h-screen flex items-center justify-center", [
      div(class="text-center", [
        div(class="text-6xl mb-4", [text("😵")]),
        h1(class="text-2xl font-bold text-gray-800 mb-4", [text("页面未找到")]),
        button(
          class="px-6 py-3 bg-pink-500 text-white rounded-lg hover:bg-pink-600",
          click=ToHome,
          [text("返回首页")]
        )
      ])
    ])
  }
}
///| 主函数
fn main {
  let model = { 
    page: 0, 
    search: "", 
    tag: "", 
    dark_theme: false,
    menu_open: false,
    liked_posts: [],
    posts_per_page: 6,
    current_posts_count: 4
  }
  @tea.startup(model=model, update=update, view=view)
}