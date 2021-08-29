$(function () {
    var columns = 16;
    var rows = 16;
    var maxCellSize = 16;
    var minCellSize = 2;
    var boardWidth = columns * maxCellSize * 2;
    var boardHeight = rows * maxCellSize * 2;
    $("#dotmatrix").attr({
        width: boardWidth,
        height: boardHeight
    });
    var state1 = [
        [0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 1, 1],
        [0, 0.5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 1, 1, 1],
        [0.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 1, 1, 1, 0.5],
        [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0.5, 1, 1, 1, 0.5, 0],
        [1, 1, 1, 0, 0, 0, 0, 0, 0, 0.5, 1, 1, 1, 0.5, 0, 0],
        [1, 1, 1, 0, 0, 0, 0, 0, 0.5, 1, 1, 1, 0.5, 0, 0, 0],
        [1, 1, 1, 0, 0, 0, 0, 0.5, 1, 1, 1, 0.5, 0, 0, 0, 0],
        [1, 1, 1, 0, 0, 0, 0.5, 1, 1, 1, 0.5, 0, 0, 0, 0, 0],
        [1, 1, 1, 0, 0, 0.5, 1, 1, 1, 0.5, 0, 0, 0, 0, 0, 0],
        [1, 1, 0.5, 0, 0.5, 1, 1, 1, 0.5, 0, 0.5, 0.5, 0, 0, 0, 0],
        [1, 0.5, 0, 0.5, 1, 1, 1, 0.5, 0, 0.5, 1, 1, 0.5, 0, 0, 0],
        [0.5, 0, 0.5, 1, 1, 1, 0.5, 0, 0, 0.5, 1, 1, 1, 0.5, 0, 0],
        [0, 0.5, 1, 1, 1, 0.5, 0, 0, 0, 0, 0.5, 1, 1, 1, 0.5, 0],
        [0.5, 1, 1, 1, 0.5, 0, 0, 0, 0, 0, 0, 0.5, 1, 1, 1, 0.5],
        [1, 1, 1, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 1, 1, 1],
        [1, 1, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 1, 1]
    ];
    for (var x = 0; x < columns; x++) {
        for (var y = 0; y < rows; y++) {
            var xIndex = x.toString().padStart(columns.toString().length, "0");
            var yIndex = y.toString().padStart(rows.toString().length, "0");
            var id = "dotmatrix-index-" + xIndex + yIndex;
            var delay = x + y;
            var thisClass = "dotmatrix-dot dotmatrix-delay-" + delay;
            var newDot = $(document.createElementNS("http://www.w3.org/2000/svg", "circle")).attr({
                id: id,
                "class": thisClass,
                cx: (2 * x + 1) * maxCellSize,
                cy: (2 * y + 1) * maxCellSize,
                r: maxCellSize,
                fill: "black"
            });
            $("#dotmatrix").append(newDot);
        }
    }
    function undulateBoard(amplitude, duration) {
    }
});
