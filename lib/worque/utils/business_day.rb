module Worque
  module Utils
    module BusinessDay
      extend self

      def next(date, skip_weekend = true)
        shift(date, 1, skip_weekend)
      end

      def previous(date, skip_weekend = true)
        shift(date, -1, skip_weekend)
      end

      def previous_continuous(date)
        shift(date, -1, false)
      end

      private

      def shift(date, inc, skip_weekend = true)
        return date + inc unless skip_weekend && weekend?(date + inc)

        shift(date + inc, inc, skip_weekend)
      end

      def weekend?(date)
        date.wday == 0 || date.wday == 6
      end
    end
  end
end
