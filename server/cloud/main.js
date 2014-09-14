function appDowToJs (dow) {
  var jsDow = dow + 1;
  if (jsDow > 6) {
    jsDow = 0;
  }
  return jsDow;
  console.log("Converted app", dow, "to", jsDow);
}

function getNextMatchDate(group) {
  var currDate = new Date();
  var matchDate = new Date();
  var currDay = currDate.getDay();

  console.log("DayOfWeek from Group: " + group.get('day_of_week'));
  var neededDay = appDowToJs(group.get('day_of_week'));

  matchDate.setDate(matchDate.getDate() + Math.abs(neededDay - currDay));
  matchDate.setHours(group.get('hour'));
  matchDate.setMinutes(group.get('minutes'));

  return matchDate;
}


Parse.Cloud.beforeSave("PlayerGroup", function(request, response) {
  var Match = Parse.Object.extend("Match");
  var match = new Match();
  var group = request.object;

  var requiredPlayers = group.get("required_players_amount") || 10;
  console.log("Setting required players to match " + requiredPlayers);
  match.set("required_players_amount", requiredPlayers);

  var nextMatchDate = getNextMatchDate(group);
  console.log("Setting next match date: " + nextMatchDate);
  match.set("date", nextMatchDate);

  match.save(null, {
    success: function(newMatch) {
      console.log("Got new match " + newMatch.id);
      group.set("current_match_id", newMatch.id);
      response.success();
    },
    error: function(err) {
      response.error("Cannot save player group", err);
    }
  });
});
