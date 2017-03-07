require 'trie'
class WordController < ApplicationController

    @@trie = Trie.read("tries/p_trie")
    
    def home
    end

    def search
      @rack = Tile.new(params[:q])
      validate_input
      @scrabble = Scrabble.new(@@trie, @rack)
      @words = @scrabble.find_words
    end

    private
    def validate_input 
      if params[:q].size < 2 || forbidden_chars.any? || params[:q].count("?") > 2
        flash.now[:notice] = "Potrzebujesz co najmniej dwóch liter, aby ułożyć słowo." if params[:q].size < 2 
        flash.now[:notice] = "Z tych znaków nie ułożysz słowa: #{forbidden_chars.uniq.join(', ')}" if forbidden_chars.any? 
        flash.now[:notice] = "Możesz użyć co najwyżej dwóch '?' - blanków." if params[:q].chars.count("?") > 2
        render 'home'
      end
    end

    def forbidden_chars
      @rack.input.scan(/[^a-pA-Pr-uR-U?wyzWYZóąćęłńśźż_]/)
    end
    
end
