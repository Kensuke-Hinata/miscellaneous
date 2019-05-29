package redocpot

fun main(args : Array<String>) {
    var (x, y, z) = readLine()!!.split(" ").map(String::toInt)
    var (a, b, c) = readLine()!!.split(" ").map(String::toInt)
    if (a < x) {
        println("NO")
        return
    }
    a -= x
    z = maxOf(z - c, 0)
    if (a + b < y + z) {
        println("NO")
    } else {
        println("YES")
    }
}
