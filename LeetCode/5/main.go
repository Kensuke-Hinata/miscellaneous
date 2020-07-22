package main

import (
	"bufio"
	"fmt"
	"os"
)

func longestPalindrome(s string) string {
	L := len(s)
	if L == 0 {
		return ""
	}
	dp := make([][]bool, L)
	for i := 0; i < L; i++ {
		dp[i] = make([]bool, L)
	}
	left, right := 0, 0
	for i := 0; i < L; i++ {
		dp[i][i] = true
		if i < L-1 {
			dp[i][i+1] = s[i] == s[i+1]
			if dp[i][i+1] {
				left, right = i, i+1
			}
		}
	}
	for j := 3; j <= L; j++ {
		for i := 0; i+j-1 < L; i++ {
			dp[i][i+j-1] = false
			if s[i] == s[i+j-1] && dp[i+1][i+j-2] {
				dp[i][i+j-1] = true
				left, right = i, i+j-1
			}
		}
	}
	return s[left : right+1]
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		res := longestPalindrome(scanner.Text())
		fmt.Println(res)
	}
}
