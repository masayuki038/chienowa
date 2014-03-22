module ItemHistoriesHelper
  def to_diff_html(txt)
    f = Diffy::HtmlFormatter.new(txt.split("\n"), include_plus_and_minus_in_html: true)
    f.to_s
  end
end
