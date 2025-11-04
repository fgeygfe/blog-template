///|
/// 首页视图 - 增强版
pub fn view_home(model : @types.Model) -> Html[@types.Msg] {
  let posts = @data.get_all_posts()
  let tags = ["全部", "MoonBit", "前端", "WebAssembly", "编程"]
  let filtered_posts = posts.filter(fn(post) {
    (model.tag == "" || model.tag == "全部" || post.tag == model.tag) &&
    (
      model.search == "" ||
      post.title.contains(model.search) ||
      post.summary.contains(model.search)
    )
  })
  let bg_class = if model.dark_theme {
    "min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900"
  } else {
    "min-h-screen bg-gradient-to-br from-pink-200 via-pink-100 to-white"
  }
  div(class=bg_class, [
    @component.navbar(model),
    div(class="pt-20", [
      // 英雄区域
      div(class="text-center py-16 px-4", [
        h1(
          class="text-6xl font-extrabold mb-4 " +
            (if model.dark_theme { "text-white" } else { "text-gray-800" }),
          [text("🌸 欢迎来到 MoonBit 世界")],
        ),
        p(
          class="text-xl mb-8 " +
            (if model.dark_theme { "text-gray-300" } else { "text-gray-600" }),
          [
            text(
              "探索现代编程语言的魅力，分享技术见解与实践经验",
            ),
          ],
        ),
      ]),

      // 搜索和标签区域
      div(class="max-w-4xl mx-auto px-4 mb-8", [
        div(class="flex flex-wrap gap-3 mb-6 justify-center", [
          button(
            class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition",
            click=@types.Msg::Search("MoonBit"),
            [text("🔍 搜索: MoonBit")],
          ),
          button(
            class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 transition",
            click=@types.Msg::Search("前端"),
            [text("🔍 搜索: 前端")],
          ),
          button(
            class="px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 transition",
            click=@types.Msg::Search(""),
            [text("✨ 清除搜索")],
          ),
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
            button(class=btn_class, click=@types.Msg::SelectTag(tag), [text(tag)])
          }),
        ),
      ]),

      // 博客列表
      div(class="max-w-4xl mx-auto px-4 pb-16", [
        if filtered_posts.length() == 0 {
          div(class="text-center py-16", [
            div(class="text-6xl mb-4", [text("📝")]),
            p(
              class="text-xl " +
                (if model.dark_theme {
                  "text-gray-400"
                } else {
                  "text-gray-500"
                }),
              [text("暂无相关文章")],
            ),
          ])
        } else {
          div(
            class="grid gap-8 md:grid-cols-2",
            filtered_posts.map(fn(post) {
              let card_bg = if model.dark_theme {
                "bg-gray-800"
              } else {
                "bg-white"
              }
              let card_text = if model.dark_theme {
                "text-white"
              } else {
                "text-gray-800"
              }
              let is_liked = model.liked_posts.contains(post.id)
              div(
                class=card_bg +
                  " rounded-xl shadow-xl p-6 hover:scale-105 transition-all duration-300 border " +
                  (if model.dark_theme {
                    "border-gray-700"
                  } else {
                    "border-gray-100"
                  }),
                [
                  div(class="flex items-start justify-between mb-4", [
                    div(class="text-3xl", [text(post.emoji)]),
                    div(class="flex gap-2", [
                      button(
                        class="text-xl " +
                          (if is_liked {
                            "text-red-500"
                          } else {
                            "text-gray-400"
                          }),
                        click=@types.Msg::LikePost(post.id),
                        [text(if is_liked { "❤️" } else { "🤍" })],
                      ),
                      button(
                        class="text-xl text-gray-400 hover:text-blue-500",
                        click=@types.Msg::SharePost(post.id),
                        [text("🔗")],
                      ),
                    ]),
                  ]),
                  h2(class="text-xl font-bold mb-3 " + card_text, [
                    text(post.title),
                  ]),
                  div(
                    class="flex items-center gap-4 text-sm text-gray-500 mb-3",
                    [
                      text("👤 " + post.author),
                      text("📅 " + post.date),
                      text("⏱️ " + post.read_time),
                    ],
                  ),
                  p(class="text-gray-600 mb-4 line-clamp-3", [
                    text(post.summary),
                  ]),
                  div(class="flex justify-between items-center", [
                    div(
                      class="bg-pink-100 text-pink-700 px-3 py-1 rounded-full text-sm",
                      [text(post.tag)],
                    ),
                    button(
                      class="px-4 py-2 bg-pink-500 text-white rounded-lg hover:bg-pink-600 transition flex items-center gap-2",
                      click=post.click,
                      [text("阅读全文"), text("→")],
                    ),
                  ]),
                  div(
                    class="mt-3 flex items-center gap-2 text-sm text-gray-500",
                    [text("👍 " + post.likes.to_string() + " 赞")],
                  ),
                ],
              )
            }),
          )
        },
      ]),
    ]),
  ])
}
