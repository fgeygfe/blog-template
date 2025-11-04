using @router { view }
using @update { update }
///|
fn main {
  let model : @types.Model = {
    page: 0,
    search: "",
    tag: "",
    dark_theme: false,
    menu_open: false,
    liked_posts: [],
    posts_per_page: 6,
    current_posts_count: 4,
    editing_mode: false,
    current_edit_post: None,
    markdown_content: "",
    preview_mode: false,
    editor_cursor_pos: 0,
  }
  @tea.startup(
    model~,
    update~,
    view~
  )
}
