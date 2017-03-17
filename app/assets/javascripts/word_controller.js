$(document).on('turbolinks:load', function(){
  getWords();
  handleSorting();
});

function getWords(){
	$words = $('.word-column')
	$wordsArray = $.map($words, function(value, index){
        return [value];
	});
}

function handleSorting(){
	$('#points').on('click', function(event){
		$(this).toggleClass("active");
		$('#length').removeClass("active");
	    sortByPoints();
        event.preventDefault();
	});
	$('#length').on('click', function(event){
		$(this).toggleClass("active");
		$('#points').removeClass("active");
        sortByLength();
        event.preventDefault();
	});
}

function sortByPoints(){
    var $sortedWords = $wordsArray.sort(function(a, b){
        var c = parseInt(a.getElementsByClassName("points")[0].textContent.match(/\d+/).join());
        var d = parseInt(b.getElementsByClassName("points")[0].textContent.match(/\d+/).join());
        return d - c;
    });
    appendWords($sortedWords);
}

function sortByLength(){
    var $sortedWords = $wordsArray.sort(function(a, b){
        var c = a.getElementsByClassName("content")[0].textContent.length;
        var d = b.getElementsByClassName("content")[0].textContent.length;
        return d - c;
    });
    appendWords($sortedWords);
}

function appendWords(words){
	$('.sortable .container').append(words);
}