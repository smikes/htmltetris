require('should');

describe('Tetris', function () {
    it("should load without throwing under node", function () {
        var TETRIS = require('../lib/tetris.js');

        (TETRIS).should.be.a.Function;
    });
});
