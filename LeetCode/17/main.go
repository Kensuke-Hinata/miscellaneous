package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func recur(cur string, idx int, digits []int, m map[int]string) []string {
	if idx == len(digits) {
		return []string{cur}
	}
	res := []string{}
	s := m[digits[idx]]
	for i := 0; i < len(s); i++ {
		ret := recur(cur+string(s[i]), idx+1, digits, m)
		res = append(res, ret...)
	}
	return res
}

func letterCombinations(digits string) []string {
	if digits == "" {
		return []string{}
	}
	m := make(map[int]string)
	pos := 0
	for i := 2; i < 10; i++ {
		n := 3
		if i == 7 || i == 9 {
			n = 4
		}
		s := ""
		for j := 0; j < n; j++ {
			s += string('a' + pos)
			pos++
		}
		m[i] = s
	}
	d := make([]int, len(digits))
	for i := 0; i < len(digits); i++ {
		num, _ := strconv.Atoi(string(digits[i]))
		d[i] = num
	}
	return recur("", 0, d, m)
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		res := letterCombinations(scanner.Text())
		fmt.Println(res)
	}
}
