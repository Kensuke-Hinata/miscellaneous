fun main(args : Array<String>) {
    val T = readLine()!!.toInt()
    for (i in 1 .. T) {
        val X = readLine()!!.toInt()
        var ans = X / 7
        if (X % 7 != 0) {
            ++ ans
        }
        println(ans)
    }
}
