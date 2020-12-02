require 'yaml'

class Sum2020
  def initialize(entries:, expected_sum:, amount_numbers:)
    @entries = entries
    @expected_sum = expected_sum
    @amount_numbers = amount_numbers
    @outcome = 0
  end

  def call
    iteration([], [], (amount_numbers - 1))
    outcome
  end

  private

  attr_reader :entries, :amount_numbers, :expected_sum, :outcome

  def iteration(active_entries, active_indexes, needed_layers)
    entries.each_with_index do |this_entry, this_index|
      break if @outcome != 0
      next if active_indexes.include?(this_index)

      current_entries = active_entries + [this_entry]

      if needed_layers.zero?
        @outcome = current_entries.inject(:*) if current_entries.inject(:+) == expected_sum
      else
        iteration(current_entries, active_indexes + [this_index], (needed_layers - 1))
      end
    end
  end
end

entries = YAML.safe_load(File.read('input.yml'))
# entries = [2000, 11, 9, 1]
sumsum = Sum2020.new(entries: entries, expected_sum: 2020, amount_numbers: 3)
puts sumsum.call
