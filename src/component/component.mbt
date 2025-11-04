using @html {div, h1, h2, h3, p, button, text, input}
using @html {type Html}
///|
/// 导航栏组件
pub fn navbar(model : @types.Model) -> @html.Html[@types.Msg] {
  let theme_bg = if model.dark_theme { "bg-gray-800" } else { "bg-white" }
  let theme_text = if model.dark_theme { "text-white" } else { "text-gray-800" }
  div(class="fixed top-0 w-full z-50 " + theme_bg + " shadow-lg", [
    div(class="max-w-6xl mx-auto px-4 py-3 flex justify-between items-center", [
      button(class="text-2xl font-bold " + theme_text, click=@types.Msg::ToHome, [
        text("🌸 MoonBit Blog"),
      ]),
      div(class="hidden md:flex space-x-6", [
        button(class="hover:text-pink-500 " + theme_text, click=@types.Msg::ToHome, [
          text("首页"),
        ]),
        button(class="hover:text-pink-500 " + theme_text, click=@types.Msg::ToAbout, [
          text("关于"),
        ]),
        button(class="hover:text-pink-500 " + theme_text, click=@types.Msg::CreateNewPost, [
          text("新建")
        ]),
        button(
          class="px-3 py-1 rounded-full border " +
            (if model.dark_theme {
              "border-gray-600"
            } else {
              "border-gray-300"
            }),
          click=@types.Msg::ToggleTheme,
          [text(if model.dark_theme { "🌞" } else { "🌙" })],
        ),
      ]),
      button(class="md:hidden " + theme_text, click=@types.Msg::ToggleMenu, [text("☰")]),
    ]),
  ])
}
