///|
/// 文章详情页模板
fn view_post_detail(post : @types.Post, model : @types.Model) -> Html[@types.Msg] {
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
        div(class="flex items-center gap-4 mb-6", [
          div(class="text-4xl", [text(post.emoji)]),
          div(class="flex-1", [
            h1(class="text-3xl font-bold " + text_color, [text(post.title)]),
            div(class="flex items-center gap-4 mt-2 text-sm text-gray-500", [
              text("👤 " + post.author),
              text("📅 " + post.date),
              text("⏱️ " + post.read_time),
              text("👍 " + post.likes.to_string() + " 赞"),
            ]),
          ]),
        ]),
        div(class="border-b border-gray-200 mb-8", [text("")]),
        div(class="prose prose-lg max-w-none " + text_color + " mb-8", [
          p(class="text-lg leading-relaxed", [text(post.content)]),
        ]),
        div(class="flex gap-4", [
          button(
            class="px-6 py-3 bg-pink-500 text-white rounded-lg hover:bg-pink-600 transition flex items-center gap-2",
            click=@types.Msg::ToHome,
            [text("🏠 返回首页")],
          ),
          button(
            class="px-6 py-3 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition flex items-center gap-2",
            click=@types.Msg::LikePost(post.id),
            [text("👍 点赞")],
          ),
          button(
            class="px-6 py-3 bg-green-500 text-white rounded-lg hover:bg-green-600 transition flex items-center gap-2",
            click=@types.Msg::SharePost(post.id),
            [text("🔗 分享")],
          ),
        ]),
      ]),
    ]),
  ])
}

///|
pub fn view_post1(model : @types.Model) -> Html[@types.Msg] {
  let posts = @data.get_all_posts()
  view_post_detail(posts[0], model)
}

///|
pub fn view_post2(model : @types.Model) -> Html[@types.Msg] {
  let posts = @data.get_all_posts()
  view_post_detail(posts[1], model)
}

///|
pub fn view_post3(model : @types.Model) -> Html[@types.Msg] {
  let posts = @data.get_all_posts()
  view_post_detail(posts[2], model)
}

///|
pub fn view_post4(model : @types.Model) -> Html[@types.Msg] {
  let posts = @data.get_all_posts()
  view_post_detail(posts[3], model)
}
