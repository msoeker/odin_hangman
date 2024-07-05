class Word
  def extract_random_word
    random_word = File.readlines('google-10000-english-no-swears.txt').map(&:chomp).select{ |s| s.length.between?(5, 12) }.sample
  end
end
