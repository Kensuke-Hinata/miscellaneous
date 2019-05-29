package redocpot

fun main(args : Array<String>) {
    readLine()!!.toInt()
    val a = readLine()!!.split(" ").map(String::toInt)
    var fm = -1
    var sm = -1
    var cnt = 0
    for (item in a) {
        if (sm > item) {
            ++ cnt
        }
        if (fm == -1) {
            fm = item
        } else if (sm == -1) {
            if (item > fm) {
                sm = fm
                fm = item
            } else {
                sm = item
            }
        } else if (item > fm) {
            sm = fm
            fm = item
        } else if (item > sm) {
            sm = item
        }
    }
    println(cnt)
}
