class WordController < ApplicationController
    require 'trie'
    $trie ||= Trie.read("word_trie")
    $all_letters = %w[a ą b c ć d e ę f g h i j k l ł m n ń o ó p r s ś t u w y z ź ż]

    def home
    end

    def search
      letters = params[:q].gsub(/\s+/, "").chars.sort # needs validations
      keys = (2..letters.length).flat_map{ |n| letters.combination(n).map(&:join).map{|n| n = n.length.to_s + n.chars.sort.join } }.uniq
      keys_with_blanks = keys.select{ |k| k.include? "?" }.map{ |k| k.gsub("?","") }
      final_keys = keys_with_blanks.map do |k| 
              k = $all_letters.map{ |l| l.gsub(l,l+k) }
             end.flatten.map{ |k| k.chars.sort.join }.uniq
      @words = []
      keys.each { |key| @words.push($trie.children(key)) if $trie.has_children?(key) }
      final_keys.each { |key| @words.push($trie.children(key)) if $trie.has_children?(key) }
      @words.flatten!.map!{ |w| key_to_word(w) } unless @words.empty?
    end
    
    # private methods

    private
    def key_to_word(key)
      a = key.length
      key[a/2+1..a-1]
    end

end
