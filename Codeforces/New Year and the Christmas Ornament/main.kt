package redocpot

fun main(args : Array<String>) {
    val (y, b, r) = readLine()!!.split(' ').map(String::toInt)
    var ans : Int
    if (b < r) {
        ans = b - 1
    } else {
        ans = r - 2
    }
    ans = minOf(ans, y)
    ans = ans * 3 + 3
    println(ans)
}
