class WordController < ApplicationController
    require 'trie'
    $trie ||= Trie.read("word_trie")
    def home
    end

    def search
      letters = params[:q].chars.sort
      combination = (2..letters.length).flat_map{ |n| letters.permutation(n).map(&:join) }.uniq
      @words = []
      combination.each { |word| @words.push(word) if $trie.has_key?(word) }
    end

    # private

    private
    def make_trie
     # $trie = Trie.read("word_trie")
    end

end
