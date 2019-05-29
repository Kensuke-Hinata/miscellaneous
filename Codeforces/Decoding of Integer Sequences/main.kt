package redocpot

import java.util.ArrayList

fun main(args : Array<String>) {
    val m = readLine()!!.toInt()
    val a = readLine()!!.split(" ").map(String::toInt)
    var cnt = 0
    for (item in a) {
        if (item == -1) {
            ++ cnt
        }
    }
    val arr = Array(cnt){ArrayList<Int>()}
    val next = IntArray(cnt)
    val prev = IntArray(cnt)
    for (i in 0 .. cnt - 1) {
        next[i] = i + 1
        prev[i] = i - 1
    }
    next[cnt - 1] = 0
    prev[0] = cnt - 1
    var idx = 0
    for (i in 0 .. m - 1) {
        if (a[i] == -1) {
            val nxt = next[idx]
            if (prev[idx] != -1) {
                next[prev[idx]] = next[idx]
            }
            if (next[idx] != cnt) {
                prev[next[idx]] = prev[idx]
            }
            idx = nxt
        } else {
            arr[idx].add(a[i])
            idx = next[idx]
        }
    }
    println(cnt)
    for (i in 0 .. cnt - 1) {
        val n = arr[i].size
        print(n)
        if (n > 0) {
            print(" ")
            print(arr[i].joinToString(" "))
        }
        println()
    }
}
