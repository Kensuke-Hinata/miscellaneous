package main

import (
	"bufio"
	"fmt"
	"os"
)

func memset(f []bool, val bool) {
	n := len(f)
	for i := 0; i < n; i++ {
		f[i] = val
	}
}

func isValidSudoku(b [][]byte) bool {
	if len(b) != 9 {
		return false
	}
	for i := 0; i < 9; i++ {
		if len(b[i]) != 9 {
			return false
		}
	}
	f := make([]bool, 10)
	for i := 0; i < 9; i++ {
		memset(f, false)
		for j := 0; j < 9; j++ {
			if b[i][j] != '.' {
				if f[b[i][j]-'0'] {
					return false
				}
				f[b[i][j]-'0'] = true
			}
		}
		memset(f, false)
		for j := 0; j < 9; j++ {
			if b[j][i] != '.' {
				if f[b[j][i]-'0'] {
					return false
				}
				f[b[j][i]-'0'] = true
			}
		}
	}
	for i := 0; i < 9; i += 3 {
		for j := 0; j < 9; j += 3 {
			memset(f, false)
			for di := 0; di < 3; di++ {
				for dj := 0; dj < 3; dj++ {
					if b[i+di][j+dj] != '.' {
						if f[b[i+di][j+dj]-'0'] {
							return false
						}
						f[b[i+di][j+dj]-'0'] = true
					}
				}
			}
		}
	}
	return true
}

func main() {
	b := make([][]byte, 0)
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		b = append(b, []byte(scanner.Text()))
	}
	res := isValidSudoku(b)
	fmt.Println(res)
}
