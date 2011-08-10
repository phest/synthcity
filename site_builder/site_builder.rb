
require "ostruct"

def color(name,r,g,b, line=:jump) # line arg is for site build
  c = OpenStruct.new(:name=>name, :r=>r,:g=>g,:b=>b)
  c.line = line
  c.rgb = "#{c.r},#{c.g},#{c.b}"
  c.hex = "#%02x%02x%02x" % [c.r, c.g, c.b]
  return c
end

require "../synthcity"

desc = "syntax highlighting palette"

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
  $colors.each do |c|
    
    css = "background-color:#{c.hex};"
    str << "<div class='color_box' style='#{css};'>#{c.rgb}<br/>#{c.hex}</div>"
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
  color: #{$colors[8].hex};
}
a:hover {
  color: #{$colors[1].hex};
}
a.author, a.author:visited {
  color: #{$colors[3].hex};
}
a.author:hover {
  color: #{$colors[1].hex};
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
.color_box {
  font-size: 0px;
  padding: 5px;
  width: 15px; height: 15px;
  float: left;
  text-align: center;
}
.color_box:hover {
  color: #{$background.hex};
  font-size: 13px;
  width: 100px; height: 100px;
}

.desc {
  #{$colors[0]}
}
"

html = "
<!DOCTYPE html><html>
 <head>
   <title>s y n t h c i t y</title>
   <meta content='#{desc}' name='keywords'>
   <style type='text/css'>
     #{css}
   </style>
 </head>
 <body>
   #{build_logo}

   <div class='desc'>
    #{desc} <br/>
    <span class='end'>by <a class='author' href='http://trsp.net'>steph thirion</a></span>
   </div>
   
   #{build_color_list}
   <br /> <br />
   
   <span class='end'>see an application example <a href='objc.png'>here</a></span>
   <br />
   <span class='end'>another palette: <a href='http://ethanschoonover.com/solarized'>solarized</a></span>
   
   <br />
   
   <br /><br /><br />
   
   
   #{build_color_boxes}
   


   
<a href='http://github.com/phest/synthcity'><img style='position: absolute; top: 0; right: 0; border: 0;' src='https://a248.e.akamai.net/assets.github.com/img/4c7dc970b89fd04b81c8e221ba88ff99a06c6b61/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f77686974655f6666666666662e706e67' alt='Fork me on GitHub'></a>
 </body>
</html>
"

target_path = File.expand_path(File.dirname(__FILE__) + '/index.html')
target_file = File.new(target_path, "w")
target_file.write(html)
target_file.close