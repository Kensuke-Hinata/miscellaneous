package main

import (
	"fmt"
	"sort"
)

func swap(a []int, i int, j int) {
	a[i] ^= a[j]
	a[j] ^= a[i]
	a[i] ^= a[j]
}

func nextPermutation(a []int) {
	n := len(a)
	for i := n - 2; i >= 0; i-- {
		if a[i] < a[i+1] {
			pos := -1
			left, right := i+1, n-1
			for left <= right {
				mid := (left + right) >> 1
				if a[mid] <= a[i] {
					right = mid - 1
				} else {
					left = mid + 1
					pos = mid
				}
			}
			swap(a, pos, i)
			left, right = i+1, n-1
			for left < right {
				swap(a, left, right)
				left++
				right--
			}
			return
		}
	}
	sort.Ints(a)
}

func main() {
	var n int
	fmt.Scanf("%d", &n)
	a := make([]int, n)
	for i := 0; i < n; i++ {
		fmt.Scanf("%d", &a[i])
	}
	nextPermutation(a)
	for i := 0; i < n; i++ {
		fmt.Print(a[i], " ")
	}
	fmt.Println()
}
