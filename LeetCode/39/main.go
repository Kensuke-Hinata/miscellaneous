package main

import (
	"fmt"
	"sort"
)

func search(idx int, s int, a []int, c []int, t int) [][]int {
	if s == t {
		item := make([]int, len(a))
		copy(item, a)
		return [][]int{item}
	}
	if idx == len(c) || s+c[idx] > t {
		return nil
	}
	res := make([][]int, 0)
	a = append(a, c[idx])
	ret := search(idx, s+c[idx], a, c, t)
	a = a[:len(a)-1]
	if ret != nil {
		res = append(res, ret...)
	}
	ret = search(idx+1, s, a, c, t)
	if ret != nil {
		res = append(res, ret...)
	}
	return res
}

func combinationSum(c []int, t int) [][]int {
	sort.Ints(c)
	return search(0, 0, []int{}, c, t)
}

func main() {
	var n int
	fmt.Scanf("%d", &n)
	c := make([]int, n)
	for i := 0; i < n; i++ {
		fmt.Scanf("%d", &c[i])
	}
	var t int
	fmt.Scanf("%d", &t)
	res := combinationSum(c, t)
	fmt.Println(res)
}
