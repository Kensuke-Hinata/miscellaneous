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
	n := len(c)
	if idx == n || s+c[idx] > t {
		return nil
	}
	var i int
	var nidx int
	for nidx = idx + 1; nidx < n && c[nidx] == c[idx]; nidx++ {
	}
	res := make([][]int, 0)
	for i = 1; i <= nidx-idx && s+i*c[idx] <= t; i++ {
		a = append(a, c[idx])
		ret := search(nidx, s+i*c[idx], a, c, t)
		if ret != nil {
			res = append(res, ret...)
		}
	}
	a = a[:len(a)-(i-1)]
	ret := search(nidx, s, a, c, t)
	if ret != nil {
		res = append(res, ret...)
	}
	return res
}

func combinationSum2(c []int, t int) [][]int {
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
	res := combinationSum2(c, t)
	fmt.Println(res)
}
