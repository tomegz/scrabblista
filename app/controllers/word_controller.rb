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
      @words.flatten!.map!{ |w| key_to_word(w) } unless @words.empty?
    end
    
    # private methods

    private
    def key_to_word(key)
      a = key.length
      key[a/2+1..a-1]
    end

end
