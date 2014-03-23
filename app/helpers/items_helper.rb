module ItemsHelper
  def markdown(text)
    html = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(hard_wrap: true),
      tables: true,
      autolink: true,
      superscript: true,
      strikethrough: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      gh_blockcode: true,
      space_after_headers: true
    ).render(text)
    highlight(html).html_safe
  end

  def highlight(html)
    doc = Nokogiri::HTML(html)
    doc.search("pre").each do |pre|
      laxer = pre.children.attribute("class").value || "ruby"
      pre.replace(
        Pygments.highlight(
          pre.text.rstrip,
          laxer: laxer,
          options: { linenos: 1 }
        )
      )
    end
    doc.xpath('//body').inner_html
  end
end
