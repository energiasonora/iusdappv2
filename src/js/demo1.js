/**
 * main.js
 * http://www.codrops.com
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2016, Codrops
 * http://www.codrops.com
 */
;(function(window) {

	'use strict';

	var openCtrl = document.getElementById('btn-search'),
		closeCtrl = document.getElementById('btn-search-close'),
		searchContainer = document.querySelector('.search'),
		inputSearch = searchContainer.querySelector('.search__input'),
		lastFocusedElement;

	function init() {
		initEvents();	
	}

	function initEvents() {
		openCtrl.addEventListener('click', openChat);
		closeCtrl.addEventListener('click', closeSearch);
		document.addEventListener('keyup', function(ev) {
			// escape key.
			if( ev.keyCode == 27 ) {
				closeSearch();
			}
		});
	}

	function openChat() {
		lastFocusedElement = document.activeElement;
		searchContainer.classList.add('search--open');
		inputSearch.focus();
	}
	window.openChat = openChat;

	function closeSearch() {
		searchContainer.classList.remove('search--open');
		inputSearch.blur();
		inputSearch.value = '';
		if (lastFocusedElement) { // restore focus
			lastFocusedElement.focus();
		}
	}
	window.closeSearch = closeSearch;


	init();

})(window);