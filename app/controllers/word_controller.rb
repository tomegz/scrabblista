require 'trie'
class WordController < ApplicationController

    @@trie = Trie.read("tries/p_trie")
    
    def home
    end

    def search
      validate_input
      @rack = Tile.new(params[:q])
      @scrabble = Scrabble.new(@@trie, @rack)
      @words = @scrabble.find_words
    end

    private
    def validate_input # TRY flash.now
      if params[:q].size < 2 || params[:q].scan(letters_and_blanks).any? || params[:q].count("?") > 2
        flash[:notice] = "Potrzebujesz co najmniej dwóch liter, aby ułożyć słowo." if params[:q].size < 2 
        flash[:notice] = "Używaj tylko liter, lub '?' dla blanków." if params[:q].scan(letters_and_blanks).any? 
        flash[:notice] = "Możesz użyć co najwyżej dwóch '?' - blanków." if params[:q].chars.count("?") > 2
        render 'home'
      end
    end

    def letters_and_blanks
      /[^a-pA-Pr-uR-U?wyzWYZóąćęłńśźż_]/
    end
    
end
#<%= form_tag("/search", method: "get") do %>
  #<%= label_tag(:q, "My rack:") %>
  #<%= text_field_tag 'q', nil, maxlength: 12 %>
  #<%= submit_tag("Create words from my letters") %>
#<% end %>
