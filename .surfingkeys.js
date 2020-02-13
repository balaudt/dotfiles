map('H', 'S'); //History back
map('L', 'D'); //History forward
map('gt', 'R'); //Tab left
map('gT', 'E'); //Tab right
map('p', 'cc'); //Open url in clipboard
map('J', 'E'); //Tab left
map('K', 'R'); //Tab right
map('F', 'af'); //Open link in new tab
map('ai', 'oi'); //Open incognito window
map('ax', 'ox'); //Open recently closed
map('ah', 'oh'); //Open from history
map('am', 'om'); //Open from quickmarks
map('ag', 'og'); //Open with Google
map('an', 'on'); //Open chrome new tab
map('o', 'go'); //Open url using omnibar in current tab
map('O', 'su'); //Edit current url
settings.focusFirstCandidate = true; //Autoselect first result in ominbar
settings.blacklistPattern = /.*mail.google.com.*|.*keep.google.com.*|.*calendar.google.com.*|.*drive.google.com.*|.*docs.google.com.*|.*jira.ouroath.com.*|.*jira.vzbuilders.com.*/i;
Hints.characters = 'asdfghlkjwerqtoiupyzxcvmnb';

/*
var rmSearchAliases =
    {
        "s": ["g", "d", "b"
            , "w", "s", "h"]
    };
Object.keys(rmSearchAliases).forEach(function (k) {
    rmSearchAliases[k].forEach(function (v) {
        removeSearchAliasX(v, k);
    });
});*/

function incrLastNumInUrl(incr) {
    return function () {
        var numMatches = window.location.href.match(/\d+/g);
        var x = numMatches[numMatches.length - 1];
        var loc = window.location.href;
        var y = loc.lastIndexOf(x);
        var z = loc.substring(0, y) + (parseInt(x) + incr) + loc.substring(y + x.length);
        window.location.href = z;
    };
}

mapkey('<Ctrl-a>', '#Increment number found in url', incrLastNumInUrl(1));
mapkey('<Ctrl-x>', '#Decrement number found in url', incrLastNumInUrl(-1));

var jenkinsBuildResults = {
    "185823-v3-test_qa_main": "functional_tests"
}
