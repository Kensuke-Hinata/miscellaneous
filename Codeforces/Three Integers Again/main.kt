package redocpot

fun main(args : Array<String>) {
    val q = readLine()!!.toInt()
    for (i in 1 .. q) {
        val (x, y) = readLine()!!.split(" ").map(String::toInt)
        val a = minOf(x, y) - 1
        val b = x - a
        val c = y - a
        print(a)
        print(" ")
        print(b)
        print(" ")
        print(c)
        println()
    }
}
