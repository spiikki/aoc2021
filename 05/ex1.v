import os
import math

struct Point {
	x int
	y int
}

struct Line {
	start Point
	end Point
}

fn main() {
    data := os.read_lines(os.args[1])?

	mut lines := []Line{}
	mut high_x := 0
	mut high_y := 0

	for index, row in data {
		line := row.split(' -> ')
		start := line[0].split(',')
		end := line[1].split(',')
		if start[0].int() == end[0].int() {
			new_line := Line{start: Point{x: start[0].int(), y: start[1].int()}, 
						end: Point{ x: end[0].int(), y: end[1].int()}
					}
			lines << new_line

			if start[0].int() > high_x {
				high_x = start[0].int()
			}
			if end[0].int() > high_x {
				high_x = end[0].int()
			}

			if start[1].int() > high_y {
				high_y = start[1].int()
			}
			if end[1].int() > high_y {
				high_y = end[1].int()
			}
			println("line $index is horizontal")
		} else if start[1].int() == end[1].int() {
			new_line := Line{start: Point{x: start[0].int(), y: start[1].int()}, 
						end: Point{ x: end[0].int(), y: end[1].int()}
					}
			lines << new_line
			if start[0].int() > high_x {
				high_x = start[0].int()
			}
			if end[0].int() > high_x {
				high_x = end[0].int()
			}

			if start[1].int() > high_y {
				high_y = start[1].int()
			}
			if end[1].int() > high_y {
				high_y = end[1].int()
			}

			println("line $index is vertical")
		}
	}

	println(lines.len)
	println("high x: $high_x and high y: $high_y")

	mut grid := [][]int{len: high_y+1, init: []int{len: high_x+1, init: 0}}

	for line in lines {
		x_delta := line.end.x - line.start.x
		y_delta := line.end.y - line.start.y

		mut steps := 0
		if math.abs(x_delta) > math.abs(y_delta) {
			steps = x_delta
		} else {
			steps = y_delta
		}

		if steps < 0 {
			steps = -steps
		}
		x_increment := x_delta / steps
		y_increment := y_delta / steps

		println("deltas x: $x_delta, y: $y_delta, steps: $steps")
		println("increments x: $x_increment, y: $y_increment")

		for step in 0 .. steps+1 {
			grid[line.start.y+(y_increment*step)][line.start.x+(x_increment*step)] += 1
		}
	}

	println(grid)

	mut count := 0
	for row in grid {
		for element in row {
			if element > 1 {
				count++
			}
		}
	}
	println(count)
}