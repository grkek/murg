require "../src/murg"

GC.disable

Log.setup(:info)

puts "JavaScript engine running at: #{Murg::JavaScript::Engine.instance.path}"

builder = Murg::Builder.new
builder.build_from_file(file: "#{__DIR__}/dist/index.html")
