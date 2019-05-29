package redocpot

import java.util.ArrayList

class Range(id : Int, left : Int, right : Int) {
    var id : Int
    var left : Int
    var right : Int

    init {
        this.id = id
        this.left = left
        this.right = right
    }
}

fun main(args : Array<String>) {
    val T = readLine()!!.toInt()
    for (i in 1 .. T) {
        val n = readLine()!!.toInt()
        var rs = ArrayList<Range>()
        for (j in 0 .. n - 1) {
            val (left, right) = readLine()!!.split(" ").map(String::toInt)
            rs.add(Range(j, left, right))
        }
        rs = ArrayList<Range>(rs.sortedWith(compareBy({ it.left }, { it.right })))
        val group = IntArray(n)
        var rightmost = rs[0].right
        var ok = false
        for (j in 0 .. n - 1) {
            if (!ok && rs[j].left <= rightmost) {
                rightmost = maxOf(rightmost, rs[j].right)
                group[rs[j].id] = 1
            } else {
                ok = true
                group[rs[j].id] = 2
            }
        }
        if (!ok) {
            println(-1)
        } else {
            for (j in 0 .. n - 2) {
                print(group[j])
                print(" ")
            }
            println(group[n - 1])
        }
    }
}
