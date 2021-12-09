import os

fn main() {
    data := os.read_lines(os.args[1])?

	mut cave := [][]int{}

	for row in data {
		mut line := []int{}
		for point in row {
			line << point.ascii_str().int()
		}
		cave << line
	}
	println(cave)

	mut sum_of_risk := 0

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
			sum_of_risk += point+1
		}
	}

	println(sum_of_risk)
}