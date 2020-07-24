package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
	"unicode"
)

func myAtoi(s string) int {
	s = strings.Trim(s, " \t\n")
	n := len(s)
	if n == 0 {
		return 0
	}
	if !unicode.IsDigit(rune(s[0])) && s[0] != '+' && s[0] != '-' {
		return 0
	}
	dot := false
	var bound int
	for bound = 1; bound < n; bound++ {
		if !unicode.IsDigit(rune(s[bound])) && s[bound] != '.' ||
			s[bound] == '.' && dot {
			break
		}
		if s[bound] == '.' {
			dot = true
		}
	}
	num, _ := strconv.ParseFloat(s[0:bound], 64)
	if num < math.MinInt32 {
		return math.MinInt32
	}
	if num > math.MaxInt32 {
		return math.MaxInt32
	}
	return int(num)
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		res := myAtoi(scanner.Text())
		fmt.Println(res)
	}
}
