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

function createNextMatch(group) {
  var Match = Parse.Object.extend("Match");
  var match = new Match();
  var requiredPlayers = group.get("required_players_amount") || 10;
  console.log("Setting required players to match " + requiredPlayers);
  match.set("required_players_amount", requiredPlayers);

  match.set("player_group_id", group.id);

  var nextMatchDate = getNextMatchDate(group);
  console.log("Setting next match date: " + nextMatchDate);
  match.set("date", nextMatchDate);

  return match;
}

function shouldChangeMatch(currentMatch) {
  var today = new Date();
  var groupDate = currentMatch.get("date");

  return today.valueOf() > groupDate.valueOf();
}

Parse.Cloud.job("matchCreation", function(request, status) {
  // Set up to modify user data
  Parse.Cloud.useMasterKey();

  var query = new Parse.Query("PlayerGroup");
  query.each(function(group) {
    console.log("Group is " + group);
    var matchPromise = new Parse.Query("Match").get(group.get("current_match_id"));
    return Parse.Promise.when([Parse.Promise.as(group), matchPromise])
      .then(function(group, currentMatch) {
        var newMatchPromise = Parse.Promise.as(null);
        if (shouldChangeMatch(currentMatch)) {
          var newMatchPromise = createNextMatch(group).save();
        }
        return Parse.Promise.when(Parse.Promise.as(group), newMatchPromise);
      })
      .then(function(group, newMatch) {
        if (newMatch) {
          group.set("current_match_id", newMatch.id);
          return group.save()
        } else {
          return Parse.Promise.as(null);
        }
      });
  })
  .then(function() {
    status.success("New Match created successfully")
  }, function(error) {
    status.error("Error creating match", error);
  });
});

Parse.Cloud.beforeSave("PlayerGroup", function(request, response) {

  var group = request.object;

  var match = createNextMatch(group);

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
