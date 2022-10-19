module Murg
  class Storage
    extend BakedFileSystem

    bake_folder "./support"
  end
end
