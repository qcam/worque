module Worque
  module Utils
    module BusinessDay
      extend self

      def next(date)
        shift(date, 1)
      end

      def previous(date, skip_weekend = true)
        shift(date, -1, skip_weekend)
      end

      def previous_continuous(date)
        shift(date, -1, false)
      end

      private

      def shift(date, inc, skip_weekend = true)
        loop do
          date += inc
          break if !skip_weekend || !weekend?(date)
        end
        date
      end

      def weekend?(date)
        date.wday == 0 || date.wday == 6
      end
    end
  end
end
