package main

import "fmt"

type ListNode struct {
	Val  int
	Next *ListNode
}

func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
	var head *ListNode
	var prev *ListNode
	var c int
	for l1 != nil || l2 != nil {
		val := c
		if l1 != nil {
			val += l1.Val
			l1 = l1.Next
		}
		if l2 != nil {
			val += l2.Val
			l2 = l2.Next
		}
		c = val / 10
		val %= 10
		node := new(ListNode)
		node.Val = val
		node.Next = nil
		if head == nil {
			head = node
		} else {
			prev.Next = node
		}
		prev = node
	}
	if c > 0 {
		node := new(ListNode)
		node.Val = c
		node.Next = nil
		prev.Next = node
	}
	return head
}

func input() *ListNode {
	var L int
	fmt.Scanf("%d", &L)
	var head *ListNode
	var prev *ListNode
	for i := 0; i < L; i++ {
		var val int
		fmt.Scanf("%d", &val)
		node := new(ListNode)
		node.Val = val
		node.Next = nil
		if head == nil {
			head = node
		} else {
			prev.Next = node
		}
		prev = node
	}
	return head
}

func output(list *ListNode) {
	for list != nil {
		fmt.Print(list.Val, " ")
		list = list.Next
	}
}

func main() {
	l1 := input()
	l2 := input()
	ret := addTwoNumbers(l1, l2)
	output(ret)
}
