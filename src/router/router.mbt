using @html {div, h1, h2, h3, p, button, text}
///| 主视图路由
pub fn view(model : @types.Model) -> @html.Html[@types.Msg] {
  match model.page {
    0 => @views.view_home(model)
    1 => @views.view_post1(model)
    2 => @views.view_post2(model)
    3 => @views.view_post3(model)
    4 => @views.view_post4(model)
    5 => @views.view_about(model)
    6 => @views.view_editor(model)
    _ => div(class="min-h-screen flex items-center justify-center", [
      div(class="text-center", [
        div(class="text-6xl mb-4", [text("😵")]),
        h1(class="text-2xl font-bold text-gray-800 mb-4", [text("页面未找到")]),
        button(
          class="px-6 py-3 bg-pink-500 text-white rounded-lg hover:bg-pink-600",
          click=@types.Msg::ToHome,
          [text("返回首页")]
        )
      ])
    ])
  }
}