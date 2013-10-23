require 'github/markup'

class Markup

  def generate_html(markdown_file, css_path)
    html = GitHub::Markup.render(markdown_file)
    add_stylesheet!(html, css_path)
    add_head!(html)
  end

  def add_head!(html)
    html.insert(0, "\n<head>\n<meta charset='utf-8'>\n</head>\n")
  end

  def add_stylesheet!(html, css_path)
    html.insert(0, "\n<style>#{File.read(css_path)}</style>\n")
  end
end
