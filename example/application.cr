require "../src/murg"

def spawn(*, name : String? = nil, same_thread = false, &block) : Fiber
  fiber = Fiber.new(name, &block)
  if same_thread
    fiber.@current_thread.set(Thread.current)
  else
    non_blocking_threads = threads
    fiber.@current_thread.set(non_blocking_threads.sample) unless non_blocking_threads.size == 0
  end
  Crystal::Scheduler.enqueue fiber
  fiber
end

def threads : Array(Thread)
  threads = [] of Thread
  Thread.unsafe_each do |thread|
    next if thread == Thread.current
    threads << thread
  end
  threads
end

# Uncomment this line if you want to enable console which
# pipes the input directly to Duktape engine.
#
# The console is not that great since the output is scrambled by the error logs of Duktape.
#
# spawn do
#   console = Murg::Console.new
#   console.wait_for_input
# end

builder = Murg::Builder.new
builder.build_from_document(document: "#{__DIR__}/dist/index.html")
