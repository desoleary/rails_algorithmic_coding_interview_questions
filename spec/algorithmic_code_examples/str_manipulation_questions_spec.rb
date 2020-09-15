# frozen_string_literal: true

# Reference:
# [20+ String Coding Interview Questions for Programmers](https://hackernoon.com/20-string-coding-interview-questions-for-programmers-6b6735b6d31c)

module AlgorithmicCodeExamples
  describe 'string manipulation questions' do
    describe 'How do you find the length of the longest substring without repeating characters?' do
      # def longest_substring(str)
      #   memo = Array.new([])
      #   ['', *str.chars].each_cons(2) do |curr, nxt, two_ahead|
      #     last_char = memo.last || ''
      #     if curr.empty? || curr == nxt
      #       memo.push('') unless (memo.last || '').empty?
      #     else
      #       next_val = "#{memo.pop || ''}#{curr}"
      #       memo.push(next_val)
      #     end
      #   end
      #
      #   memo.max_by(&:length)
      # end

      def longest_substring(str)
        substrings = ['', *str.split(/(\w)\1+/), ''].each_cons(3).each_with_object([]) do |(prev, current, nxt), memo|
          sub_string = current
          sub_string = "#{prev}#{sub_string}" if prev.length == 1
          sub_string = "#{sub_string}#{nxt}" if nxt.length == 1
          memo.push(sub_string)
        end
        max_length = substrings.map(&:length).max
        substrings.select { |substring| substring.length == max_length }
      end

      it 'finds longest substring without repeating chars' do
        actual = longest_substring('abcifghfhgfddefghiijklmnop')

        expect(actual).to eql(['abcifghfhgfd'])
      end
    end

    describe 'splice two strings' do
      def combine_strings(str_x, str_y)
        max_length_range = 0...[str_x.size, str_y.size].max
        max_length_range.to_a.reduce('') do |memo, index|
          memo += "#{str_x[index] || ''}#{str_y[index] || ''}"
          memo
        end
      end

      it 'combines two string one character at a time' do
        expect(combine_strings('acegi', 'bdfhjlnp')).to eql('abcdefghijlnp')
      end
    end

    describe 'How do you print duplicate characters from a string?' do
      # List of duplicate characters in String
      #
      # Example input: 'Programming'
      # Example output: 'gmr'

      it 'prints out duplicate characters' do
        def print_duplicate_characters(str)
          character_count_hash =
            str.chars.sort.each_with_object(Hash.new(0)) do |char, memo|
              memo[char] += 1
            end

          character_count_hash.select { |_, count| count > 1 }.keys.join('')
        end

        expect(print_duplicate_characters('Programming')).to eql('gmr')
      end
    end

    describe 'How do you reverse a given string in place?' do
      describe '#reverse_str - Non native ruby approach ' do
        # Reverses string contents
        #
        # @param [string] str
        def reverse_str(str)
          str.chars.reduce([]) { |memo, c| memo.insert(0, c.to_s) }.join('')
        end

        it 'reverses string contents' do
          expect(reverse_str('abc')).to eql('cba')
        end
      end

      describe 'native ruby approach ' do
        describe 'str#reverse' do
          it 'reverses string contents' do
            expect('abc'.reverse).to eql('cba')
          end
        end
      end
    end
  end
end
