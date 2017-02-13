class WordController < ApplicationController
    require 'trie'
    $trie ||= Trie.read("word_trie")
    def home
    end

    def search
      letters = params[:q].gsub(/\s+/, "").chars.sort # needs validations
      keys = (2..letters.length).flat_map{ |n| letters.combination(n).map(&:join).map{|n| n = n.length.to_s + n.chars.sort.join } }.uniq
      @words = []
      keys.each { |key| @words.push($trie.children(key)) if $trie.has_children?(key) }
    end

end
