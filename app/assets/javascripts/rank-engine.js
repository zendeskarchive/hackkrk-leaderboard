$(document).ready(function() {
  if (window.location.pathname != '/rankings' &&
      window.location.pathname != '/') return;
  refreshStandings();
  setInterval( function() {
    refreshStandings();
  }, 30000);
});

function refreshStandings() {
    var rankingTable = $('#standings');
    clearStandings(rankingTable);
    updateStandings(rankingTable);
};

function clearStandings(rankingBody) {
  rankingBody.find('tr.entry').remove();
};

function addContestantEntry(target, standing, contestant) {
  var rowClass = '';
  if (standing == 1)
    rowClass += 'first';
  if (standing == 2)
    rowClass += 'second';
  if (standing == 3)
    rowClass += 'third';
  var source = $("#score-template").html();
  var template = Handlebars.compile(source);
  var context = { standing: standing, rowClass: rowClass, name: contestant.name, score: contestant.score }
  var newRow = $(template(context));
  // target.append(newRow);
  return '<tr class="entry '+rowClass+'">' + newRow.html() + '</tr>'
};

function getStandingsSheet() {
  return $.parseJSON(responseJSON);
}

function updateStandings(rankingBody) {
  var scoreSheet = [];
  var html = "<table class='table-bordered table-striped' id='standings'><tr class='header'><th class='rank'></th><th class='name'>Name</th><th class='count'>Score</th></tr>"
  $.getJSON( '/api/rankings.json', function(response) {
    scoreSheet = response;
    for(var position in scoreSheet) {
      var contestant = scoreSheet[position];
      var standing = parseInt(position) + 1;
      html += addContestantEntry(rankingBody, standing, contestant);
    }
    html += '</table>'
    $('#ranking').html(html)
    revealStandings();
  })

};

function revealStandings(rankingBody) {
  $('#ranking tr.entry').each(function(index, element) {
    setTimeout(function() { $(this).show('slow'); }, 100*index)
  })
}

