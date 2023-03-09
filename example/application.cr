require "../src/murg"

GC.disable

Log.setup(:debug)

builder = Murg::Builder.new
puts "JavaScript engine running at: #{Murg::JavaScript::Engine.instance.path}"
builder.build_from_file(file: "#{__DIR__}/dist/index.html")
