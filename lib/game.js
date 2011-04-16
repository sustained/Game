require(['client/game', 'game/screens/main'], function(Game, SMain) {
  var game;
  game = new Game({
    url: 'http://192.168.0.2/Private/JS/Game/'
  });
  return game.event.on('ready', function() {
    game.screen.add('main', SMain, true);
    game.loop.start();
    return console.log(window.game = game);
  });
});