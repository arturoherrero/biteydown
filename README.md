# biteydown

Convert your curriculum vitae in [Markdown] syntax to HTML or PDF file.


### Instalation

    bundle install


### Usage

    Usage: biteydown [options] file
            --html                       Create HTML file
            --pdf                        Create PDF file
        -h, --help                       Display help

    $ bin/biteydown --html --pdf example/curriculum.md


### Style

You can customize the look and feel of text and headings in your document using the `style/style.css` file. First is transformed the Markdown document to HTML file and then apply the style. It's a little bit hacky, but works fine.

Markdown is a lightweight markup language designed as an easy-to-read, easy-to-write plain text format and then convert it to structurally valid HTML; therefore, CSS selectors can be used to customize the curriculum.

![image](https://github.com/arturoherrero/biteydown/raw/master/cv-css-selectors.png)

CSS works by associating rules with HTML elements. In this case, there are a little group of selectors that can be used: `h1-h6`, `blockquote`, `a`, `li`, `code`, `strong`, `em`, `img`. You cannot use id or class selectors to create rules that apply to elements.


[Markdown]: http://daringfireball.net/projects/markdown/
