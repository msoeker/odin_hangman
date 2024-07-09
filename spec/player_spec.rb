require 'rspec'
require_relative '../lib/player'

RSpec.describe Player do
  describe '#get_guess' do
    let(:player) { Player.new }

    it 'returns a single character' do
      allow(player).to receive(:gets).and_return("a\n")
      expect(player.get_guess).to eq('a')
    end

    it 'returns menu' do
      allow(player).to receive(:gets).and_return("menu\n")
      expect(player.get_guess).to eq('menu')
    end

    it 'prompts again for input if more than one character is entered' do
      allow(player).to receive(:gets).and_return("ab\n", "a\n")
      expect { player.get_guess }.to output(/just ONE character allowed!/).to_stdout
    end

    it 'prompts again for input if input is empty' do
      allow(player).to receive(:gets).and_return("\n", "a\n")
      expect { player.get_guess }.to output(/Input cannot be empty!/).to_stdout
    end
  end
end
