module ItemsHelper
  def markdown(text, laxer)
    html = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(hard_wrap: true),
      tables: true,
      autolink: true,
      superscript: true,
      strikethrough: true,
      no_intra_emphasis: true,
      fenced_code_block: true,
      space_after_headers: true
    ).render(text)
    highlight(html, laxer).html_safe
  end

  def highlight(html, laxer)
    doc = Nokogiri::HTML(html)
    doc.search("pre").each do |pre|
      pre.replace(
        Pygments.highlight(
          pre.text.rstrip,
          laxer: laxer
        )
      )
    end
    doc.to_s
  end
end
