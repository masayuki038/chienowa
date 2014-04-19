module ItemsHelper
  def markdown(text)
    html = Redcarpet::Markdown.new(
      RedcarpetFilenameExtension::BlockCodeWithFilename.new(linenos: 1),
      #Redcarpet::Render::HTML.new(hard_wrap: true),
      tables: true,
      autolink: true,
      superscript: true,
      strikethrough: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      gh_blockcode: true,
      space_after_headers: true
    ).render(text).html_safe
  end
end
