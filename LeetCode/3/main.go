package main

import (
	"bufio"
	"fmt"
	"os"
)

func lengthOfLongestSubstring(s string) int {
	L := len(s)
	left := 0
	ans := 0
	var pos [128]int
	for i := range pos {
		pos[i] = -1
	}
	for right := 0; right < L; right++ {
		idx := int(s[right])
		if pos[idx] >= left {
			left = pos[idx] + 1
		} else {
			if right-left+1 > ans {
				ans = right - left + 1
			}
		}
		pos[idx] = right
	}
	return ans
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		res := lengthOfLongestSubstring(scanner.Text())
		fmt.Println(res)
	}
}
