require('should');

describe('Tetris', function () {
    it("should load without throwing under node", function () {
        var TETRIS = require('../lib/tetris.js');

        TETRIS.should.be.a.Function;
    });

    it("should not crash if called with dummies construction", function () {
        var TETRIS = require('../lib/tetris.js');
        
        var doc = {}, win = {};

        var t = new TETRIS(doc, win);
   
    });
});
