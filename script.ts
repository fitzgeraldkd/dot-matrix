$(function() {
    const columns: number = 16;
    const rows: number = 16;
    const maxCellSize: number = 16;
    const minCellSize: number = 2;
    const boardWidth: number = columns * maxCellSize * 2;
    const boardHeight: number = rows * maxCellSize * 2;

    $("#dotmatrix").attr({
        width: boardWidth,
        height: boardHeight
    });

    const state1: number[][] = [
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

    for (let x = 0; x < columns; x++) {
        for (let y = 0; y < rows; y++) {
            const xIndex = x.toString().padStart(columns.toString().length, "0");
            const yIndex = y.toString().padStart(rows.toString().length, "0");
            const id = `dotmatrix-index-${xIndex}${yIndex}`;
            const delay = x + y;
            const thisClass = `dotmatrix-dot dotmatrix-delay-${delay}`;
            const newDot = $(document.createElementNS("http://www.w3.org/2000/svg", "circle")).attr({
                id: id,
                class: thisClass,
                cx: (2 * x + 1) * maxCellSize,
                cy: (2 * y + 1) * maxCellSize,
                r: maxCellSize,
                fill: "black"
            });
            $("#dotmatrix").append(newDot);
        }
    }

    function undulateBoard(amplitude: number, duration: number) {

    }
});