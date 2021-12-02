import os

fn main() {
        data := os.read_lines('example.data')?
        mut depth := 0
        mut position := 0
        mut aim := 0

        for index, command in data {

		if command == '' {
                        continue
                }
                
                command_parts := command.split(' ')

                match command_parts[0] {
                        "forward" {
                                position += command_parts[1].int()
                                depth += aim*command_parts[1].int()
                        }
                        "up" {
                                aim -= command_parts[1].int()
                        }
                        "down" {
                                aim += command_parts[1].int()
                        }
                        else {}
                }
        }
        println(depth*position)
}
