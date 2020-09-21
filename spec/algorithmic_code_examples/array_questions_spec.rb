# frozen_string_literal: true

module AlgorithmicCodeExamples
  describe 'Array Algorithmic Examples' do
    # Sum of all sub arrays in O(n) Time
    #
    # Objective:  Given an array write an algorithm to find the sum of all the possible sub-arrays.
    #
    # Example:
    #
    # int [] a = {1, 2, 3};
    #
    # Output: Possible subarrays –
    # {1}, {2}, {3}, {1, 2} , {2, 3}, {1, 2, 3}
    # So sum = 1+ 2+ 3 + 3 + 5 + 6 = 20
    #
    describe 'Sum of all sub arrays in O(n) Time' do
      class ArrayBigONotationCalculator
        include Enumerable

        def initialize(items)
          @items = items
          @sub_arrays = []
        end

        def each
          @items.each { |item| yield item }
        end

        def each_sub_array
          @sub_arrays.each { |sub_array| yield sub_array }
        end

        def build_sub_arrays
          @sub_arrays =
            @items.to_a.reverse.reduce([]) do |memo, size|
              memo.concat(@items.combination(size).to_a)
            end

          self
        end

        def filter_by_n(number_of_operations)
          @sub_arrays.select { |sub_array| sub_array.first <= number_of_operations }
        end

        attr_reader :sub_arrays

        def total_sum
          @sub_arrays.collect(&:sum).sum
        end
      end

      it 'calculates sum of all sub arrays' do
        expect(
          ArrayBigONotationCalculator.new([1, 2, 3]).build_sub_arrays.total_sum
        ).to eql(24)
      end

      context 'with Time complexity: O(n^3)' do
        xit 'calculates sum of O(n^3)' do
          expect(
            ArrayBigONotationCalculator.new([1, 2, 3, 4]).build_sub_arrays
              .filter_by_n(3)
          ).to eql(24)
        end
      end
    end
  end
end
