package redocpot

fun main(args : Array<String>) {
    val n = readLine()!!.toInt()
    val s = readLine()!!
    if (n == 1) {
        println("yes")
        return
    }
    val c = IntArray(26)
    for (i in 0 .. n - 1) {
        val idx = s[i] - 'a'
        ++ c[idx]
        if (c[idx] > 1) {
            println("yes")
            return
        }
    }
    println("no")
}
