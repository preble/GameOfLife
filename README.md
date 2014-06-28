# Conway's Game of Life in Swift

An implementation of [Conway's Game of Life][gol] as a Swift Cocoa app.
Written by Adam Preble, June 25-27 2014, for Big Nerd Ranch's Swift Book Club.

Demonstrates use of template classes for the `GameBoard` class,
which offer some convenient opportunities for code reuse.
Specifically, see the method `GameOfLife.rewriteBoard()`, which uses
`Bool` and `Int` varieties of `GameBoard`.

Also demonstrates unit testing, and in particular `measureBlock`,
which was instrumental in addressing performance issues with the
original design.

[gol]: http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
