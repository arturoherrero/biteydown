require 'github/markup'

class Markup

  def generate_html(markdown_file)
    html = GitHub::Markup.render(markdown_file)
    add_stylesheet!(html)
    add_head!(html)
  end

  def add_head!(html)
    html.insert(0, "\n<head>\n<meta charset='utf-8'>\n</head>\n")
  end

  def add_stylesheet!(html)
    html.insert(0, "\n<style>#{File.read('style/style.css')}</style>\n")
  end
end
