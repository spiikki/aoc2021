import os

struct BingoField {
mut:
    number string
    marked bool
}

struct BingoGrid {
mut:
    grid [5][5]BingoField
}

fn (mut grid BingoGrid) mark_number(number string) {
    for mut row in grid.grid {
        for mut element in row {
            if element.number == number {
                element.marked = true
            }
        }
    }
}

fn (mut grid BingoGrid) count_winning_lines() bool{
    mut horizontal := 0
    mut vertical := 0
    mut count := 0
    mut count_vertical := []int{len:5, init: 0}
    for mut row in grid.grid {
        count = 0
        for index, mut element in row {
            if element.marked {
                count++
                count_vertical[index]++
            }
        }
        if count == 5 {
            horizontal++
            return true
        }
    }

    for verticals in count_vertical {
        if verticals == 5 {
            vertical++
            return true
        }
    }

    return false
}

fn (grid BingoGrid) count_unmarked_sum() int{
    mut sum := 0
    for row in grid.grid {
        for element in row {
            if !element.marked {
                sum += element.number.int()
            }
        }
    }

    return sum
}

fn main() {
    data := os.read_lines(os.args[1])?

    numbers := data[0].split(',')

    mut bingo_grids := []BingoGrid{}
    mut bingo_row_index := 0

    mut new_grid := BingoGrid{}

    for index, row in data {
        if index < 2 { continue }
        if row == '' { continue }

        grid_row := row.split(' ').filter(it != '')
        for row_index, value in grid_row {
            new_grid.grid[bingo_row_index][row_index].number = value
        }
        bingo_row_index += 1

        if bingo_row_index == 5 {
            bingo_grids << new_grid
            bingo_row_index = 0
        }
    }
    
    mut winners := []int{}
    for index, number in numbers {
        winners.clear()
        println("round $index: ")

        for grid_index, mut grid in bingo_grids {
            grid.mark_number(number)
            if grid.count_winning_lines() {
                println("winner in grid $grid_index")
                winners << grid_index
            }
        }

        println(bingo_grids.len)

        if bingo_grids.len == 1 {
            if winners.len == 1 {
                println(bingo_grids[0].count_unmarked_sum())
                println(number.int())

                println(bingo_grids[0].count_unmarked_sum()*number.int())
                return
            }
        } else {
            winners.sort(a > b)
            for id in winners {
                println("deleting id $id")
                bingo_grids.delete(id)
            }
        }

    }
}