///|
/// 消息类型 - 扩展了更多交互功能
pub(all) enum Msg {
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
  StartEdit(Int)
  CancelEdit
  SavePost
  UpdateMarkdown(String)
  TogglePreview
  CreateNewPost
}

///|
/// 状态类型 - 添加了主题、菜单状态等
pub(all) struct Model {
  page : Int // 0:首页, 1-4:详情页, 5:关于页
  search : String
  tag : String
  dark_theme : Bool
  menu_open : Bool
  liked_posts : Array[Int]
  posts_per_page : Int
  current_posts_count : Int
  editing_mode : Bool
  current_edit_post : Int?
  markdown_content : String
  preview_mode : Bool
  editor_cursor_pos : Int
}

///|
/// 博客文章结构 - 添加了更多字段
pub struct Post {
  id : Int
  emoji : String
  title : String
  author : String
  date : String
  summary : String
  content : String
  rendered_content : String?
  tag : String
  likes : Int
  read_time : String
  click : Msg
}

///|
pub fn Post::new(
  id : Int,
  emoji : String,
  title : String,
  author : String,
  date : String,
  summary : String,
  content : String,
  tag : String,
  likes : Int,
  read_time : String,
  click : Msg,
) -> Post {
  {
    id,
    emoji,
    title,
    author,
    date,
    summary,
    content,
    rendered_content: None,
    tag,
    likes,
    read_time,
    click,
  }
}
