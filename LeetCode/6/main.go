package main

import (
	"bufio"
	"fmt"
	"os"
)

func convert(s string, numRows int) string {
	if numRows == 1 {
		return s
	}
	n := len(s)
	res := make([]byte, 0)
	md := (numRows - 1) << 1
	for i := 0; i < n; i += md {
		res = append(res, s[i])
	}
	for i := 1; i < numRows-1; i++ {
		d := i << 1
		for j := i; j < n; j += d {
			res = append(res, s[j])
			d = md - d
		}
	}
	for i := numRows - 1; i < n; i += md {
		res = append(res, s[i])
	}
	return string(res)
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		var rows int
		fmt.Scanf("%d", &rows)
		res := convert(scanner.Text(), rows)
		fmt.Println(res)
	}
}
