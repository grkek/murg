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

spawn do
  console = Murg::Console.new
  console.wait_for_input
  exit
end

builder = Murg::Builder.new
builder.build_from_document(document: "#{__DIR__}/dist/index.html")
