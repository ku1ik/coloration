require 'textpow'

module Coloration

  module Readers

    class ItemsLookup

      # @param items []
      # @return [Coloration::Readers::ItemsLookup]
      # @todo
      def initialize(items)
        @items = items
      end

      # @param keys []
      # @return [void]
      # @todo
      def [](keys)
        keys.split(",").each do |key|
          best_selector = nil
          best_score = 0

          @items.keys.each do |selector|
            score = score_manager.score(selector, key)
            if score > best_score
              best_score, best_selector = score, selector
            end
          end

          return @items[best_selector] if best_selector
        end

        nil
      end

      private

      # @return [Textpow::ScoreManager]
      def score_manager
        @score_manager ||= Textpow::ScoreManager.new
      end

    end # ItemsLookup

  end # Readers

end # Coloration
