package redocpot

fun main(args : Array<String>) {
    val k = readLine()!!.toInt()
    for (i in 1 .. k) {
        val s = readLine()!!
        val t = readLine()!!
        val sn = s.length
        val tn = t.length
        var p = 0
        var q = 0
        while (p < sn && q < tn) {
            if (s[p] == t[q]) {
                ++ p
                ++ q
                continue
            }
            if (s[p] == '+') {
                break
            }
            if (p == sn - 1 || s[p + 1] != '-') {
                break
            }
            p += 2
            ++ q
        }
        if (p == sn && q == tn) {
            println("YES")
        } else {
            println("NO")
        }
    }
}
