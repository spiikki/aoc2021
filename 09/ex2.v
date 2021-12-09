import os

struct Point {
	x int
	y int
}

fn count_basin_size(cave [][]int, mut visited_map [][]bool, start Point) int{
	//println(start)
	visited_map[start.y][start.x] = true

	mut count := 1

	if start.x < cave[0].len-1 {
		if !visited_map[start.y][start.x+1] {
			if cave[start.y][start.x+1] < 9 {
				if cave[start.y][start.x] < cave[start.y][start.x+1] {
					count += count_basin_size(cave, mut visited_map, Point{x: start.x+1, y: start.y})
				}
			}
		}
	} 

	if start.x > 0 {
		if !visited_map[start.y][start.x-1] {
			if cave[start.y][start.x-1] < 9 {
				if cave[start.y][start.x] < cave[start.y][start.x-1] {
					count += count_basin_size(cave, mut visited_map, Point{x: start.x-1, y: start.y})
				}
			}
		}
	} 

	if start.y < cave.len-1 {
		if !visited_map[start.y+1][start.x] {
			if cave[start.y+1][start.x] < 9 {
				if cave[start.y][start.x] < cave[start.y+1][start.x] {
					count += count_basin_size(cave, mut visited_map, Point{x: start.x, y: start.y+1})
				}
			}
		}
	} 

	if start.y > 0 {
		if !visited_map[start.y-1][start.x] {
			if cave[start.y-1][start.x] < 9 {
				if cave[start.y][start.x] < cave[start.y-1][start.x] {
					count += count_basin_size(cave, mut visited_map, Point{x: start.x, y: start.y-1})
				}
			}
		}
	} 

	return count
}

fn main() {
    data := os.read_lines(os.args[1])?

	mut cave := [][]int{}

	mut low_points := []Point{}

	for row in data {
		mut line := []int{}
		for point in row {
			line << point.ascii_str().int()
		}
		cave << line
	}
	println(cave)

	for y_index, row in cave {
		for x_index, point in row {
			if x_index < row.len-1 {
				if point >= cave[y_index][x_index+1] {
					continue
				}
			} 

			if x_index > 0 {
				if point >= cave[y_index][x_index-1] {
					continue
				}
			}

			if y_index > 0 {
				if point >= cave[y_index-1][x_index] {
					continue
				}
			}

			if y_index < cave.len-1 {
				if point >= cave[y_index+1][x_index] {
					continue
				}
			}

			println("found low point! $point")
			low_points << Point{x: x_index, y: y_index}
		}
	}

	println(low_points)

	mut visited_map := [][]bool{len: cave.len, init: []bool{len: cave[0].len}}

	mut basins := []int{}

	for index, point in low_points {
		basin_size := count_basin_size(cave, mut visited_map, point)
		basins << basin_size
		println("$index point: $basin_size")
	}

	basins.sort( a > b )
	println(basins[0]*basins[1]*basins[2])

}