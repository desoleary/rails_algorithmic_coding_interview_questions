# frozen_string_literal: true

module AlgorithmicCodeExamples

  CIRCLE_DEGREES = 360

  class ClockHandleDiffCalculator
    def initialize(hours:, minutes:)
      @hours = hours
      @minutes = minutes
    end

    def hours_angle
      @hours * (CIRCLE_DEGREES / 12)
    end

    def minutes_angle
      @minutes * (CIRCLE_DEGREES / 60)
    end

    def calculate
      clockwise_diff = (hours_angle - minutes_angle).abs
      return clockwise_diff if clockwise_diff < CIRCLE_DEGREES / 2

      with_hours_reverse_diff = reverse_diff(hours_angle, minutes_angle)
      with_minutes_reverse_diff = reverse_diff(minutes_angle, minutes_angle)

      [with_hours_reverse_diff, with_minutes_reverse_diff].min
    end

    def reverse_diff(angle_x, angle_y)
      ((angle_x - 360) + angle_y).abs
    end
  end

  RSpec.describe '#calculateAngleBetweenClockHandles' do
    describe 'Calculates difference between two handles of a clock' do
      it 'should take the minimum angle difference' do
        expect(ClockHandleDiffCalculator.new(hours: 3, minutes: 20).calculate).to eq(30)
        expect(ClockHandleDiffCalculator.new(hours: 12, minutes: 1).calculate).to eq(6)
        expect(ClockHandleDiffCalculator.new(hours: 7, minutes: 5).calculate).to eq(120)
      end
    end
  end
end
