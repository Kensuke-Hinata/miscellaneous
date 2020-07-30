package main

import (
	"fmt"
	"sort"
	"strings"
)

type pair struct {
	fst int
	snd int
}

func fourSum(a []int, t int) [][]int {
	m := make(map[int][]pair)
	for i := 0; i < len(a); i++ {
		for j := i + 1; j < len(a); j++ {
			s := a[i] + a[j]
			L, exist := m[s]
			if !exist {
				L = make([]pair, 0)
			}
			m[s] = append(L, pair{fst: i, snd: j})
		}
	}
	for _, v := range m {
		sort.Slice(v, func(i, j int) bool {
			if v[i].fst < v[j].fst {
				return true
			}
			if v[i].fst == v[j].fst && v[i].snd < v[j].snd {
				return true
			}
			return false
		})
	}
	res := make([][]int, 0)
	s := make(map[string]bool, 0)
	for i := 0; i < len(a); i++ {
		for j := i + 1; j < len(a); j++ {
			val := t - a[i] - a[j]
			L, exist := m[val]
			if exist {
				pos := len(L)
				left, right := 0, len(L)-1
				for left <= right {
					mid := (left + right) >> 1
					if L[mid].fst <= j {
						left = mid + 1
					} else {
						pos = mid
						right = mid - 1
					}
				}
				for ; pos < len(L); pos++ {
					item := []int{a[i], a[j], a[L[pos].fst], a[L[pos].snd]}
					sort.Ints(item)
					str := strings.Join(strings.Split(fmt.Sprint(item), " "), ",")
					_, exist := s[str]
					if !exist {
						s[str] = true
						res = append(res, item)
					}
				}
			}
		}
	}
	return res
}

func main() {
	var n int
	fmt.Scanf("%d", &n)
	a := make([]int, n)
	for i := 0; i < n; i++ {
		fmt.Scanf("%d", &a[i])
	}
	var t int
	fmt.Scanf("%d", &t)
	res := fourSum(a, t)
	fmt.Println(res)
}
