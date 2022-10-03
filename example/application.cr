require "../src/murg"

builder = Murg::Builder.new
builder.build_from_document(document: "#{__DIR__}/dist/index.html")
