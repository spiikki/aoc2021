import os
import arrays

// solution part 1
fn cost(crab int, target int) int{
	mut steps := target-crab
	if steps < 0 {
		steps *= -1
	}
	return steps
}

// solution part2
fn cost_incremental(crab int, target int) int{
	mut steps := target-crab
	if steps < 0 {
		steps *= -1
	}

	mut cost := 0
	for step in 0 .. steps {
		cost += step+1
	}

	return cost
}

fn main() {
    data := os.read_lines(os.args[1])?
	mut positions := []int{}
	for mut crab in data[0].split(',') {
		positions << crab.int()
	}
	println(positions)
	max_position := arrays.max(positions)?

	println(max_position)
	mut costs := []int{}

	for position in 1 .. max_position {
		println("to position $position: ")
		mut sum := 0
		for crab in positions {
			print("crab $crab: ")
			// cost := cost(crab, position) // solution 1
			cost := cost_incremental(crab, position) // solution 2
			sum+=cost
			println(cost)
		}

		costs << sum
	} 

	println(arrays.min(costs)?)
}