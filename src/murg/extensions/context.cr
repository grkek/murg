module Duktape
  class Context
    @mutex = Mutex.new(:reentrant)
  end
end
