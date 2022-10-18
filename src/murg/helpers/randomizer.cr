module Murg
  module Helpers
    module Randomizer
      def self.random_string(size : Int = 8, charset : String = "ACDEFGHJKMNPQRTWXYZabcdefghjkmnopqrstwxy")
        charset = charset.chars

        String.build(size) do |io|
          size.times do
            io << charset.sample(Random)
          end
        end
      end
    end
  end
end
