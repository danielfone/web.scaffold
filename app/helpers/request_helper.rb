module RequestHelper
  def colorize(hash = {})
    tokens  = CodeRay.scan(hash.values.first, hash.keys.first)
    colored = tokens.html.div.sub('CodeRay', 'highlight')
    colored.gsub(/(https?:\/\/[^< "']+)/, '<a href="\1" target="_blank">\1</a>')
  end

  def pretty_print(type, content)
    type = type.to_s

    if type =~ /json|javascript/
      pretty_print_json(content)
    elsif type == 'js'
      pretty_print_js(content)
    elsif type.include? 'xml'
      pretty_print_xml(content)
    elsif type.include? 'html'
      colorize :html => content
    else
      content.inspect
    end
  end

  def pretty_print_json(content)
    json = Yajl::Parser.parse(content)
    pretty_print_js Yajl::Encoder.new(:pretty => true).encode(json)
  end

  def pretty_print_js(content)
    colorize :js => content
  end

  def pretty_print_xml(content)
    out = StringIO.new
    doc = REXML::Document.new(content)
    doc.write(out, 2)
    colorize :xml => out.string
  end

  def pretty_print_headers(content)
    lines = content.split("\n").map do |line|
      if line =~ /^(.+?):(.+)$/
        "<span class='nt'>#{$1}</span>:<span class='s'>#{$2}</span>"
      else
        "<span class='nf'>#{line}</span>"
      end
    end

    "<div class='highlight'><pre>#{lines.join}</pre></div>"
  end

  # accepts an array of request headers and formats them
  def pretty_print_requests(requests = [], fields = [])
    headers = requests.map do |request|
      pretty_print_headers request
    end

    headers.join + fields.join('&')
  end
end