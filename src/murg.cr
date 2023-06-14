require "json"
require "duktape"
require "duktape/runtime"
require "gtk4"
require "uuid"
require "levenshtein"
require "colorize"
require "idle-gc"
require "baked_file_system"
require "non-blocking-spawn"
require "socket"

require "./murg/storage"
require "./murg/helpers/**"
require "./murg/attributes/**"
require "./murg/extensions/**"
require "./murg/exceptions/**"
require "./murg/javascript/**"
require "./murg/elements/**"
require "./murg/parser/**"
require "./murg/*"

module Murg
end
