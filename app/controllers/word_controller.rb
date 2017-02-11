class WordController < ApplicationController
require 'trie'
    def make_trie
      @trie = Trie.read("word_trie")
    end
    def welcome
      make_trie
      letters = ["a","g","a","w","u"]
      combination = (2..letters.length).flat_map{ |n| letters.permutation(n).map(&:join) }.uniq
      @words = []
      combination.each { |word| @words.push(word) if @trie.has_key?(word) }
    end
end
