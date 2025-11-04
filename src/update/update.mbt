using @tea {none}
///|
//| 更新函数 - 处理新增的消息类型
pub fn update(msg : @types.Msg, model : @types.Model) -> (@tea.Cmd[@types.Msg], @types.Model) {
  match msg {
    ToHome => (none(), { ..model, page: 0, menu_open: false })
    ToPost1 => (none(), { ..model, page: 1, menu_open: false })
    ToPost2 => (none(), { ..model, page: 2, menu_open: false })
    ToPost3 => (none(), { ..model, page: 3, menu_open: false })
    ToPost4 => (none(), { ..model, page: 4, menu_open: false })
    ToAbout => (none(), { ..model, page: 5, menu_open: false })
    Search(keyword) => (none(), { ..model, page: 0, search: keyword })
    SelectTag(tag) => (none(), { ..model, page: 0, tag })
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
    LoadMorePosts =>
      (
        none(),
        {
          ..model,
          current_posts_count: model.current_posts_count + model.posts_per_page,
        },
      )
    StartEdit(post_id) => (
      none(),
      {
        ..model,
        page: 6,
        current_edit_post: Some(post_id),
        preview_mode: false,
      },
    )
    CreateNewPost => (
      none(),
      {
        ..model,
        page: 6,
        current_edit_post: None,
        markdown_content: "",
        preview_mode: false,
      },
    )
    UpdateMarkdown(content) => (none(), { ..model, markdown_content: content })
    TogglePreview => (none(), { ..model, preview_mode: !model.preview_mode })
    SavePost => (
      none(),
      {
        ..model,
        page: 0,
        preview_mode: false,
      },
    )
    CancelEdit => (
      none(),
      { ..model, page: 0, preview_mode: false }
    )
  }
}
