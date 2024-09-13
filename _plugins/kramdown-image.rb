# Adding captions to images defined in ![] format

require 'kramdown/converter/html'

module StandaloneImages
    def convert_p(el, indent)
        if el.type == :p
            ell = el.children.first
            if is_standalone_image? ell
                return convert_standalone_image(ell, indent)
            end
        end

        super
    end

    def is_standalone_image?(el)
        el.type == :img || (el.type == :html_element && el.value == "img")
    end

    def convert_standalone_image(el, indent)
        image_attr = el.attr.dup
        body = "#{' ' * (indent + @indent)}<img#{html_attributes(image_attr)} />\n" \
        "#{' ' * (indent + @indent)}<figcaption>#{image_attr['alt']}</figcaption>\n"
        format_as_indented_block_html("figure", image_attr, body, indent)
    end

end

Kramdown::Converter::Html.prepend StandaloneImages