require "../src/murg"

# Disable GC for because of invalid memory access bug.
GC.disable

builder = Murg::Builder.new
builder.build_from_file(file: "#{__DIR__}/dist/index.html")
