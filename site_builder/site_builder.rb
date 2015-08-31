
require "ostruct"

def color(name,r,g,b, line=:jump) # line arg is for site build
  c = OpenStruct.new(:name=>name, :r=>r,:g=>g,:b=>b)
  c.line = line
  c.rgb = "#{c.r},#{c.g},#{c.b}"
  c.hex = "#%02x%02x%02x" % [c.r, c.g, c.b]
  return c
end

require_relative "../synthcity"

def analytics
  "
  <script type='text/javascript'>

    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-25054566-1']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();

  </script>
  "
end

def build_logo
  logo_colors = [1,5,4,7,2, 1,5,4,2]
  sentence = 'synthcity'
  str = "<h1>"
  sentence.split('').each_with_index do |char,i|
    c = $colors[logo_colors[i]]
    str << "<span style='color:#{c.hex};'>#{char}</span>\n"
  end
  str << "</h1>"
end
def build_color_list
  str = ""
  $colors.each_with_index do |c,i|
    if c.line != :same
      str << '<br />'
    end

    last_name = c.name
    css = "color:#{c.hex};"
    str << "<span style='#{css};'>#{c.name} </span>"
  end
  str << '<br />'
end
def build_color_boxes
  str = ""
  colors = [$background]+$colors
  colors.each_with_index do |c,i|
    klass = (i==0) ? 'color_box_bg' : 'color_box'
    css = "background-color:#{c.hex};"
    str << "<div class='#{klass}' style='#{css};'>#{c.rgb}<br/>#{c.hex}</div>"
  end
  str
end

css = "
body {
  color: #{$colors[0].hex};
  background-color: #{$background.hex};
  font-family: Monaco, 'Courier New',Courier,Consolas,'Nimbus Mono L',monospace;
  font-size: 13px;
  margin: 30px;
  margin-left: 30px; margin-right: 30px;
}
a {

}
a, a:visited {
  color: #{$colors[1].hex};
}
a:hover {
  color: #{$colors[4].hex};
}
a.author, a.author:visited {
  color: #{$colors[3].hex};
}
a.author:hover {
  color: #{$colors[5].hex};
}
h1 {
  font-size: 20px;
  font-weight:normal;
  margin: 0px;
}
.desc {
  margin-top: 10px;
  margin-bottom: 10px;
}
.color_box, .color_box_bg, .color_box_sp {
  font-size: 0px;
  padding: 5px;
  width: 15px; height: 15px;
  float: left;
  text-align: center;
}
.color_box:hover, .color_box_bg:hover, .color_box_sp:hover {
  color: #{$background.hex};
  font-size: 13px;
  width: 100px; height: 100px;
}
.color_box_bg {
  border-style:solid;
  border-width:4px;
  border-color: #{$colors[0].hex};
  width: 7px; height: 7px;
}
.color_box_bg:hover {
  color: #{$colors[0].hex};
}
"
$colors.each do |color|
  css += "
  .#{color.name} {
    color: #{color.hex};
  }
  "
end


ribbon_orange = <<RIBBON
<a href="http://github.com/phest/synthcity"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/652c5b9acfaddf3a9c326fa6bde407b87f7be0f4/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6f72616e67655f6666373630302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_orange_ff7600.png"></a>
RIBBON
ribbon_gray = <<RIBBON
<a href="http://github.com/phest/synthcity"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/a6677b08c955af8400f44c6298f40e7d19cc5b2d/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677261795f3664366436642e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png"></a>
RIBBON
ribbon_white = <<RIBBON
<a href="http://github.com/phest/synthcity"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/52760788cde945287fbb584134c4cbc2bc36f904/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f77686974655f6666666666662e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_white_ffffff.png"></a>
RIBBON

html = "
<!DOCTYPE html><html>
 <head>
   <title>Synth City</title>
   <meta content='a syntax highlighting palette' name='keywords'>
   <style type='text/css'>
     #{css}
   </style>
 </head>
 #{analytics}
 <body>
   #{build_logo}

   <div class='desc'>
    a syntax highlighting palette<br/>
    <span>by <a class='author' href='http://trsp.net'>steph thirion</a></span>
   </div>

   #{build_color_list}
   <br /> <br />


   <br />
   <span class='white'>-> <span class='green'>Atom</span> <a href='https://atom.io/themes/synthcity-atom-syntax'>theme</a></span>
   <br />
   <span class='white'>-> <span class='purple'>TextMate</span> <a href='https://github.com/prestia/textmate-synthcity'>theme</a></span>
   <br />
   <br />
   <span>See an application example <a href='objc.png'>here</a></span>
   <br />

   <br /><br /><br />


   #{build_color_boxes}




<a href='http://github.com/phest/synthcity'>
  #{ribbon_gray}
</a>
 </body>
</html>
"

target_path = File.expand_path(File.dirname(__FILE__) + '/index.html')
target_file = File.new(target_path, "w")
target_file.write(html)
target_file.close
