from typing import Tuple
import clingo
import sys

class Sudoku:
    def __init__(self, sudoku: dict[Tuple[int, int], int]):
        self.sudoku = sudoku

    def __str__(self) -> str:
        s = ""
        # YOUR CODE HERE
        return s

    @classmethod
    def from_str(cls, s: str) -> "Sudoku":
        sudoku = {}
        # YOUR CODE HERE
        return cls(sudoku)

    @classmethod
    def from_model(cls, model: clingo.solving.Model) -> "Sudoku":
        sudoku = {}
        # YOUR CODE HERE
        return cls(sudoku)

class ClingoApp(clingo.application.Application):
    def print_model(self, model, printer) -> None:
        symbols = sorted(model.symbols(shown=True))
        print(" ".join(str(s) for s in symbols))
        sys.stdout.flush()
             
    def main(self, ctl, files):
        for f in files:
            ctl.load(f)
        if not files:
            ctl.load("-")
        
        ctl.load('sudoku.lp')
        ctl.ground()
        ctl.solve()

if __name__ == "__main__":
    clingo.application.clingo_main(ClingoApp())
