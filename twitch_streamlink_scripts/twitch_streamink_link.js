// ==UserScript==
// @name         Twitch Video Links with Custom Protocol Handler
// @namespace    twitch-video-links-custom-protocol-handler
// @version      1
// @description  Adds a streamlink custom protocol link after videos on Twitch 
// @match        https://*.twitch.tv/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Wait 4 seconds for the page to load because the video links are loaded asynchronously
    setTimeout( () => {
        
        // Get all video links on the page
        const videoLinks = document.querySelectorAll('a[data-a-target="preview-card-image-link"]');

        // Loop through the video links and add a star next to each one
        videoLinks.forEach(link => {
            // Create a custom protocol URL with the streamer name as the last part of the URL
            const streamerName = link.href.split('/')[3];
            const customProtocolUrl = `myprotocol://${streamerName}`;

            // Create a hyperlink for the custom protocol URL
            const customProtocolLink = document.createElement('a');
            customProtocolLink.href = customProtocolUrl;
            customProtocolLink.innerHTML = '&#9733;';
            link.parentNode.insertBefore(customProtocolLink, link.nextSibling);
        });

    }, 4000);

})();