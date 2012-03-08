module ApplicationHelper

  def markdown(string)
    raw Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      :autolink => true, :space_after_headers => true).render(string)
  end

end
