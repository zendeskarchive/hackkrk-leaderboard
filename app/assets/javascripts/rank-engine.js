$(document).ready(function() {
  if (window.location.pathname == '/rankings') return;
  refreshStandings();
  setInterval( function() {
    refreshStandings();
  }, 5000);
});

function refreshStandings() {
    var rankingBody = $('#standings tbody');
    clearStandings(rankingBody);
    updateStandings(rankingBody);
};

function clearStandings(rankingBody) {
  rankingBody.hide('').html('').show();
};

function addContestantEntry(target, standing, contestant) {
  var rowClass = '';
  if (standing == 1)
    rowClass += 'first';
  var source = $("#score-template").html();
  var template = Handlebars.compile(source);
  var context = { standing: standing, rowClass: rowClass, name: contestant.name, score: contestant.score }
  var newRow = $(template(context)).hide();
  target.append(newRow);
};

function getStandingsSheet() {
  return $.parseJSON(responseJSON);
}

function updateStandings(rankingBody) {
  var scoreSheet = [];
  $.getJSON( '/api/rankings.json', function(response) {
    scoreSheet = response;
    for(var position in scoreSheet) {
      var contestant = scoreSheet[position];
      var standing = parseInt(position) + 1;
      addContestantEntry(rankingBody, standing, contestant);
    }
    revealStandings(rankingBody);
  })
};

function revealStandings(rankingBody) {
  $.each(rankingBody.find('tr'), function(index, element) {
    setTimeout(function() { $(element).show('slow'); }, 100*index)
  })
}

